impl MovedIntrospect<> of dojo::database::introspect::Introspect<Moved<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        dojo::database::introspect::Introspect::<Direction>::size()
    }

    fn layout() -> dojo::database::introspect::Layout {
        dojo::database::introspect::Layout::Struct(
            array![
                dojo::database::introspect::FieldLayout {
                    selector: 614499057413201613508653200066187686724488589622048075426255068221310241069,
                    layout: dojo::database::introspect::Introspect::<Direction>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::database::introspect::Ty {
        dojo::database::introspect::Ty::Struct(
            dojo::database::introspect::Struct {
                name: 'Moved',
                attrs: array![].span(),
                children: array![
                    dojo::database::introspect::Member {
                        name: 'player',
                        attrs: array!['key'].span(),
                        ty: dojo::database::introspect::Introspect::<ContractAddress>::ty()
                    },
                    dojo::database::introspect::Member {
                        name: 'direction',
                        attrs: array![].span(),
                        ty: dojo::database::introspect::Introspect::<Direction>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}
impl MovedIsEvent of starknet::Event<Moved> {
    fn append_keys_and_data(self: @Moved, ref keys: Array<felt252>, ref data: Array<felt252>) {
        core::array::ArrayTrait::append(ref keys, selector!("Moved"));

        core::serde::Serde::serialize(self.player, ref keys);
        core::serde::Serde::serialize(self.direction, ref data);
    }
    fn deserialize(ref keys: Span<felt252>, ref data: Span<felt252>,) -> Option<Moved> {
        let player = core::serde::Serde::deserialize(ref keys)?;
        let direction = core::serde::Serde::deserialize(ref data)?;
        Option::Some(Moved { player, direction, })
    }
}

impl MovedModel of dojo::model::Model<Moved> {
    fn entity(
        world: dojo::world::IWorldDispatcher,
        keys: Span<felt252>,
        layout: dojo::database::introspect::Layout
    ) -> Moved {
        let values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            1369467712407636214100268892059328807375376803474704869247119486398688558876,
            keys,
            layout
        );

        // TODO: Generate method to deserialize from keys / values directly to avoid
        // serializing to intermediate array.
        let mut serialized = core::array::ArrayTrait::new();
        core::array::serialize_array_helper(keys, ref serialized);
        core::array::serialize_array_helper(values, ref serialized);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<Moved>::deserialize(ref serialized);

        if core::option::OptionTrait::<Moved>::is_none(@entity) {
            panic!(
                "Model `Moved`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<Moved>::unwrap(entity)
    }

    #[inline(always)]
    fn name() -> ByteArray {
        "Moved"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        1369467712407636214100268892059328807375376803474704869247119486398688558876
    }

    #[inline(always)]
    fn instance_selector(self: @Moved) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn keys(self: @Moved) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.player, ref serialized);
        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @Moved) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.direction, ref serialized);
        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::database::introspect::Layout {
        dojo::database::introspect::Introspect::<Moved>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @Moved) -> dojo::database::introspect::Layout {
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
trait Imoved<T> {
    fn ensure_abi(self: @T, model: Moved);
}

#[starknet::contract]
mod moved {
    use super::Moved;
    use super::Imoved;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<Moved>::selector()
        }

        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Moved>::name()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<Moved>::version()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::database::introspect::Introspect::<Moved>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<Moved>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::database::introspect::Layout {
            dojo::model::Model::<Moved>::layout()
        }

        fn schema(self: @ContractState) -> dojo::database::introspect::Ty {
            dojo::database::introspect::Introspect::<Moved>::ty()
        }
    }

    #[abi(embed_v0)]
    impl movedImpl of Imoved<ContractState> {
        fn ensure_abi(self: @ContractState, model: Moved) {}
    }
}
