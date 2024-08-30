module apt::lrn {
    use std::signer;
    use std::string::{String, utf8};
    use std::vector;
    use aptos_framework::event;
    use aptos_framework::object::{Self, Object};
    use aptos_token_objects::token;
    use aptos_token_objects::collection;
    use std::option::{Self, Option}; 
       
    // Error codes
    const OBJECT_NOT_FOUND: u64 = 1;
    const UPDATE_DNA_FAILED: u64 = 2;
    const EMPTY_INVENTORY: u64 = 3;

    const OBJECT_NAME: vector<u8> = b"GlobalChar";

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct GlobalChar has key, store, copy, drop {
        name: String,
        age: u64,
        description: String,
        uri: String,
        skin_value: u64
    }

    struct CharsCollection has key, copy, drop {
        inventory: vector<GlobalChar>
    }

    #[event]
    struct MintEvent has drop, store{
        dna: u64
    }
    
    //burn
    // create da
    //create fa
    

    public fun init(s: &signer) {
        // let new_Charscollection = CharsCollection { inventory: vector<GlobalChar>[] };
        // move_to(s, new_Charscollection);
    }

    public entry fun generate_char(
        s: &signer,
        name: String,
        age: u64,
        description: String,
        uri: String,
        skin_value: u64
        ) {
            let state_object_constructor_ref = object::create_named_object(s, OBJECT_NAME);
            let state_object_signer = &object::generate_signer(&state_object_constructor_ref);
            let new_char = mint(name, age, description, uri, skin_value);
            move_to(state_object_signer, new_char);
    }

    fun mint(
        name: String,
        age: u64,
        description: String,
        uri: String,
        skin_value: u64
    ) : GlobalChar {

        let new_char = GlobalChar {
            name,
            age,
            description,
            uri,
            skin_value
        };
        event::emit(MintEvent { dna: new_char.skin_value });
        new_char
    }

    public entry fun update_char_skin_dna(s: &signer, new_dna: u64) acquires GlobalChar {
        let char = borrow_global_mut<GlobalChar>(signer::address_of(s));
        char.skin_value = new_dna;
    }

    public fun get_inventory(s: &signer) : vector<GlobalChar> acquires CharsCollection{
        borrow_global<CharsCollection>(signer::address_of(s)).inventory
    }

    public fun get_skin_dna(char: &GlobalChar): u64 {
        char.skin_value
    }

    public fun make_sure_non_empty_Charscollection(vec: &vector<GlobalChar>) : bool{
        assert!(vector::is_empty(vec), 0);
        true
    }

    // #[view]
    // public fun state_address_object(): address {
    //     object::create_object_address(@apt, OBJECT_NAME)
    // }

    // #[view]
    // public fun get_char(): Object<GlobalChar> {
    //     object::address_to_object(state_address_object())

    // }

    #[test(a = @0x1)]
    public fun test_add_asset_into_inventory(a: &signer) acquires GlobalChar {
        generate_char(
            a,
            utf8(b"Pii"),
            0,
            utf8(b"embeiu"),
            utf8(b"https://www.google.com"),
            72931
        );
        // update_char_skin_dna(a, 1234);

        // update_char_skin_dna(a, 1234);
        // // let inventory =  &borrow_global<CharsCollection>(signer::address_of(a)).inventory;
        // // let rs = make_sure_non_empty_Charscollection(inventory);

    }
}
