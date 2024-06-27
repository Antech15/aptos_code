module test::delete_object2 {
    use std::signer;
    use std::vector;
    use aptos_framework::object;
    use aptos_framework::object::{Object};

    struct MyObject has key, store {
        a:u128,
        b:u128,
        c:u128,
        d:u128,
        vec: vector<u64>,
        w:u8,
        x:u8,
        y:u8,
        z:u8
    }

    struct ObjectController has key {
        delete_ref: object::DeleteRef,
    }

    public entry fun create_object(account: &signer) {
        let caller_address = signer::address_of(account);
        let constructor_ref = object::create_object(caller_address);
        let object_signer = object::generate_signer(&constructor_ref);
        let delete_ref = object::generate_delete_ref(&constructor_ref);

        let vec = vector::empty<u64>();
        let k:u64 = 0;
        while (k < 100) {
            vector::push_back(&mut vec, k);
            k = k + 1;
        };

        let object = MyObject {
                a:1000,
                b:1000,
                c:1000,
                d:1000,
                vec: vec,
                w:10,
                x:10,
                y:10,
                z:10
            };

            move_to(&object_signer, ObjectController {delete_ref});
            move_to(&object_signer, object);
    }

    public entry fun bad_object_update(account: &signer, object: Object<MyObject>) acquires MyObject, ObjectController {

        //For MyObject resource
        let object_address = object::object_address(&object);

        let MyObject {
            a:_,
            b:_,
            c:_,
            d:_,
            vec:_,
            w:_,
            x: _,
            y:_,
            z:_
        } = move_from<MyObject>(object_address);


        //for ObjectController 
        let ObjectController {
            delete_ref
        } = move_from<ObjectController>(object_address);

        object::delete(delete_ref);
    }

}
