import UIKit

// MARK: - Coffee protocol

protocol Coffee {
    var cost: Int { get }
}

// MARK: - SimpleCoffee class

class SimpleCoffee: Coffee {
    var cost: Int {
        return 50
    }
}

// MARK: - CoffeeDecorator protocol

protocol CoffeeDecorator: Coffee {
    var base: Coffee { get }
    init(base: Coffee)
}


// MARK: - CoffeeDecorator classes

class Milk: CoffeeDecorator {
    var base: Coffee
    var cost: Int {
        return base.cost + 20
    }

    required init(base: Coffee) {
        self.base = base
    }
}

class Whip: CoffeeDecorator {
    var base: Coffee
    var cost: Int {
        return base.cost + 50
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

class Sugar: CoffeeDecorator {
    var base: Coffee
    var cost: Int {
        return base.cost + 5
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

// MARK: - Exercise check

let americano = SimpleCoffee()
let americanoWithMilk = Milk(base: americano)
let capuccino = Whip(base: americano)
let coffeeWithMilkAndSugar = Sugar(base: americanoWithMilk)

americano.cost
americanoWithMilk.cost
capuccino.cost
coffeeWithMilkAndSugar.cost

