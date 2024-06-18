#[derive(Copy, Drop, Serde)]
#[dojo::model]
struct Tile {
    #[key]
    x: u16,
    #[key]
    y: u16,
    #[key]
    player_address: starknet::ContractAddress,
    color: felt252
}
