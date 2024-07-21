module aptdev::lrn {
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

    public fun generate_char(
        name: String,
        age: u64,
        description: String,
        uri: String,
        skin_value: u64,
        s: &signer) {
            let new_char = mint(name, age, description, uri, skin_value);
            move_to(s, new_char);
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

    public fun update_char_skin_dna(char: &mut GlobalChar, new_dna: u64) {
        char.skin_value = new_dna;
    }

    public fun get_inventory(s: &signer) : vector<GlobalChar> acquires CharsCollection{
        borrow_global<CharsCollection>(signer::address_of(s)).inventory
    }

    public fun make_sure_non_empty_Charscollection(vec: &vector<GlobalChar>) : bool{
        assert!(vector::is_empty(vec), 0);
        true
    }

  #[test(a = @0x1)]
    public fun test_add_asset_into_inventory(a: &signer) {
        generate_char(utf8(b"Pii"),
            0,
            utf8(b"embeiu"),
            utf8(b"https://www.google.com"),
            72931,
            a
        );
        // let inventory =  &borrow_global<CharsCollection>(signer::address_of(a)).inventory;
        // let rs = make_sure_non_empty_Charscollection(inventory);

    }
}