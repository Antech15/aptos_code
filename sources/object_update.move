module test::object_update5 {
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

    public entry fun create_object(account: &signer) {
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

        move_to<MyObject>(account, object);
    }

    public entry fun bad_object_update(account: &signer, new_value: u8) acquires MyObject {

        let object = move_from<MyObject>(signer::address_of(account));

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
        } = object;

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

        move_to<MyObject>(account, new_object);
    }

    public entry fun good_object_update(account: &signer, new_value: u8) acquires MyObject {
        let object = borrow_global_mut<MyObject>(signer::address_of(account));
        object.x = new_value;
    }
}
