module test::variable_packing {
    use std::signer;

    struct MyObject has key, store {
        x8: u8, 
        x32: u64,
        x24: u64
    }

    struct MyPackedObject has key, store {
        x: u64
    }

    public entry fun create_object(account: signer) {
        move_to<MyObject>(&account, MyObject {
                x8: 1,
                x32: 1,
                x24: 1
            });
    }

    public entry fun create_packed_object(account: signer) {
        move_to<MyPackedObject>(&account, MyPackedObject {
                x: 1
            });
    }

    public entry fun no_variable_packing(account: &signer) 
    acquires MyObject{
        let object = borrow_global<MyObject>(signer::address_of(account));

        let k:u64 = 0;
        while (k < 10000) {
            let x8:  u8  = object.x8;
            let x32: u64 = object.x32;
            let x24: u64 = object.x24;
            
            k = k + 1;
        };
    }

    public entry fun variable_packing(account: &signer) 
    acquires MyPackedObject{
        let packed_object = borrow_global<MyPackedObject>(signer::address_of(account));
        let x: u64 = packed_object.x;

        let k:u64 = 0;
        while (k < 10000) {
            let x8  = (x & 0xF);
            let x32 = ((x & (0xFFFF << 8)) >> 8);
            let x24 = ((x & (0xFFF << 40)) >> 40);
            
            k = k + 1;
        };
    }

}