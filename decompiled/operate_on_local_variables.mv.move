module 0xf17b31d66e881d1b49c3a98c448f133d20517fa93b4041ea11cab24c8603d93b::operate_on_local_variables {
    struct MyObject has store, key {
        value: u64,
    }
    
    public entry fun bad_object_write(arg0: &signer) acquires MyObject {
        let v0 = borrow_global_mut<MyObject>(0x1::signer::address_of(arg0));
        v0.value = 0;
        while (v0.value < 100000) {
            v0.value = v0.value + 1;
        };
    }
    
    public entry fun create_object(arg0: signer) {
        let v0 = MyObject{value: 1};
        move_to<MyObject>(&arg0, v0);
    }
    
    public entry fun good_object_write(arg0: &signer) acquires MyObject {
        let v0 = borrow_global_mut<MyObject>(0x1::signer::address_of(arg0));
        v0.value = 0;
        let v1 = v0.value;
        while (v1 < 100000) {
            v1 = v1 + 1;
        };
        v0.value = v1;
    }
    
    // decompiled from Move bytecode v6
}

