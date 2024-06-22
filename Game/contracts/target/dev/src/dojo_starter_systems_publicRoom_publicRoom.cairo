#[starknet::contract]
mod publicRoom {
    use dojo::world;
    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;
    use dojo::world::IWorldProvider;
    use dojo::world::IDojoResourceProvider;


    component!(
        path: dojo::components::upgradeable::upgradeable,
        storage: upgradeable,
        event: UpgradeableEvent
    );

    #[abi(embed_v0)]
    impl DojoResourceProviderImpl of IDojoResourceProvider<ContractState> {
        fn dojo_resource(self: @ContractState) -> felt252 {
            'publicRoom'
        }
    }

    #[abi(embed_v0)]
    impl WorldProviderImpl of IWorldProvider<ContractState> {
        fn world(self: @ContractState) -> IWorldDispatcher {
            self.world_dispatcher.read()
        }
    }

    #[abi(embed_v0)]
    impl UpgradableImpl =
        dojo::components::upgradeable::upgradeable::UpgradableImpl<ContractState>;

    use super::{IPublicRoom};
    use starknet::{ContractAddress, get_caller_address};
    use dojo_starter::models::{player::{Player}, queue::{Queue}, game::{Game, GameState}//     position::{Position, Vec2}, moves::{Moves, Direction, DirectionsAvailable}
    };

    #[abi(embed_v0)]
    impl PublicRoomImpl of IPublicRoom<ContractState> {
        fn register(ref self: ContractState, name: felt252) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();
            let queue = get!(world, 0, Queue);
            assert(player != queue.player, 'Player is already registered');
            if queue.player == starknet::contract_address_const::<0x0>() {
                set!(world, Queue { queue_id: 0, player: player });
            } else {
                set!(
                    world, Queue { queue_id: 0, player: starknet::contract_address_const::<0x0>() }
                );
                let game = world.uuid();
                set!(
                    world,
                    Game {
                        game_id: game,
                        player_1: queue.player,
                        player_2: player,
                        state: GameState::Locked
                    }
                );
                set!(world, Player { address: queue.player, name: name, game_id: game });
                set!(world, Player { address: player, name: name, game_id: game });
            }
        }

        fn unregister(ref self: ContractState) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();
            let queue = get!(world, 0, Queue);
            assert(player == queue.player, 'Player is not registered');
            set!(world, Queue { queue_id: 0, player: starknet::contract_address_const::<0x0>() });
        }
    }

    #[starknet::interface]
    trait IDojoInit<ContractState> {
        fn dojo_init(self: @ContractState);
    }

    #[abi(embed_v0)]
    impl IDojoInitImpl of IDojoInit<ContractState> {
        fn dojo_init(self: @ContractState) {
            assert(
                starknet::get_caller_address() == self.world().contract_address,
                'Only world can init'
            );
        }
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        UpgradeableEvent: dojo::components::upgradeable::upgradeable::Event,
    }

    #[storage]
    struct Storage {
        world_dispatcher: IWorldDispatcher,
        #[substorage(v0)]
        upgradeable: dojo::components::upgradeable::upgradeable::Storage,
    }
}

