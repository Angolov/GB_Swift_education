// Блок 18
// Задание 1-2
//MARK: - SysAdmin class declaration
class SysAdmin {
    
    enum SomeErrors: Error {
        case someError
    }
    
    //MARK: - Public properties
    var virus: String?
    var noNetwork: String?
    var ddos: String?
    
    //MARK: - Initializer
    init() {
        virus = nil
        noNetwork = nil
        ddos = nil
    }
    
    //MARK: - Public method
    func catchErrors() {
        
        do {
            guard virus == nil,
                  noNetwork == nil,
                    ddos == nil else { throw SomeErrors.someError }
            return
        } catch let error {
            print(error)
        }
        
    }
}

// Задание 3 - непонятно из условия
// Задание 4 - через try? можно реализовать.
// Но плохая практика, так как невозможен в таком случае разбор конкретных ошибок.

// Блок 19
// Задание 1
//MARK: - Planet class declaration
class Planet {
    
    //MARK: - Private properties
    private let color: String
    
    //MARK: - Public methods
    let name: String
    var size: Int
    
    //MARK: - Initializer
    init(name: String, size: Int, color: String) {
        self.name = name
        self.size = size
        self.color = color
    }
}

// Задание 2-3
//MARK: - Mars class declaration
class Mars: Planet {
    
    //MARK: - Public properties
    var population: Int
    
    //MARK: - Initializer
    init(name: String, size: Int, color: String, population: Int) {
        self.population = population
        
        super.init(name: name, size: size, color: color)
    }
    
    //MARK: - Public method
    func changeSize() {
        size *= 2
    }
    
}

// Задание 4
//MARK: - Saturn class declaration
class Saturn: Planet {
    
    //MARK: - Computed property
    var rings: Bool {
        return size > 30 ? true : false
    }
}

// Задание 5
let somePlanet = Planet(name: "Venus", size: 10, color: "Beige")
let someOtherPlanet = Mars(name: "Mars", size: 12, color: "Orange", population: 0)
let bigPlanet = Saturn(name: "Saturn", size: 30, color: "Blue")

// Задание 6
// Создайте класс Темная планета. Сделайте так, чтобы он уничтожал все другие планеты. Примечание: вспоминаем ARC.
// Уничтожение других объектов??? Может ошибка в описании?

// Задание 7
// MARK: - Martian class declaration
class Martian: Mars {
    
    //MARK: - Type property
    static var humanoid: Int = 0
}

if type(of: someOtherPlanet) == Mars.self {
    
    Martian.humanoid += 1
}

Martian.humanoid
