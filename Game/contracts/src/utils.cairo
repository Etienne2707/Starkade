use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use starknet::{ContractAddress, get_contract_address};



fn ZERO() -> starknet::ContractAddress {
    starknet::contract_address_const::<0>()
}

fn WORLD() -> starknet::ContractAddress {
    starknet::contract_address_const::<'WORLD'>()
}


fn uuid(world: IWorldDispatcher) -> u128 {
    IWorldDispatcherTrait::uuid(world).into()
}