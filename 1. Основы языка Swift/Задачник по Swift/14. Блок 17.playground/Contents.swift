// Блок 17
// Задание 1-3
//MARK: - Animal class declaration
class Animals {
    
    //MARK: - Enum AnumalName
    enum AnimalName: Int {
        case dog = 1
        case cat
        case pig
        case cow
        case lion
        case jaguar
        case boar
        case elephant
        
        enum AnimalType {
            case home
            case wild
            case dangerous
        }
        
        var type: AnimalType {
            
            switch self {
            case .dog, .cat, .pig, .cow:
                return AnimalType.home
            case .elephant:
                return AnimalType.wild
            case .lion, .jaguar, .boar:
                return AnimalType.dangerous
            }
        }
    }
    
    //MARK: - Public properties
    var animals: [AnimalName]
    var homeAnimals: [AnimalName]
    var wildAnimals: [AnimalName]
    var dangerousAnimals: [AnimalName]
    
    //MARK: - Initializers
    init() {
        
        animals = []
        homeAnimals = []
        wildAnimals = []
        dangerousAnimals = []
        for _ in 1...20 {
            
            let anotherAnimal = AnimalName(rawValue: Int.random(in: 1...8)) ?? AnimalName.cow
            animals.append(anotherAnimal)
        }
    }
    
    //MARK: - Public methods
    func animalSorting() {
        
        for animal in animals {
            switch animal.type {
            case .home:
                homeAnimals.append(animal)
            case .wild:
                wildAnimals.append(animal)
            case .dangerous:
                dangerousAnimals.append(animal)
            }
        }
    }
    
}

let animals = Animals()
animals.animals
animals.animalSorting()
animals.homeAnimals
animals.wildAnimals
animals.dangerousAnimals

// Задание 4
//MARK: - Farmer class declaration
class Farmer {
    
    //MARK: - Enum Gender
    enum Gender {
        case male
        case female
    }
    
    //MARK: - Public properties
    let name: String
    let role: String
    let gender: Gender
    var salary: Int
    
    //MARK: - Initializers
    init(name: String, role: String, gender: Gender, salary: Int) {
        
        self.name = name
        self.role = role
        self.gender = gender
        self.salary = salary
    }
    
    init() {
        let men = ["Alex", "Joe", "Ken", "David", "Mike", "Travis", "Scott"]
        let women = ["Jane", "Marry", "Kate", "Wendy", "Rita", "Sally", "Giorgia"]
        
        let randomGender = Int.random(in: 0...1)
        
        gender = randomGender == 1 ? Gender.male : Gender.female
        name = gender == .male ? men.randomElement()! : women.randomElement()!
        role = "farmer"
        salary = Int.random(in: 100...200)
    }
    
    //MARK: - Public methods
    func hardWork() {
        print("Work in the field")
    }
    
    func homeWork() {
        print("Work in the house")
    }
}

// Задание 5
var farmers: [Farmer] = []
var maximumSalary = Farmer(name: "", role: "", gender: .male, salary: 0)

for _ in 1...20 {
    
    let farmer = Farmer()
    farmers.append(farmer)
    
}

for farmer in farmers {
    
    maximumSalary = maximumSalary.salary > farmer.salary ? maximumSalary : farmer
    
}
maximumSalary

// Задание 6-7
var menArray: [Farmer] = []
var womenArray: [Farmer] = []

for farmer in farmers {
    farmer.gender == .male ? menArray.append(farmer) : womenArray.append(farmer)
    farmer.gender == .male ? farmer.hardWork() : farmer.homeWork()
}

// Задание 8-10
//MARK: - Hunter class declaration
class Hunter {
    
    //MARK: - Public properties
    var name: String
    var role: String
    
    //MARK: - Initializer
    init(name: String, role: String) {
        self.name = name
        self.role = role
    }
    
    //MARK: - Public method
    func findAndKill(_ animals: Animals) {
        
        for animal in animals.animals {
            
            if animal.type != .home {
                print("Hunter killed \(animal.self)")
                animals.animals.remove(at: animals.animals.firstIndex(of: animal)!)
            }
        }
        
    }
}

let hunter = Hunter(name: "Jack", role: "Hunter")
hunter.findAndKill(animals)

// Задание 11
// Не стал делать
// 11) Создайте класс Ферма. Ему задайте метод, который будет объединять всех: и животных, и фермеров, и охотников. Добавьте их в один массив и отсортируйте по алфавиту.
