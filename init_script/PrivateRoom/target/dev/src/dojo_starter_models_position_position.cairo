impl PositionIntrospect<> of dojo::database::introspect::Introspect<Position<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        dojo::database::introspect::Introspect::<Vec2>::size()
    }

    fn layout() -> dojo::database::introspect::Layout {
        dojo::database::introspect::Layout::Struct(
            array![
                dojo::database::introspect::FieldLayout {
                    selector: 247248194623650132620478622545404668823358764480900918784997249460570106970,
                    layout: dojo::database::introspect::Introspect::<Vec2>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::database::introspect::Ty {
        dojo::database::introspect::Ty::Struct(
            dojo::database::introspect::Struct {
                name: 'Position',
                attrs: array![].span(),
                children: array![
                    dojo::database::introspect::Member {
                        name: 'player',
                        attrs: array!['key'].span(),
                        ty: dojo::database::introspect::Introspect::<ContractAddress>::ty()
                    },
                    dojo::database::introspect::Member {
                        name: 'vec',
                        attrs: array![].span(),
                        ty: dojo::database::introspect::Introspect::<Vec2>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}

impl PositionModel of dojo::model::Model<Position> {
    fn entity(
        world: dojo::world::IWorldDispatcher,
        keys: Span<felt252>,
        layout: dojo::database::introspect::Layout
    ) -> Position {
        let values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            71955415935911354973604243446792437686714331401564029050333759332065302780,
            keys,
            layout
        );

        // TODO: Generate method to deserialize from keys / values directly to avoid
        // serializing to intermediate array.
        let mut serialized = core::array::ArrayTrait::new();
        core::array::serialize_array_helper(keys, ref serialized);
        core::array::serialize_array_helper(values, ref serialized);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<Position>::deserialize(ref serialized);

        if core::option::OptionTrait::<Position>::is_none(@entity) {
            panic!(
                "Model `Position`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<Position>::unwrap(entity)
    }

    #[inline(always)]
    fn name() -> ByteArray {
        "Position"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        71955415935911354973604243446792437686714331401564029050333759332065302780
    }

    #[inline(always)]
    fn instance_selector(self: @Position) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn keys(self: @Position) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.player, ref serialized);
        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @Position) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.vec, ref serialized);
        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::database::introspect::Layout {
        dojo::database::introspect::Introspect::<Position>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @Position) -> dojo::database::introspect::Layout {
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
trait Iposition<T> {
    fn ensure_abi(self: @T, model: Position);
}

#[starknet::contract]
mod position {
    use super::Position;
    use super::Iposition;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<Position>::selector()
        }

        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Position>::name()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<Position>::version()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::database::introspect::Introspect::<Position>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<Position>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::database::introspect::Layout {
            dojo::model::Model::<Position>::layout()
        }

        fn schema(self: @ContractState) -> dojo::database::introspect::Ty {
            dojo::database::introspect::Introspect::<Position>::ty()
        }
    }

    #[abi(embed_v0)]
    impl positionImpl of Iposition<ContractState> {
        fn ensure_abi(self: @ContractState, model: Position) {}
    }
}
