module test::short_circuit2 {

    //returns false
    public fun expensive_function(): bool {
        let k:u64 = 0;
        while (k < 100000) {
            k = k + 1;
        };
        let b: bool = (k == 0);
        b
    }

    //returns true
    public fun cheap_function(): bool {
        let k:u64 = 0;
        while (k < 10000) {
            k = k + 1;
        };
        let b: bool = (k != 0);
        b
    }

    // F && T
    public entry fun no_short_circuit() {
        if (expensive_function() && cheap_function()) {

        };
    }

    // T && F
    public entry fun short_circuit() {
        if (cheap_function() && expensive_function()) {

        };
    }
}
