impl DirectionsAvailableIntrospect<> of dojo::database::introspect::Introspect<
    DirectionsAvailable<>
> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::None
    }

    fn layout() -> dojo::database::introspect::Layout {
        dojo::database::introspect::Layout::Struct(
            array![
                dojo::database::introspect::FieldLayout {
                    selector: 293590869758891503479472969692222751884746067748671029651230128884955424455,
                    layout: dojo::database::introspect::Introspect::<Array<Direction>>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::database::introspect::Ty {
        dojo::database::introspect::Ty::Struct(
            dojo::database::introspect::Struct {
                name: 'DirectionsAvailable',
                attrs: array![].span(),
                children: array![
                    dojo::database::introspect::Member {
                        name: 'player',
                        attrs: array!['key'].span(),
                        ty: dojo::database::introspect::Introspect::<ContractAddress>::ty()
                    },
                    dojo::database::introspect::Member {
                        name: 'directions',
                        attrs: array![].span(),
                        ty: dojo::database::introspect::Ty::Array(
                            array![dojo::database::introspect::Introspect::<Direction>::ty()].span()
                        )
                    }
                ]
                    .span()
            }
        )
    }
}

impl DirectionsAvailableModel of dojo::model::Model<DirectionsAvailable> {
    fn entity(
        world: dojo::world::IWorldDispatcher,
        keys: Span<felt252>,
        layout: dojo::database::introspect::Layout
    ) -> DirectionsAvailable {
        let values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            1682888847001728197399857679787030821795438481084909761606663248577735745869,
            keys,
            layout
        );

        // TODO: Generate method to deserialize from keys / values directly to avoid
        // serializing to intermediate array.
        let mut serialized = core::array::ArrayTrait::new();
        core::array::serialize_array_helper(keys, ref serialized);
        core::array::serialize_array_helper(values, ref serialized);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<DirectionsAvailable>::deserialize(ref serialized);

        if core::option::OptionTrait::<DirectionsAvailable>::is_none(@entity) {
            panic!(
                "Model `DirectionsAvailable`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<DirectionsAvailable>::unwrap(entity)
    }

    #[inline(always)]
    fn name() -> ByteArray {
        "DirectionsAvailable"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        1682888847001728197399857679787030821795438481084909761606663248577735745869
    }

    #[inline(always)]
    fn instance_selector(self: @DirectionsAvailable) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn keys(self: @DirectionsAvailable) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.player, ref serialized);
        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @DirectionsAvailable) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.directions, ref serialized);
        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::database::introspect::Layout {
        dojo::database::introspect::Introspect::<DirectionsAvailable>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @DirectionsAvailable) -> dojo::database::introspect::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        let layout = Self::layout();

        match layout {
            dojo::database::introspect::Layout::Fixed(layout) => {
                let mut span_layout = layout;
                Option::Some(dojo::packing::calculate_packed_size(ref span_layout))
            },
            dojo::database::introspect::Layout::Struct(_) => Option::None,
            dojo::database::introspect::Layout::Array(_) => Option::None,
            dojo::database::introspect::Layout::Tuple(_) => Option::None,
            dojo::database::introspect::Layout::Enum(_) => Option::None,
            dojo::database::introspect::Layout::ByteArray => Option::None,
        }
    }
}

#[starknet::interface]
trait Idirections_available<T> {
    fn ensure_abi(self: @T, model: DirectionsAvailable);
}

#[starknet::contract]
mod directions_available {
    use super::DirectionsAvailable;
    use super::Idirections_available;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<DirectionsAvailable>::selector()
        }

        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<DirectionsAvailable>::name()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<DirectionsAvailable>::version()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::database::introspect::Introspect::<DirectionsAvailable>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<DirectionsAvailable>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::database::introspect::Layout {
            dojo::model::Model::<DirectionsAvailable>::layout()
        }

        fn schema(self: @ContractState) -> dojo::database::introspect::Ty {
            dojo::database::introspect::Introspect::<DirectionsAvailable>::ty()
        }
    }

    #[abi(embed_v0)]
    impl directions_availableImpl of Idirections_available<ContractState> {
        fn ensure_abi(self: @ContractState, model: DirectionsAvailable) {}
    }
}
