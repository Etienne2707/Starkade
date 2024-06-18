// define the interface
use core::result::ResultTrait;
use array::{ArrayTrait, SpanTrait};


#[dojo::interface]
trait IActions {
    fn spawn();
    fn paint(x: u16, y: u16, color: felt252);
}


#[dojo::contract]
mod actions {
    use super::{IActions};
    use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
    use boot_camp_paint::models::{tile::{Tile}, player::{Player, Card}};

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(world: IWorldDispatcher) {
            // [get]: get the caller address
            let address = get_caller_address();
            //let hand_card = array::ArrayTrait::<Card>::new();
            // [get]: uuid // built in dojo function for generating a unique id
            let player = world.uuid();

            let existing_player = get!(world, (address), Player);
            let hand_card : u64 = 42;
            assert(existing_player.last_action == 0, 'ACTIONS: player already exists');

            let last_action = get_block_timestamp();

            // [get]: timestamp
            let hand_card = Card {
                player : 42,
            };
            // [set]: create a new player
            set!(world, Player { address, player, last_action, hand_card});
        }

        fn paint(world: IWorldDispatcher, x: u16, y: u16, color: felt252) {
            // [get]: get the caller address
            let address = get_caller_address();

            // [get]: get the player
            let player = get!(world, (address), Player);

            // [assert]: only the player can paint
            assert(player.address == address, 'ACTIONS: not player');

            let player_address = player.address;
            // [set]: create a new tile
            set!(world, Tile { x, y, player_address, color });
        }

    }
}
