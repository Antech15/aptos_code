module 0xf17b31d66e881d1b49c3a98c448f133d20517fa93b4041ea11cab24c8603d93b::variable_packing {
    struct MyObject has store, key {
        x8: u8,
        x32: u64,
        x24: u64,
    }
    
    struct MyPackedObject has store, key {
        x: u64,
    }
    
    public entry fun variable_packing(arg0: &signer) acquires MyPackedObject {
        let _ = borrow_global<MyPackedObject>(0x1::signer::address_of(arg0)).x;
        let v1 = 0;
        while (v1 < 10000) {
            v1 = v1 + 1;
        };
    }
    
    public entry fun create_object(arg0: signer) {
        let v0 = MyObject{
            x8  : 1, 
            x32 : 1, 
            x24 : 1,
        };
        move_to<MyObject>(&arg0, v0);
    }
    
    public entry fun create_packed_object(arg0: signer) {
        let v0 = MyPackedObject{x: 1};
        move_to<MyPackedObject>(&arg0, v0);
    }
    
    public entry fun no_variable_packing(arg0: &signer) acquires MyObject {
        let _ = borrow_global<MyObject>(0x1::signer::address_of(arg0));
        let v1 = 0;
        while (v1 < 10000) {
            v1 = v1 + 1;
        };
    }
    
    // decompiled from Move bytecode v6
}

