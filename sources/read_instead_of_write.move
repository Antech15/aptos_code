module test::read_instead_of_write {
    use std::signer;
    use std::vector;

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


    public entry fun create_object(account: signer) {
        let vec = vector::empty<u64>();
        let k:u64 = 0;
        while (k < 100) {
            vector::push_back(&mut vec, k);
            k = k + 1;
        };
        move_to<MyObject>(&account, MyObject {
                a:1000,
                b:1000,
                c:1000,
                d:1000,
                vec: vec,
                w:10,
                x:10,
                y:10,
                z:10
            });
    }


    public entry fun reading(account: &signer) 
    acquires MyObject{
        let k:u64 = 0;
        while (k < 1000) {
            let object = borrow_global<MyObject>(signer::address_of(account));
            let x = object.x;
            k = k + 1;
        };
    }

    public entry fun writing(account: &signer) 
    acquires MyObject{
        let k:u64 = 0;
        while (k < 1000) {
            let object = borrow_global_mut<MyObject>(signer::address_of(account));
            object.x = 1;
            k = k + 1;
        };
    }

}