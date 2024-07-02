module test::write_values_explicitly {
   
    public fun sum(n: u128): u128 {
        let total:u128 = 0;
        let k:u128 = 0;
        while (k < n) {
            total = total + k;
            k = k + 1;
        };
        total
    }

    public fun expensive_function(): bool {
        let k:u64 = 0;
        while (k < 100000) {
            k = k + 1;
        };
        let b: bool = (k != 0);
        b
    }

    public fun helper(n: u128): u128 {
        n
    }

    public entry fun calculate() {
        expensive_function();
        let x: u128 = sum(10000);

        helper(x);
    }


    public entry fun explicit() {
        expensive_function();

        let x: u128 = 50005000;

        helper(x);
    }

}
