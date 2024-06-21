#[derive(Drop, Serde, Copy)]
#[dojo::model]
struct Player {
    #[key]
    player_id: starknet::ContractAddress,
    lobby: u32,
}
