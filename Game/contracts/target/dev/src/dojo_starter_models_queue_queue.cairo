impl QueueIntrospect<> of dojo::database::introspect::Introspect<Queue<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        dojo::database::introspect::Introspect::<starknet::ContractAddress>::size()
    }

    fn layout() -> dojo::database::introspect::Layout {
        dojo::database::introspect::Layout::Struct(
            array![
                dojo::database::introspect::FieldLayout {
                    selector: 1098270066491116190282055750450635314779893037377829913802378543145503521993,
                    layout: dojo::database::introspect::Introspect::<
                        starknet::ContractAddress
                    >::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::database::introspect::Ty {
        dojo::database::introspect::Ty::Struct(
            dojo::database::introspect::Struct {
                name: 'Queue',
                attrs: array![].span(),
                children: array![
                    dojo::database::introspect::Member {
                        name: 'queue_id',
                        attrs: array!['key'].span(),
                        ty: dojo::database::introspect::Introspect::<felt252>::ty()
                    },
                    dojo::database::introspect::Member {
                        name: 'player',
                        attrs: array![].span(),
                        ty: dojo::database::introspect::Introspect::<
                            starknet::ContractAddress
                        >::ty()
                    }
                ]
                    .span()
            }
        )
    }
}

impl QueueModel of dojo::model::Model<Queue> {
    fn entity(
        world: dojo::world::IWorldDispatcher,
        keys: Span<felt252>,
        layout: dojo::database::introspect::Layout
    ) -> Queue {
        let values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            979015426794864522223772137956691222477966787626778805776708053953142188570,
            keys,
            layout
        );

        // TODO: Generate method to deserialize from keys / values directly to avoid
        // serializing to intermediate array.
        let mut serialized = core::array::ArrayTrait::new();
        core::array::serialize_array_helper(keys, ref serialized);
        core::array::serialize_array_helper(values, ref serialized);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<Queue>::deserialize(ref serialized);

        if core::option::OptionTrait::<Queue>::is_none(@entity) {
            panic!(
                "Model `Queue`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<Queue>::unwrap(entity)
    }

    #[inline(always)]
    fn name() -> ByteArray {
        "Queue"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        979015426794864522223772137956691222477966787626778805776708053953142188570
    }

    #[inline(always)]
    fn instance_selector(self: @Queue) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn keys(self: @Queue) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, *self.queue_id);
        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @Queue) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.player, ref serialized);
        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::database::introspect::Layout {
        dojo::database::introspect::Introspect::<Queue>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @Queue) -> dojo::database::introspect::Layout {
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
trait Iqueue<T> {
    fn ensure_abi(self: @T, model: Queue);
}

#[starknet::contract]
mod queue {
    use super::Queue;
    use super::Iqueue;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<Queue>::selector()
        }

        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Queue>::name()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<Queue>::version()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::database::introspect::Introspect::<Queue>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<Queue>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::database::introspect::Layout {
            dojo::model::Model::<Queue>::layout()
        }

        fn schema(self: @ContractState) -> dojo::database::introspect::Ty {
            dojo::database::introspect::Introspect::<Queue>::ty()
        }
    }

    #[abi(embed_v0)]
    impl queueImpl of Iqueue<ContractState> {
        fn ensure_abi(self: @ContractState, model: Queue) {}
    }
}
