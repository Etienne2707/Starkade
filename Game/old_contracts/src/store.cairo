use core::debug::PrintTrait;

// Straknet imports

use starknet::ContractAddress;

// Dojo imports

use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};


use dojo_starter::models::{
    position::{Position, Vec2}, moves::{Moves, Direction}, game::{Game}, player::{Player,PlayerTrait}
};

#[derive(Copy, Drop)]
struct Store {
    world: IWorldDispatcher,
}

#[generate_trait]
impl StoreImpl of StoreTrait {
    #[inline(always)]
    fn new(world: IWorldDispatcher) -> Store {
        Store { world: world }
    }

    #[inline(always)]
    fn player(self: Store, player_id: ContractAddress) -> Player {
        get!(self.world, (player_id), (Player))
    }

    #[inline(always)]
    fn game(self : Store, game_id : u128) -> Game {
        get!(self.world, (game_id), (Game))
    }

    #[inline(always)]
    fn set_player(self : Store , player : Player) {
        set!(self.world, (player))
    }

    #[inline(always)]
    fn set_game(self : Store , game : Game) {
        set!(self.world, (game))
    }




}

