module apt::fa {
    use std::signer;
    use std::string::{String, utf8};
    use std::vector;
    use aptos_framework::event;
    use aptos_token_objects::token;
    use aptos_token_objects::collection;
    use std::option::{Self, Option};    

    struct Admin has key, store, copy {
        objects: vector<GlobalChar>
    }

    struct GlobalChar has store, copy, drop {
        name: String,
        age: u64,
        description: String,
        uri: String,
        skin_value: u64
    }

    #[event]
    struct InitEvent has drop, store{
        owner: address
    }

    // fun init(s: &signer) {
    //     let new_admin = Admin { objects: vector<GlobalChar>[] };
    //     move_to(s, new_admin);
    //     event::emit(InitEvent{owner: signer::address_of(s)});
    // }

    public entry fun init_my_module(s: &signer) {
        let new_admin = Admin { objects: vector<GlobalChar>[] };
        move_to(s, new_admin);
        event::emit(InitEvent{owner: signer::address_of(s)});
    }

    public entry fun mint(s: &signer, name: String, age: u64, description: String, uri: String, skin_value: u64) acquires Admin {
        let new_char = GlobalChar { name, age, description, uri, skin_value };
        let admin = borrow_global_mut<Admin>(@apt);
        vector::push_back(&mut admin.objects, new_char);
    }

    #[view]
    public fun get_chars() : vector<GlobalChar>  acquires Admin{
        let admin = borrow_global<Admin>(@apt);
        admin.objects
    }

    #[view]
    public fun get_char() : u64{
        1
    }
}