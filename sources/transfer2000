module test::transfer2000 {
    use std::signer;
    use std::vector;
    use aptos_framework::object;
    use aptos_framework::object::{Object};

    struct MyObject has key, store {
        value: u64
    }

    struct MyObjects has key, store {
        vec: vector<MyObject>
    }

    struct ObjectController has key {
        delete_ref: object::DeleteRef,
    }

    public fun create_object(): MyObject {

        let object = MyObject {
                value: 1
            };

        object
    }

    public entry fun create_2000_wrapped_transferred(account: &signer) {
        let caller_address = signer::address_of(account);
        let constructor_ref = object::create_object(caller_address);
        let object_signer = object::generate_signer(&constructor_ref);
        let delete_ref = object::generate_delete_ref(&constructor_ref);

        let vec = vector::empty<MyObject>();
        let k:u64 = 0;
        while (k < 2000) {
            vector::push_back(&mut vec, create_object());
            k = k + 1;
        };

        let objects = MyObjects {
            vec: vec,
        };

        move_to(&object_signer, ObjectController {delete_ref});
        move_to(&object_signer, objects)

    }


    public entry fun transfer2000(account: &signer) {

        let k:u64 = 0;
        while (k < 2000) {

            let caller_address = signer::address_of(account);
            let constructor_ref = object::create_object(caller_address);
            let object_signer = object::generate_signer(&constructor_ref);
            let delete_ref = object::generate_delete_ref(&constructor_ref);

            move_to(&object_signer, ObjectController {delete_ref});
            move_to(&object_signer, create_object());

            k = k + 1;
        };
    }
}
