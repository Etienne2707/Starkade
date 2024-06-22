use starknet::ContractAddress;


#[derive(Copy, Drop, Serde)]
#[dojo::model]
struct Game {
    #[key]
    game_id : u128,
    player_1 : ContractAddress,
    player_2 : ContractAddress,
    state : GameState,
}

#[derive(Serde, Copy, Drop, Introspect, PartialEq)]
enum GameState {
    Waiting,
    Lock,
    Running,
    Finish,
}



#[generate_trait]
impl GameImpl of GameTrait {

    #[inline(always)]
    fn new(game_id : u128, player_1 : ContractAddress, player_2 : ContractAddress, state : GameState) -> Game {
        Game { game_id , player_1, player_2, state}
    }

    #[inline(always)]
    fn get_gameid(self : Game) -> u128 {
        return self.game_id;
    }

    #[inline(always)]
    fn get_address(self : Game) -> (ContractAddress, ContractAddress) {
        (self.player_1, self.player_2)
    }
}



// #[generate_trait]
// impl GameAssert of AssertTrait {
//     #[inline(always)]
//     fn assert_does_exist(player: Player) {
//         assert(player.is_non_zero(), errors::PLAYER_DOES_NOT_EXIST);
//     }

//     #[inline(always)]
//     fn assert_not_exist(player: Player) {
//         assert(player.is_zero(), errors::PLAYER_ALREADY_EXIST);
//     } 
// }
