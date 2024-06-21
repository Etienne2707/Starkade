use starknet::ContractAddress;

fn ZERO() -> starknet::ContractAddress {
    starknet::contract_address_const::<0>()
}

// fn WORLD() -> starknet::ContractAddress {
//     starknet::contract_address_const::<'WORLD'>()
// }
