// Блок 12
// Задание 3

var job = [1, 15, 124, 42, 53, 57, 12]

//MARK: - GeneralManager class declaration
class GeneralManager {
    
    //MARK: - Type properties
    static var counter = 0
    
    //MARK: - Private properties
    fileprivate var name: String
    fileprivate var age: Int
    fileprivate var salary: Int
    
    //MARK: Initializer
    init(name: String, age: Int, salary: Int) {
        
        self.name = name
        self.age = age
        self.salary = salary
        
    }
}

//MARK: - SalesDirector class declaration
class SalesDirector: GeneralManager {
    
    //MARK: - Private properties
    fileprivate var sales: Int
    fileprivate var carModel: String
    
    //MARK: Initializer
    init(name: String, age: Int, salary: Int, sales: Int, carModel: String) {
        
        self.sales = sales
        self.carModel = carModel
        
        super.init(name: name, age: age, salary: salary)
        
    }
    
    //MARK: Public methods
    func printAll() {
        
        print("""
        \(name) is Sales Director.
        His age is \(age) and salary is \(salary).
        His has a car \(carModel)
        Current sales KPI is \(sales).
        """)
        
    }
}

//MARK: - Accountant class declaration
class Accountant {
    
    //MARK: - Public methods
    func calculate(_ array: [Int]) -> Int {
        
        var result = 0
        
        for value in array {
            
            result += value
            
        }
        
        return result
        
    }
}

let salesManager = SalesDirector(name: "John", age: 32, salary: 500000, sales: 1000000, carModel: "Toyota")
salesManager.printAll()

let accountant = Accountant()
let result = accountant.calculate(job)
print(result)

// Задача 4
//MARK: - Monster class declaration
class Monster {
    
    //MARK: - Private properties
    private let name: String
    private let breed: String
    private let homePlanet: String
    private let height: Int
    
    private var weight: Int
    private var weapon: String
    private var weaponDamage: Int {
        didSet {
            
            if weaponDamage < Monster.minimalWeaponDamage || weaponDamage > Monster.maximumWeaponDamage {
                
                weaponDamage = oldValue
                
            }
            
        }
    }
    
    //MARK: - Type properties
    static let minimumHeight = 100
    static let maximumWeight = 200
    static let minimalWeaponDamage = 10
    static let maximumWeaponDamage = 1000
    
    static var counter = 0
    
    //MARK: - Initializer
    init(name: String,
         breed: String,
         homePlanet: String,
         height: Int,
         weight: Int,
         weapon: String,
         weaponDamage: Int) {
        
        self.name = name
        self.breed = breed
        self.homePlanet = homePlanet
        
        self.height = height < Monster.minimumHeight ? Monster.minimumHeight : height
        self.weight = weight > Monster.maximumWeight ? Monster.maximumWeight : weight
        
        self.weapon = weapon
        
        self.weaponDamage = weaponDamage
        
    }
    
}
