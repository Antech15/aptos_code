module test::variable_packing_object {
    use std::signer;
    use aptos_framework::object;
    use aptos_framework::object::{Object};

    struct MyObject has key, store {
        x8: u64, 
        x32: u64,
        x24: u64
    }

    struct MyPackedObject has key, store {
        x: u64
    }

    public entry fun create_object(account: &signer) {
        let caller_address = signer::address_of(account);
        let constructor_ref = object::create_object(caller_address);
        let object_signer = object::generate_signer(&constructor_ref);
        let delete_ref = object::generate_delete_ref(&constructor_ref);

        let object = MyObject {
                x8: 1,
                x32: 1,
                x24: 1
            };

        move_to(&object_signer, object);
    }

    public entry fun create_packed_object(account: &signer) {
        let caller_address = signer::address_of(account);
        let constructor_ref = object::create_object(caller_address);
        let object_signer = object::generate_signer(&constructor_ref);
        let delete_ref = object::generate_delete_ref(&constructor_ref);

        let object =  MyPackedObject {
                x: 1
            };

        move_to(&object_signer, object);
    }

    public entry fun no_variable_packing(account: &signer, object: Object<MyObject>) acquires MyObject{
        let object_address = object::object_address(&object);
        let object = borrow_global_mut<MyObject>(object_address);

        let x8: u64;
        let x32: u64;
        let x24: u64;

        let k:u64 = 0;
        while (k < 10000) {
            x8  = object.x8;
            x32 = object.x32;
            x24 = object.x24;
            
            k = k + 1;
        };
    }

    public entry fun variable_packing(account: &signer, packed_object: Object<MyPackedObject>) acquires MyPackedObject{
        let object_address = object::object_address(&packed_object);
        let object = borrow_global_mut<MyPackedObject>(object_address);

        let x: u64;
        let x8: u64;
        let x32: u64;
        let x24: u64;

        let k:u64 = 0;
        while (k < 10000) {
            x   = object.x;

            x8  = (x & 0xF);
            x32 = ((x & (0xFFFF << 8)) >> 8);
            x24 = ((x & (0xFFF << 40)) >> 40);
            
            k = k + 1;
        };
    }

}
