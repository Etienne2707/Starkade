use starknet::ContractAddress;
use dojo_starter::utils::{ZERO};

mod errors {
    const PLAYER_DOES_NOT_EXIST: felt252 = 'Player: does not exist';
    const PLAYER_ALREADY_EXIST: felt252 = 'Player: already exist';
    const PLAYER_NOT_SUBSCRIBABLE: felt252 = 'Player: not subscribable';
    const PLAYER_NOT_SUBSCRIBED: felt252 = 'Player: not subscribed';
}

#[derive(Copy, Drop, Serde)]
#[dojo::model]
struct Player {
    #[key]
    address : ContractAddress,
    name : felt252,
    game_id : u128,
}

#[generate_trait]
impl PlayerImpl of PlayerTrait {

    #[inline(always)]
    fn new(address: ContractAddress, name: felt252, game_id : u128) -> Player {
        Player { address , name, game_id}
    }

    #[inline(always)]
    fn get_gameid(self : Player) -> u128 {
        return self.game_id;
    }

    #[inline(always)]
    fn get_name(self : Player) -> felt252 {
        return self.name;
    }

    #[inline(always)] 
    fn default(self : Player) -> Player {
        Self::new(self.address, self.name, 0)
    }


}


#[generate_trait]
impl PlayerAssert of AssertTrait {
    #[inline(always)]
    fn assert_does_exist(player: Player) {
        assert(player.is_non_zero(), errors::PLAYER_DOES_NOT_EXIST);
    }

    #[inline(always)]
    fn assert_not_exist(player: Player) {
        assert(player.is_zero(), errors::PLAYER_ALREADY_EXIST);
    } 
}

impl PlayerZeroable of Zeroable<Player> {
    #[inline(always)]
    fn zero() -> Player {
        Player { address: ZERO(), name: 0, game_id : 0}
    }
    #[inline(always)]
    fn is_zero(self : Player) -> bool {
        self.name == 0 && self.game_id == 0

    }
    #[inline(always)]
    fn is_non_zero(self: Player) -> bool {
        !self.is_zero()
    }
}