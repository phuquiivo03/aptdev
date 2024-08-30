module apt::da {
    use aptos_token_objects::collection::{Self, borrow};
    use aptos_token_objects::royalty;
    use aptos_token_objects::token::{Self, Token};
    use std::string::{String, utf8};
    use std::option::{Self, Option};
    use aptos_framework::object::{Self, Object, transfer};

    const DEFAULT_COLLECTION_NAME: vector<u8> = b"QCollection";
    const DEFAULT_FA_NAME: vector<u8> = b"QFumgibleAsset";
    const DEFAULT_COLLECTION_DESCRIPTION: vector<u8> = b"My collection";
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

    public entry fun mint_fa(
        s: &signer,
        fa_description: String,
        fa_url: String
    ) {
        let royalty = std::option::none<royalty::Royalty>();
        token::create_named_token(
            s,
            utf8(DEFAULT_COLLECTION_NAME),
            fa_description,
            utf8(DEFAULT_FA_NAME),
            royalty,
            fa_url,
        );
    }


    #[view]
    public fun state_address_object(): address {
        object::create_object_address(&@apt, DEFAULT_FA_NAME)
    }

    #[view]
    public fun get_char(): Object<Token> {
        object::address_to_object(state_address_object())

    }
    

}