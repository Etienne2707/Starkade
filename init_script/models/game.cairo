use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
#[dojo::model]
struct Game {
    #[key]
    game_id : u32,
    player_1 : ContractAddress,
    player_2 : ContractAddress,
    state : GameState,
}

#[derive(Serde, Copy, Drop, Introspect, PartialEq)]
enum GameState {
    Waiting,
    Locked,
    Running,
    Done,
}

#[generate_trait]
impl GameImpl of GameTrait {

    #[inline(always)]
    fn new(game_id : u32, player_1 : ContractAddress, player_2 : ContractAddress, state : GameState) -> Game {
        Game { game_id , player_1, player_2, state}
    }

    #[inline(always)]
    fn get_gameid(self : Game) -> u32 {
        return self.game_id;
    }

    #[inline(always)]
    fn get_address(self : Game) -> (ContractAddress, ContractAddress) {
        (self.player_1, self.player_2)
    }
}
