module test::minimize_vector_element_operations {
    use std::vector;

    public entry fun bad_vector_access() {
        let vec = vector::empty<u256>();
        let k:u256 = 0;

        while (k < 10000) {
            vector::push_back(&mut vec, 1);
            k = k + 1;
        };

        k = 0;

        while (k < 100000) {
            k = k + *vector::borrow(&vec, 0);
        };
    }


    public entry fun good_vector_access() {
        let vec = vector::empty<u256>();

        let k:u256 = 0;
        while (k < 10000) {
            vector::push_back(&mut vec, 1);
            k = k + 1;
        };

        k = 0;

        let increment1:u256 = *vector::borrow(&vec, 0);

        while (k < 100000) {
            k = k + increment1;
        };
    }

}