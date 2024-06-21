#[derive(Drop, Serde, Copy)]
#[dojo::model]
struct Lobby {
    #[key]
    lobby_id: u32,
    player1: starknet::ContractAddress,
    player2: starknet::ContractAddress,
}
