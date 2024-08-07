module test::object_update_obj_loop {
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

    public fun helper_function(account: &signer, object: Object<MyObject>, new_value: u8): Object<MyObject> acquires ObjectController, MyObject {
        //For MyObject resource
        let object_address = object::object_address(&object);


        let MyObject {
            a:a,
            b:b,
            c:c,
            d:d,
            vec:vec,
            w:w,
            x: _,
            y:y,
            z:z
        } = move_from<MyObject>(object_address);


        //for ObjectController 
        let ObjectController {
            delete_ref
        } = move_from<ObjectController>(object_address);

        object::delete(delete_ref);

        // create new object
        let new_object = MyObject {
            a:a,
            b:b,
            c:c,
            d:d,
            vec:vec,
            w:w,
            x: new_value,
            y:y,
            z:z
        };

        let caller_address = signer::address_of(account);
        let constructor_ref = object::create_object(caller_address);
        let object_signer = object::generate_signer(&constructor_ref);
        let delete_ref = object::generate_delete_ref(&constructor_ref);

        move_to(&object_signer, ObjectController {delete_ref});
        move_to(&object_signer, new_object);

        object::address_to_object<MyObject>(object::address_from_constructor_ref(&constructor_ref))
    }

    public fun helper_function2(object: &mut MyObject, new_value: u8) {
        object.x = new_value;
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

    public entry fun bad_object_update(account: &signer, object: Object<MyObject>, new_value: u8) acquires ObjectController, MyObject {
        let k:u64 = 0;
        while (k < 10000) {
            object = helper_function(account, object, new_value);
        }
    }

    public entry fun good_object_update(account: &signer, object: Object<MyObject>, new_value: u8) acquires MyObject {
        let object_address = object::object_address(&object);
        let object = borrow_global_mut<MyObject>(object_address);

        let k: u64 = 0;
        while (k < 10000) {
            helper_function2(object, new_value);
            k = k + 1;
        }
    }
}
