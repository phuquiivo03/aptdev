User input: "how to create nft on aptos by smart contract"
Expected output:
- Chatbot phải trả lời được tối thiểu 2 bước: tạo collection để chứa nft và tạo nft

```rust
//create collection
public entry fun create_collection(
        s: &signer,
    ) {
        let royalty = std::option::none();
        collection::create_fixed_collection(
            s,
           utf8(b"description"),
            DEFAULT_COLLECTION_MAX_SUPPLY, //số nguyên
           utf8(b"collection name"),
            royalty,
           utf8(b"image url"),
        );
    }

//create nft
 public entry fun mint_fa(
        s: &signer,
        fa_description: String,
        fa_url: String
    ) {
        let royalty = std::option::none<royalty::Royalty>();
        token::create_named_token(
            s,
            utf8(b"collection name"),
            fa_description,
            utf8(b"nft's name"),
            royalty,
            fa_url,
        );
    }
```
- Cơ bản nhất sẽ là trả lời được: gồm 2 bước -> tạo collection và tạo nft
    - Ở hàm tạo collection đúng cú pháp ở chỗ 2 hàm (bỏ qua tham số)``` let royalty = std::option::none();
        collection::create_fixed_collection() ```
    - Hàm tạo nft thì cần đúng (bỏ qua tham số) ```let royalty = std::option::none<royalty::Royalty>();
        token::create_named_token() ```