module dragonballsui::main {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct Dragonball has key, store {
        id: UID,
        stars: u8,
    }

    struct Wish has store {
        wish: vector<u8>,
    }

    struct Person has key, store {
        id: UID,
        name: vector<u8>,
        dragonballs: vector<UID>,
        wishes: vector<Wish>,
    }

}
