// Блок 20
// Задание 1-2
//MARK: - Transfomer class declaration

import CoreGraphics
class Transformer {
    
    //MARK: Enum type
    enum TransformerType {
        case autobot
        case decepticon
    }
    
    //MARK: - Public properties
    let name: String
    let type: TransformerType
    var currentDamageTaken: Int
    var weaponsDamage: Int
    
    //MARK: - Initializer
    init(name: String,
         type: TransformerType,
         currentDamageTaken: Int,
         weaponDamage: Int = 0) {
        
        self.name = name
        self.type = type
        self.currentDamageTaken = currentDamageTaken
        self.weaponsDamage = weaponDamage
    }
    
    //MARK: - Public methods
    func increaseWeaponDamage() {
        weaponsDamage += 1
    }
}

// Задание 3-4, 8-9
//MARK: - Cybertron class declaration
class Cybertron {
    
    //MARK: - Public properties
    var transformers: [Transformer]
    var counter: Int {
        didSet {
            if counter < 0 {
                for transformer in transformers {
                    
                    if transformer.type == .decepticon {
                        transformers.remove(at: transformers.firstIndex() { $0.type == .decepticon }!)
                        counter += 1
                        break
                    }
                }
            }
        }
    }
    
    //MARK: - Initializer
    init() {
        
        let autobotNames = ["Optimus Prime", "Bumblebee", "Broadside", "Jazz"]
        let decepticonNames = ["Galvatron", "Soundwave", "Starscream", "Thundercracker"]
        
        transformers = []
        counter = 0
        
        for name in decepticonNames {
            transformers.append(Transformer(name: name, type: .decepticon, currentDamageTaken: 0))
            counter += 1
        }
        
        for name in autobotNames {
            transformers.append(Transformer(name: name, type: .autobot, currentDamageTaken: 0))
            counter -= 1
        }
    }
    
    //MARK: - Subscript
    subscript(index: Int) -> Transformer {
        
        get {
            if index >= 0 {
                return index < transformers.count ? transformers[index] : transformers[transformers.count - 1]
            } else {
                return transformers[0]
            }
        }
        
        set {
            if index < 0 {
                transformers[0] = newValue
            } else if index >= transformers.count {
                transformers[transformers.count - 1] = newValue
            } else {
                transformers[index] = newValue
            }
        }
    }
}

let transformers = Cybertron()
transformers[2].increaseWeaponDamage()

// Задание 5
//MARK: - Extension Transformer class
extension Transformer {
    
    //MARK: - Public method
    func totalDestruction() {
        
        weaponsDamage *= weaponsDamage * weaponsDamage
    }
}

// Задание 6
//MARK: - Extension Cybertron class
extension Cybertron {
    
    //MARK: - Public method
    func sortTransformers() {
        
        var result = [Transformer]()
        
        for transformer in transformers {
            transformer.type == .autobot ? result.insert(transformer, at: result.startIndex) : result.append(transformer)
        }
        
        transformers = result
    }
}

transformers.sortTransformers()
transformers

// Задание 7
var autobots = [Transformer]()
var decepticons = [Transformer]()

for transformer in transformers.transformers {
    
    transformer.type == .autobot ? autobots.append(transformer) : decepticons.append(transformer)
}

autobots
decepticons
