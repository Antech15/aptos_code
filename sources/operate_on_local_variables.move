module test::operate_on_local_variables {
    use std::signer;
    
    struct MyObject has key, store {
        value: u64
    }

    public entry fun create_object(account: signer) {
        let object = MyObject {
                value: 1
            };

        move_to<MyObject>(&account, object);
    }

    public entry fun bad_object_write(account: &signer) acquires MyObject{
        let object = borrow_global_mut<MyObject>(signer::address_of(account));

        object.value = 0;

        while (object.value < 100000) {
            object.value = object.value + 1;
        };
    }

    public entry fun good_object_write(account: &signer) acquires MyObject{
        let object = borrow_global_mut<MyObject>(signer::address_of(account));

        object.value = 0;
        let intermediate = object.value;

        while (intermediate < 100000) {
            intermediate = intermediate + 1;
        };
        object.value = intermediate;
    }
}
