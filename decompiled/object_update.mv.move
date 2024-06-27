module 0xf17b31d66e881d1b49c3a98c448f133d20517fa93b4041ea11cab24c8603d93b::object_update5 {
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
    
    public entry fun bad_object_update(arg0: &signer, arg1: u8) acquires MyObject {
        let MyObject {
            a   : v0,
            b   : v1,
            c   : v2,
            d   : v3,
            vec : v4,
            w   : v5,
            x   : _,
            y   : v7,
            z   : v8,
        } = move_from<MyObject>(0x1::signer::address_of(arg0));
        let v9 = MyObject{
            a   : v0, 
            b   : v1, 
            c   : v2, 
            d   : v3, 
            vec : v4, 
            w   : v5, 
            x   : arg1, 
            y   : v7, 
            z   : v8,
        };
        move_to<MyObject>(arg0, v9);
    }
    
    public entry fun create_object(arg0: &signer) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 100) {
            0x1::vector::push_back<u64>(&mut v0, v1);
            v1 = v1 + 1;
        };
        let v2 = MyObject{
            a   : 1000, 
            b   : 1000, 
            c   : 1000, 
            d   : 1000, 
            vec : v0, 
            w   : 10, 
            x   : 10, 
            y   : 10, 
            z   : 10,
        };
        move_to<MyObject>(arg0, v2);
    }
    
    public entry fun good_object_update(arg0: &signer, arg1: u8) acquires MyObject {
        borrow_global_mut<MyObject>(0x1::signer::address_of(arg0)).x = arg1;
    }
    
    // decompiled from Move bytecode v6
}

