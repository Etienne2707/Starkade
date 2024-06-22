#[starknet::contract]
mod actions {
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
            'actions'
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

    use super::{IActions};
    use starknet::{ContractAddress, get_caller_address};
    use dojo_starter::models::{
        game::{Game, GameTrait, GameState}, player::{Player, PlayerTrait, PlayerAssert}
    };
    use dojo_starter::utils::{uuid};

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn create_player(ref self: ContractState) {
            let world = self.world_dispatcher.read();
            let address = get_caller_address();
            let player = get!(world, (address), Player);
            //assert(player.name == 0, 'Erreur player aldready exist !');

            let _name: felt252 = 'Player';
            let player = PlayerTrait::new(address, _name, 0);

            set!(world, (player));
        }
        fn create_game(ref self: ContractState) {
            let world = self.world_dispatcher.read();
            // Get the address of the current caller, possibly the player's address.
            let address = get_caller_address();
            let player = get!(world, (address), Player);
            assert(player.name != 0, 'Create a player before a game !');

            let game_id = uuid(world);

            let game = GameTrait::new(
                game_id, address, starknet::contract_address_const::<0x0>(), GameState::Waiting
            );
            set!(world, (game));
        }

        fn leave(ref self: ContractState, game_id: u128) {
            let world = self.world_dispatcher.read();
            let address = get_caller_address();
            let mut game = get!(world, (game_id), Game);
            let mut player = get!(world, (address), Player);
            //Add player checker
            assert(player.name != 0, 'Players do not exist !');
            assert(game.player_2 == address || game.player_1 == address, 'Player not in game');
            // assert(game.state == GameState::Lock || game.state == GameState::Waiting &&
            // game.game_id != 0 , 'Cant leave now the game !');
            if (game.player_2 == address) {
                game.player_2 = starknet::contract_address_const::<0x0>();
                game.state = GameState::Waiting;
                PlayerTrait::default(player);
                set!(world, (player));
                set!(world, (game));
            } else {
                let second = get!(world, (game.player_2), Player);
                PlayerTrait::default(player);
                PlayerTrait::default(second);
                set!(world, (player));
                set!(world, (second));
                delete!(world, (game));
            }
        }

        fn join(ref self: ContractState, game_id: u128) {
            let world = self.world_dispatcher.read();

            let address = get_caller_address();
            let mut game = get!(world, (game_id), Game);
            let mut player = get!(world, (address), Player);
            //Add player checker
            assert(player.name != 0, 'Players do not exist !');

            let (players_1, _players_2) = game.get_address();

            assert(players_1 != address, 'Try to join the same person');
            assert(game.state == GameState::Waiting, 'Party full !');
            game.player_2 = address;
            game.state = GameState::Lock;
            player.game_id = GameTrait::get_gameid(game);
            set!(world, (game));
        }
    // Implementation of the move function for the ContractState struct.

    // Retrieve the player's current position and moves data from the world.

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

