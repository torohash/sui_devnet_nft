module register_service::register {
    use sui::tx_context::{Self, TxContext};
    // use sui::table;
    use sui::object::{Self, UID};
    use sui::dynamic_object_field as ofield;
    use sui::transfer;

    struct Parent has key {
        id: UID
    }

    struct Child has key, store {
        id: UID,
        count: u64,
    }

    fun init(ctx: &mut TxContext) {
        let parent = Parent {
            id: object::new(ctx),
        };

        let child = Child {
            id: object::new(ctx),
            count: 0,
        };

        let child2 = Child {
            id: object::new(ctx),
            count: 0,
        };

        transfer::transfer(parent, tx_context::sender(ctx));
        transfer::transfer(child, tx_context::sender(ctx));
        transfer::transfer(child2, tx_context::sender(ctx));
    }

    public entry fun add_child(parent: &mut Parent, child: Child, name: vector<u8>) {
        ofield::add(&mut parent.id, name, child);
    }
}