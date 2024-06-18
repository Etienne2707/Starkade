// Configuration
use dojo::database::introspect::{  Enum, Member, Ty, Struct, Introspect};
use array::{ArrayTrait, SpanTrait};


const TIME_BETWEEN_ACTIONS: u64 = 120;

#[derive(Model, Copy, Drop, Serde)]
#[dojo::model]
struct Player {
    #[key]
    address: starknet::ContractAddress,
    player: u32,
    last_action: u64,
    hand_card : Card
}


#[derive(Serde, Copy, Drop, Introspect)]
struct Card {
    player : u32,
}


#[generate_trait]
impl PlayerImpl of PlayerTrait {
    fn check_can_place(self: Player) {
        if starknet::get_block_timestamp() - self.last_action < TIME_BETWEEN_ACTIONS {
            panic!("Not enough time has passed since the last action");
        }
    }
}
