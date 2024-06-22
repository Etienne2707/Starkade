use dojo_starter::models::player::Player;
use dojo_starter::models::queue::Queue;
use dojo_starter::models::game::Game;

// define the interface
#[dojo::interface]
trait IPublicRoom {
    fn register(ref world: IWorldDispatcher, name: felt252);
    fn unregister(ref world: IWorldDispatcher);
}

// dojo decorator
#[dojo::contract]
mod publicRoom {
    use super::{IPublicRoom};
    use starknet::{ContractAddress, get_caller_address};
    use dojo_starter::models::{
        player::{Player}, queue::{Queue}, game::{Game, GameState}
    //     position::{Position, Vec2}, moves::{Moves, Direction, DirectionsAvailable}
    };

    #[abi(embed_v0)]
    impl PublicRoomImpl of IPublicRoom<ContractState> {
        fn register(ref world: IWorldDispatcher, name: felt252) {
            let player = get_caller_address();
            let queue = get!(world, 0, Queue);
            assert(player != queue.player, 'Player is already registered');
            if queue.player == starknet::contract_address_const::<0x0>() {
                set!(world, Queue { queue_id : 0, player : player });
            } else {
                set!(world, Queue { queue_id : 0, player : starknet::contract_address_const::<0x0>() });
                let game = world.uuid();
                set!(world, Game { game_id : game, player_1 : queue.player, player_2 : player, state: GameState::Locked });
                set!(world, Player { address : queue.player, name: name, game_id : game });
                set!(world, Player { address : player, name: name, game_id : game });
            }
        }

        fn unregister(ref world: IWorldDispatcher) {
            let player = get_caller_address();
            let queue = get!(world, 0, Queue);
            assert(player == queue.player, 'Player is not registered');
            set!(world, Queue { queue_id : 0, player : starknet::contract_address_const::<0x0>() });
        }
    }
}
