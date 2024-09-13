# Meme Throwing
This project is a Move-based smart contract application designed to work with the Aptos blockchain. It includes modules for creating collections, minting tokens, and transferring tokens. The project structure is organized to facilitate development, testing, and deployment of Move modules.

## Project Structure
```
.aptos/
    config.yaml
    config.yaml.pub
build/
    aptdev/
        BuildInfo.yaml
        bytecode_modules/
            admin.mv
            dependencies/
                AptosFramework/
                AptosStdlib/
                AptosTokenObjects/
                MoveStdlib/
        source_maps/
            admin.mvsm
            dependencies/
                AptosFramework/
                AptosStdlib/
                AptosTokenObjects/
                MoveStdlib/
        sources/
            admin.move
            dependencies/
                AptosFramework/
                AptosStdlib/
                AptosTokenObjects/
                MoveStdlib/
Move.toml
scripts/
sources/
    da.move
testcase.md
tests/
```
## Key Files and Directories
- .aptos/: Contains configuration files for the Aptos CLI.
- build/: Contains compiled bytecode, source maps, and dependencies.
- Move.toml: Configuration file for the Move project.
- scripts/: Directory for deployment and other utility scripts.
- sources/: Contains the Move source code files.
- tests/: Directory for test cases.
- Modules
- admin.move
- This module includes functions for creating collections and minting tokens.


## Modules
```da.move```
This module includes functions for managing tokens and their states.

## Functions
- ```create_collection(s: &signer)```: Creates a fixed collection.
- ```mint_and_throw(s: &signer, fa_description: String, fa_url: String, receiver: address)```: Mints a token and transfers it to the receiver.

## Functions
```state_address_object()```: Returns the address of the state object.
```get_char()```: Returns the Token object.
## Dependencies
The project relies on several dependencies from the Aptos framework and standard libraries:

- AptosFramework
- AptosStdlib
- AptosTokenObjects
- MoveStdlib
### Setup
- Install Aptos CLI: Follow the instructions on the Aptos documentation to install the Aptos CLI.
- Configure Aptos CLI: Set up your Aptos CLI configuration in the .aptos/config.yaml file.
- Build the Project: Run the following command to compile the Move modules:
  ```bash
  aptos move compile
  ```
### Deployment
To deploy the compiled Move modules to the Aptos blockchain, follow these steps:

1. Generate a Transaction: Create a transaction that includes the compiled bytecode.
2. Sign the Transaction: Sign the transaction with your account's private key.
3. Submit the Transaction: Submit the signed transaction to the Aptos blockchain.
### Usage
Mint and Transfer Token
To mint a token and transfer it to a receiver, use the mint_and_throw function in the admin module:
```rust
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
```
### Testing
To run the tests, use the following command:
```bash

aptos move test

```
### Contributing
Contributions are welcome! Please follow the standard GitHub workflow for contributing to this project.

# License
This project is licensed under the MIT License. See the LICENSE file for details.

# Contact
For any questions or issues, please open an issue on the GitHub repository or contact the project maintainers.
