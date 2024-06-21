mod setup {
    // Core imports

    use core::debug::PrintTrait;

    // Starknet imports

    use starknet::ContractAddress;
    use starknet::testing::{set_contract_address};

    // Dojo imports

    use dojo::world::{IWorldDispatcherTrait, IWorldDispatcher};
    use dojo_starter::models::{
        position::{Position, Vec2}, moves::{Moves, Direction}, game::{Game}, player::{Player}
    };

    use dojo_starter::systems::actions::{actions, IActionsDispatcher, IActionsDispatcherTrait};
    // Internal imports
    use dojo::test_utils::{spawn_test_world, deploy_contract};

    // Constants

    fn PLAYER() -> ContractAddress {
        starknet::contract_address_const::<'PLAYER'>()
    }

    fn PLAYER2() -> ContractAddress {
        starknet::contract_address_const::<'PLAYER2'>()
    }

    fn SOMEONE() -> ContractAddress {
        starknet::contract_address_const::<'SOMEONE'>()
    }



    const PLAYER_NAME: felt252 = 'PLAYER';
    const SOMEONE_NAME: felt252 = 'SOMEONE';
    const REGISTRY_ID: u128 = 0;

    #[derive(Drop)]
    struct Systems {
        actions: IActionsDispatcher,
    }

    #[derive(Drop)]
    struct Context {
        game_id: u128,
        player_id: ContractAddress,
        someone_id: ContractAddress,
        player_name: felt252,
        someone_name: felt252,
    }


    #[inline(always)]
    fn spawn() -> (IWorldDispatcher, Systems, Context) {
        // [Setup] World
        let mut models = core::array::ArrayTrait::new();
        models.append(dojo_starter::models::player::player::TEST_CLASS_HASH);
        models.append(dojo_starter::models::game::game::TEST_CLASS_HASH);

        let world = spawn_test_world(models);

        // [Setup] Systems
        let actions_address = deploy_contract(actions::TEST_CLASS_HASH, array![].span());
        let systems = Systems { actions: IActionsDispatcher { contract_address: actions_address }, };

        // [Setup] Context
        set_contract_address(SOMEONE());
        systems.actions.create_player(SOMEONE_NAME);
        systems.actions.create_player(SOMEONE_NAME);
        set_contract_address(PLAYER());
        let context = Context {
            game_id: REGISTRY_ID,
            player_id: PLAYER(),
            someone_id: SOMEONE(),
            player_name: PLAYER_NAME,
            someone_name: SOMEONE_NAME,
        };

        // [Return]
        (world, systems, context)
    }

}