module 0xf17b31d66e881d1b49c3a98c448f133d20517fa93b4041ea11cab24c8603d93b::short_circuit {
    public entry fun short_circuit() {
        if (cheap_function()) {
        };
    }
    
    public fun cheap_function() : bool {
        let v0 = 0;
        while (v0 < 10000) {
            v0 = v0 + 1;
        };
        v0 == 0
    }
    
    public fun expensive_function() : bool {
        let v0 = 0;
        while (v0 < 100000) {
            v0 = v0 + 1;
        };
        v0 == 0
    }
    
    public entry fun no_short_circuit() {
        if (expensive_function()) {
        };
    }
    
    // decompiled from Move bytecode v6
}

