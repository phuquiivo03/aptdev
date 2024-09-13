module admin::admin {
    use aptos_token_objects::collection::{Self, borrow};
    use aptos_token_objects::royalty;
    use aptos_token_objects::token::{Self, Token};
    use std::string::{String, utf8};
    use std::option::{Self, Option};
    use aptos_framework::object::{Self, Object, ConstructorRef};
    use std::signer;
    const DEFAULT_COLLECTION_NAME: vector<u8> = b"MemeCollection";
    const DEFAULT_FA_NAME: vector<u8> = b"MemeAsset";
    const DEFAULT_COLLECTION_DESCRIPTION: vector<u8> = b"Meme collection";
    const DEFAULT_COLLECTION_LINK: vector<u8> = b"https://mycollection.com";
    const DEFAULT_COLLECTION_MAX_SUPPLY: u64 = 1000;
    public entry fun create_collection(
        s: &signer,
    ) {
        let royalty = std::option::none();
        collection::create_fixed_collection(
            s,
           utf8(DEFAULT_COLLECTION_DESCRIPTION),
            DEFAULT_COLLECTION_MAX_SUPPLY,
           utf8(DEFAULT_COLLECTION_NAME),
            royalty,
           utf8(DEFAULT_COLLECTION_LINK),
        );
    }

    public entry fun mint_and_throw(
        s: &signer,
        fa_description: String,
        fa_url: String,
        receiver: address,
    ) {
        let creator_address = signer::address_of(s);
        let royalty = std::option::none<royalty::Royalty>();
        let token_id = token::create_named_token(
            s,
            utf8(DEFAULT_COLLECTION_NAME),
            fa_description,
            utf8(DEFAULT_FA_NAME),
            royalty,
            fa_url,
        );
        let token_addr = token::create_token_address(&creator_address, &utf8(DEFAULT_COLLECTION_NAME), &utf8(DEFAULT_FA_NAME));
        let token = object::address_to_object<Token>(token_addr);
        assert!(object::owner(token) == creator_address, 1);
        object::transfer(s, token, receiver);
    }


    #[view]
    public fun state_address_object(): address {
        object::create_object_address(&@admin, DEFAULT_FA_NAME)
    }

    #[view]
    public fun get_char(): Object<Token> {
        object::address_to_object(state_address_object())

    }
    

}