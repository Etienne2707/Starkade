use starknet::ContractAddress;
use dojo::world::IWorldDispatcher;
use dojo_starter::models::player::{Player};
use dojo_starter::models::game::{Game};

// define the interface
#[dojo::interface]
trait IPrivateRoom {
    //fn create_game(ref world : IWorldDispatcher , player_2 : ContractAddress);
    fn leave(ref world : IWorldDispatcher, game_id : u32);
    fn join(ref world : IWorldDispatcher , game_id : u32);
    fn create_player(ref world: IWorldDispatcher);
    fn create_game(ref world: IWorldDispatcher);
    }

// dojo decorator
#[dojo::contract]
mod privateRoom {
    use super::{IPrivateRoom};
    use starknet::{ContractAddress, get_caller_address};
    use dojo_starter::models::{
        game::{Game,GameTrait,GameState}, player::{Player,PlayerTrait,PlayerAssert}
    };

    #[abi(embed_v0)]
    impl PrivateRoomImpl of IPrivateRoom<ContractState> {
        fn create_player(ref world: IWorldDispatcher) {
            let address = get_caller_address();

            let player = get!(world,(address),Player);
            //assert(player.name == 0, 'Erreur player aldready exist !');

            let _name : felt252 = 'Player';
            let player = PlayerTrait::new(address,_name,0);

            set!(world,(player));
        }

        fn create_game(ref world: IWorldDispatcher) {
            // Get the address of the current caller, possibly the player's address.
            let address = get_caller_address();
            let player = get!(world, (address), Player);
            assert(player.name != 0, 'Create a player before a game !');

            let game_id = world.uuid();

            let game = GameTrait::new(game_id,address,starknet::contract_address_const::<0x0>(), GameState::Waiting);
            set!(world,(game));
        }

        fn leave(ref world : IWorldDispatcher, game_id : u32) {
            let address = get_caller_address();

            let mut game = get!(world,(game_id), Game);
            let mut player = get!(world,(address), Player);
            //Add player checker
            assert(player.name != 0, 'Players do not exist !');
            assert(game.player_2 == address || game.player_1 == address, 'Player not in game');
           // assert(game.state == GameState::Locked || game.state == GameState::Waiting && game.game_id != 0 , 'Cant leave now the game !');
            if (game.player_2 == address) {
                game.player_2 = starknet::contract_address_const::<0x0>();
                game.state = GameState::Waiting;
                PlayerTrait::default(player);
                set!(world,(player));
                set!(world,(game));
            } else {
                let second = get!(world,(game.player_2),Player);
                PlayerTrait::default(player);
                PlayerTrait::default(second);
                set!(world,(player));
                set!(world,(second));
                delete!(world,(game));
            }
        }

        fn join(ref world : IWorldDispatcher, game_id : u32) {
            let address = get_caller_address();

            let mut game = get!(world,(game_id), Game);
            let mut player = get!(world,(address), Player);
            //Add player checker
            assert(player.name != 0, 'Players do not exist !');

            let (players_1, _players_2) = game.get_address();

            assert(players_1 != address, 'Try to join the same person');
            assert(game.state == GameState::Waiting , 'Party full !');
            game.player_2 = address;
            game.state = GameState::Locked;
            player.game_id = GameTrait::get_gameid(game);
            set!(world, (game));
        }
    }
}
