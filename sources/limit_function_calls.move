module test::limit_function_calls {
   

   public fun helper_function() {
        let j:u64 = 0;
        while (j < 10) {
            j = j + 1;
        };
    }


    public entry fun function_call() {
        let k:u64 = 0;
        while (k < 10000) {
            helper_function();
            k = k + 1;
        };
    }

    
    public entry fun no_function_call() {
        let k:u64 = 0;
        while (k < 10000) {
            // no function call
            let j:u64 = 0;
            while (j < 10) {
                j = j + 1;
            };
            k = k + 1;
        };
    }
}