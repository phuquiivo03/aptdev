module aptdev::fa {
    use std::signer;
    use std::string::{String, utf8};
    use std::vector;
    use aptos_framework::event;
    use aptos_token_objects::token;
    use aptos_token_objects::collection;
    use std::option::{Self, Option};    


    struct GlobalChar has key, store, copy, drop {
        name: String,
        age: u64,
        description: String,
        uri: String,
        skin_value: u64
    }

    fun init(s: &signer) {
        let royality = option::none();
        let max_supply = 1000;

        collection::create_fixed_collection(
            s,
            utf8(b"embeiu"),
            max_supply,
            utf8(b"piis collection"),
            royality,
            utf8(b"https://mycollection.com")
        );
    }
}