module 0xf17b31d66e881d1b49c3a98c448f133d20517fa93b4041ea11cab24c8603d93b::object_update5_5 {
    struct MyObject has store, key {
        a: u128,
        b: u128,
        c: u128,
        d: u128,
        vec: vector<u64>,
        w: u8,
        x: u8,
        y: u8,
        z: u8,
    }
    
    struct ObjectController has key {
        delete_ref: 0x1::object::DeleteRef,
    }
    
    public entry fun create_object(arg0: &signer) {
        let v0 = 0x1::object::create_object(0x1::signer::address_of(arg0));
        let v1 = 0x1::object::generate_signer(&v0);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 100) {
            0x1::vector::push_back<u64>(&mut v2, v3);
            v3 = v3 + 1;
        };
        let v4 = MyObject{
            a   : 1000, 
            b   : 1000, 
            c   : 1000, 
            d   : 1000, 
            vec : v2, 
            w   : 10, 
            x   : 10, 
            y   : 10, 
            z   : 10,
        };
        let v5 = ObjectController{delete_ref: 0x1::object::generate_delete_ref(&v0)};
        move_to<ObjectController>(&v1, v5);
        move_to<MyObject>(&v1, v4);
    }
    
    public entry fun bad_object_update(arg0: &signer, arg1: 0x1::object::Object<MyObject>, arg2: u8) acquires MyObject, ObjectController {
        let v0 = 0x1::object::object_address<MyObject>(&arg1);
        let MyObject {
            a   : v1,
            b   : v2,
            c   : v3,
            d   : v4,
            vec : v5,
            w   : v6,
            x   : _,
            y   : v8,
            z   : v9,
        } = move_from<MyObject>(v0);
        let ObjectController { delete_ref: v10 } = move_from<ObjectController>(v0);
        0x1::object::delete(v10);
        let v11 = MyObject{
            a   : v1, 
            b   : v2, 
            c   : v3, 
            d   : v4, 
            vec : v5, 
            w   : v6, 
            x   : arg2, 
            y   : v8, 
            z   : v9,
        };
        let v12 = 0x1::object::create_object(0x1::signer::address_of(arg0));
        let v13 = 0x1::object::generate_signer(&v12);
        let v14 = ObjectController{delete_ref: 0x1::object::generate_delete_ref(&v12)};
        move_to<ObjectController>(&v13, v14);
        move_to<MyObject>(&v13, v11);
    }
    
    public entry fun good_object_update(arg0: &signer, arg1: 0x1::object::Object<MyObject>, arg2: u8) acquires MyObject {
        borrow_global_mut<MyObject>(0x1::object::object_address<MyObject>(&arg1)).x = arg2;
    }
    
    // decompiled from Move bytecode v6
}

