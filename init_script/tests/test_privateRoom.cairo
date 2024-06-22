#[cfg(test)]
mod tests {
    use starknet::class_hash::Felt252TryIntoClassHash;
    // import world dispatcher
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    // import test utils
    use dojo::test_utils::{spawn_test_world, deploy_contract};
    // import test utils
    use dojo_starter::{
        systems::{privateRoom::{privateRoom, IPrivateRoomDispatcher, IPrivateRoomDispatcherTrait}},
        models::{game::{Game,GameTrait,GameState,game}, player::{Player,PlayerTrait,PlayerAssert,player}}
    };

    #[test]
    fn test_world() {

        let player_1 = starknet::contract_address_const::<0x10>();
        let player_2 = starknet::contract_address_const::<0x15>();
        let player_3 = starknet::contract_address_const::<0x20>();


        let mut models = array![game::TEST_CLASS_HASH, player::TEST_CLASS_HASH];

        let world = spawn_test_world(models);


        let contract_address = world
            .deploy_contract('salt', privateRoom::TEST_CLASS_HASH.try_into().unwrap(), array![].span());
        let actions_system = IPrivateRoomDispatcher { contract_address };


        let A = actions_system.create_player(player_1);
        let B = actions_system.create_player(player_2);
        let C = actions_system.create_player(player_3);

        assert(A.get_name() != 0, 'Name errure');
        assert(B.get_name() != 0, 'Name errure 2');


        let game = actions_system.create_game(player_1);
        let gameId = A.get_gameid();
        assert(game.game_id == gameId, 'Erreyr de gameId');
        assert(game.player_1 == player_1, 'Erreur player 1 not in game');
        actions_system.join(player_2,gameId);
        let game = get!(world , (gameId), Game);
        assert(game.player_2 == player_2, 'PLayer 2 join error');
        assert(game.state == GameState::Locked, 'Game full but not locked');
        actions_system.leave(player_2,gameId);
        let game = get!(world , (gameId), Game);
        let B = get!(world,(player_2), Player);
        assert(game.player_2 == starknet::contract_address_const::<0x0>(), 'Not reset player 2 after leave');
        assert(B.game_id == 0, 'PLayer 2 game_id no reset');
        actions_system.join(player_3, gameId);
        let game = get!(world , (gameId), Game);
        assert(game.player_2 == C.address, 'Player 3 join no update');
        actions_system.leave(player_1,gameId);
        let game = get!(world , (gameId), Game);
        assert(game.game_id == 0 && game.player_1 == starknet::contract_address_const::<0x0>() && game.player_2 == starknet::contract_address_const::<0x0>(), 'Allez');
       // actions_system.leave(player_2,gameId);

        //actions_system.join(player_3,gameId);

    }

    #[test]
    #[should_panic]
    fn same_player_created() {

        let player_1 = starknet::contract_address_const::<0x10>();

        let mut models = array![game::TEST_CLASS_HASH, player::TEST_CLASS_HASH];

        let world = spawn_test_world(models);


        let contract_address = world
            .deploy_contract('salt', privateRoom::TEST_CLASS_HASH.try_into().unwrap(), array![].span());
        let actions_system = IPrivateRoomDispatcher { contract_address };


        actions_system.create_player(player_1);
        actions_system.create_player(player_1);        

    }
}
