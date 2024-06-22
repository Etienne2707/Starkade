impl MovesIntrospect<> of dojo::database::introspect::Introspect<Moves<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        let sizes: Array<Option<usize>> = array![
            dojo::database::introspect::Introspect::<Direction>::size(), Option::Some(2)
        ];

        if dojo::database::utils::any_none(@sizes) {
            return Option::None;
        }
        Option::Some(dojo::database::utils::sum(sizes))
    }

    fn layout() -> dojo::database::introspect::Layout {
        dojo::database::introspect::Layout::Struct(
            array![
                dojo::database::introspect::FieldLayout {
                    selector: 1273202716184110461309950588744971371786343523615484140556571829139478425878,
                    layout: dojo::database::introspect::Introspect::<u8>::layout()
                },
                dojo::database::introspect::FieldLayout {
                    selector: 1595627883669228919392807819623295121095492565043100769689803993713402472866,
                    layout: dojo::database::introspect::Introspect::<Direction>::layout()
                },
                dojo::database::introspect::FieldLayout {
                    selector: 1492363334513396880525112599442604757171887437485668658151980696493031060964,
                    layout: dojo::database::introspect::Introspect::<bool>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::database::introspect::Ty {
        dojo::database::introspect::Ty::Struct(
            dojo::database::introspect::Struct {
                name: 'Moves',
                attrs: array![].span(),
                children: array![
                    dojo::database::introspect::Member {
                        name: 'player',
                        attrs: array!['key'].span(),
                        ty: dojo::database::introspect::Introspect::<ContractAddress>::ty()
                    },
                    dojo::database::introspect::Member {
                        name: 'remaining',
                        attrs: array![].span(),
                        ty: dojo::database::introspect::Introspect::<u8>::ty()
                    },
                    dojo::database::introspect::Member {
                        name: 'last_direction',
                        attrs: array![].span(),
                        ty: dojo::database::introspect::Introspect::<Direction>::ty()
                    },
                    dojo::database::introspect::Member {
                        name: 'can_move',
                        attrs: array![].span(),
                        ty: dojo::database::introspect::Introspect::<bool>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}

impl MovesModel of dojo::model::Model<Moves> {
    fn entity(
        world: dojo::world::IWorldDispatcher,
        keys: Span<felt252>,
        layout: dojo::database::introspect::Layout
    ) -> Moves {
        let values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            446410304847380295714322413629338639308352896980121750641115120498623632807,
            keys,
            layout
        );

        // TODO: Generate method to deserialize from keys / values directly to avoid
        // serializing to intermediate array.
        let mut serialized = core::array::ArrayTrait::new();
        core::array::serialize_array_helper(keys, ref serialized);
        core::array::serialize_array_helper(values, ref serialized);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<Moves>::deserialize(ref serialized);

        if core::option::OptionTrait::<Moves>::is_none(@entity) {
            panic!(
                "Model `Moves`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<Moves>::unwrap(entity)
    }

    #[inline(always)]
    fn name() -> ByteArray {
        "Moves"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        446410304847380295714322413629338639308352896980121750641115120498623632807
    }

    #[inline(always)]
    fn instance_selector(self: @Moves) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn keys(self: @Moves) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.player, ref serialized);
        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @Moves) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.remaining, ref serialized);
        core::serde::Serde::serialize(self.last_direction, ref serialized);
        core::serde::Serde::serialize(self.can_move, ref serialized);
        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::database::introspect::Layout {
        dojo::database::introspect::Introspect::<Moves>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @Moves) -> dojo::database::introspect::Layout {
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
trait Imoves<T> {
    fn ensure_abi(self: @T, model: Moves);
}

#[starknet::contract]
mod moves {
    use super::Moves;
    use super::Imoves;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<Moves>::selector()
        }

        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Moves>::name()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<Moves>::version()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::database::introspect::Introspect::<Moves>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<Moves>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::database::introspect::Layout {
            dojo::model::Model::<Moves>::layout()
        }

        fn schema(self: @ContractState) -> dojo::database::introspect::Ty {
            dojo::database::introspect::Introspect::<Moves>::ty()
        }
    }

    #[abi(embed_v0)]
    impl movesImpl of Imoves<ContractState> {
        fn ensure_abi(self: @ContractState, model: Moves) {}
    }
}
