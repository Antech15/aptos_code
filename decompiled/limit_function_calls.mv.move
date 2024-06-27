module 0xf17b31d66e881d1b49c3a98c448f133d20517fa93b4041ea11cab24c8603d93b::limit_function_calls {
    public entry fun function_call() {
        let v0 = 0;
        while (v0 < 10000) {
            helper_function();
            v0 = v0 + 1;
        };
    }
    
    public fun helper_function() {
    }
    
    public entry fun no_function_call() {
        let v0 = 0;
        while (v0 < 10000) {
            v0 = v0 + 1;
        };
    }
    
    // decompiled from Move bytecode v6
}

