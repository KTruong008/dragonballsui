module dragonballsui::main {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::string::{Self, String};
    // use sui::object_table::{Self, ObjectTable};


    struct Dragonball has key, store {
        id: UID,
        stars: u8,
    }

    struct Wish has store {
        wish: vector<u8>,
    }

    struct Person has key, store {
        id: UID,
        name: String,
    }

    fun init(ctx: &mut TxContext) {
        let dragonball1 = Dragonball {
            id: object::new(ctx),
            stars: 1,
        };
        let dragonball2 = Dragonball {
            id: object::new(ctx),
            stars: 2,
        };
        let dragonball3 = Dragonball {
            id: object::new(ctx),
            stars: 3,
        };
        let dragonball4 = Dragonball {
            id: object::new(ctx),
            stars: 4,
        };
        let dragonball5 = Dragonball {
            id: object::new(ctx),
            stars: 5,
        };
        let dragonball6 = Dragonball {
            id: object::new(ctx),
            stars: 6,
        };
        let dragonball7 = Dragonball {
            id: object::new(ctx),
            stars: 7,
        };

        transfer::share_object(dragonball1);
        transfer::share_object(dragonball2);
        transfer::share_object(dragonball3);
        transfer::share_object(dragonball4);
        transfer::share_object(dragonball5);
        transfer::share_object(dragonball6);
        transfer::share_object(dragonball7);
    }

    public entry fun create_person(name: vector<u8>, ctx: &mut TxContext) {
        let person = Person {
            id: object::new(ctx),
            name: string::utf8(name),
        };
        transfer::transfer(person, tx_context::sender(ctx));
    }

    // public entry fun find_dragonball(person: &mut Person, ctx: &mut TxContext) {}

    // public entry fun make_wish(wish: vector<u8>, person: &mut Person, ctx: &mut TxContext) {}

    #[test]
    fun test_create_person() {
        // use sui::tx_context;
        use sui::test_scenario;

        let admin = @0x123;
        let goku = @0x456;

        // Init
        let scenario_val = test_scenario::begin(admin);
        let scenario = &mut scenario_val;
        {
            init(test_scenario::ctx(scenario));
        };

        // Create person
        test_scenario::next_tx(scenario, goku);
        create_person(b"Goku", test_scenario::ctx(scenario));

        // Assert person created
        test_scenario::next_tx(scenario, goku);
        let person = test_scenario::take_from_sender<Person>(scenario);
        assert!(person.name == string::utf8(b"Goku"), 0);
        test_scenario::return_to_sender<Person>(scenario, person);

        test_scenario::end(scenario_val);
    }

    #[test]
    fun test_init_creates_dragonballs() {
        // use sui::tx_context;
        use sui::test_scenario;
        // use std::debug;

        let admin = @0x123;
        let goku = @0x456;

        let scenario_val = test_scenario::begin(admin);
        let scenario = &mut scenario_val;
        {
            init(test_scenario::ctx(scenario));
        };

        test_scenario::next_tx(scenario, goku);
        let dragonball7 = test_scenario::take_shared<Dragonball>(scenario);
        let dragonball6 = test_scenario::take_shared<Dragonball>(scenario);
        let dragonball5 = test_scenario::take_shared<Dragonball>(scenario);
        let dragonball4 = test_scenario::take_shared<Dragonball>(scenario);
        let dragonball3 = test_scenario::take_shared<Dragonball>(scenario);
        let dragonball2 = test_scenario::take_shared<Dragonball>(scenario);
        let dragonball1 = test_scenario::take_shared<Dragonball>(scenario);

        
        // debug::print(&dragonball7);
        // debug::print(&dragonball6);
        // debug::print(&dragonball5);
        // debug::print(&dragonball4);
        // debug::print(&dragonball3);
        // debug::print(&dragonball2);
        // debug::print(&dragonball1);
        // let dragonball2 = test_scenario::take_shared<Dragonball>(scenario);
        assert!(dragonball7.stars == 7, 0);
        assert!(dragonball6.stars == 6, 0);
        assert!(dragonball5.stars == 5, 0);
        assert!(dragonball4.stars == 4, 0);
        assert!(dragonball3.stars == 3, 0);
        assert!(dragonball2.stars == 2, 0);
        assert!(dragonball1.stars == 1, 0);

        test_scenario::return_shared<Dragonball>(dragonball7);
        test_scenario::return_shared<Dragonball>(dragonball6);
        test_scenario::return_shared<Dragonball>(dragonball5);
        test_scenario::return_shared<Dragonball>(dragonball4);
        test_scenario::return_shared<Dragonball>(dragonball3);
        test_scenario::return_shared<Dragonball>(dragonball2);
        test_scenario::return_shared<Dragonball>(dragonball1);

        test_scenario::end(scenario_val);
    }

}
