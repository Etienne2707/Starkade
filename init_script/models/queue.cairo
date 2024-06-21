#[derive(Drop, Serde, Copy)]
#[dojo::model]
struct Queue {
    #[key]
    queue_id: felt252,
    player: starknet::ContractAddress,
}
