use dojo_starter::models::player::Player;
use dojo_starter::models::queue::Queue;
use dojo_starter::models::lobby::Lobby;

// define the interface
#[dojo::interface]
trait IMatchmaking {
    fn register(ref world: IWorldDispatcher);
    fn unregister(ref world: IWorldDispatcher);
}

// dojo decorator
#[dojo::contract]
mod matchmaking {
    use super::{IMatchmaking};
    use starknet::{ContractAddress, get_caller_address};
    use dojo_starter::models::{
        player::{Player}, queue::{Queue}, lobby::{Lobby}
    //     position::{Position, Vec2}, moves::{Moves, Direction, DirectionsAvailable}
    };

    #[abi(embed_v0)]
    impl MatchmakingImpl of IMatchmaking<ContractState> {
        fn register(ref world: IWorldDispatcher) {
            let player = get_caller_address();
            let queue = get!(world, 0, Queue);
            assert(player != queue.player, 'Player is already registered');
            if queue.player == starknet::contract_address_const::<0x0>() {
                set!(world, Queue { queue_id : 0, player : player });
            } else {
                set!(world, Queue { queue_id : 0, player : starknet::contract_address_const::<0x0>() });
                let lobby = world.uuid();
                set!(world, Lobby { lobby_id : lobby, player1 : queue.player, player2 : player });
                set!(world, Player { player_id : queue.player, lobby : lobby });
                set!(world, Player { player_id : player, lobby : lobby });
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
