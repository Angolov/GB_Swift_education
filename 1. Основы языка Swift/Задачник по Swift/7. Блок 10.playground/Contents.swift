// Блок 10
// Задание 2
//MARK: - House class declaration
final class House {
    
    //MARK: - Private properties
    private var width: Int
    private var height: Int
    
    //MARK: - Computed properties
    var getWidth: Int {
        
        print(width)
        return width
        
    }
    
    var getHeight: Int {
        
        print(height)
        return height
        
    }
    
    //MARK: - Initializer
    init(width: Int, height: Int) {
        
        self.width = width
        self.height = height
        
    }
    
    //MARK: - Public methods
    func build() {
        
        print (height * width)
    
    }
}

let house = House(width: 12, height: 5)
house.getHeight
house.getWidth
house.build()

// Задание 3
//MARK: - Names class declaration
final class Names {
    
    //MARK: - Private properties
    let names = ["Alex", "Andrew", "Anton", "Bill", "Barry", "Bernard", "Carl", "Danny", "Frank", "Mark", "Max",
                 "John", "James", "Will", "Ferdinand"]
    
    //MARK: - Initializer
    init() {}
    
    //MARK: - Public methods
    func returnNamesThatStartWith(_ char: String) -> [String] {
        
        var result: [String] = []
        
        for name in names where name.starts(with: char) {
            
            result.append(name)
            
        }
        
        return result
        
    }
    
    func printNames(_ names: [String]) {
        
        for value in names {
            
            print(value)
            
        }
        
    }
    
}

let names = Names()
names.printNames(names.returnNamesThatStartWith("A"))
names.printNames(names.returnNamesThatStartWith("E"))
print()

// Задание 4
//MARK: - Students class declaration
final class Students {
    
    //MARK: - Private properties
    private var students: [String]
    private let maximumNumberOfStudents = 30
    
    //MARK: - Initializer
    init() {
        
        students = ["Alex", "Andrew", "Anton", "Bill", "Barry", "Bernard", "Carl", "Danny", "Frank", "Mark", "Max",
                    "John", "James", "Will", "Ferdinand", "Alex", "Andrew", "Anton", "Bill", "Barry", "Bernard", "Carl", "Danny", "Frank", "Mark", "Max"]
        
    }
    
    //MARK: - Public methods
    func addStudent(_ name: String) {
        
        if students.count >= maximumNumberOfStudents {
            
            print("Class is full")
            
        } else {
            
            students.append(name)
            
        }
        
    }
    
    func count() -> Int {
        
        return students.count
        
    }
    
    func sort(with closure: (String, String) -> Bool) {
        
        students.sort(by: closure)
        
    }
    
    func printStudents() {
        
        for student in students {
            
            print(student)
            
        }
    }
}

let students = Students()
students.printStudents()
students.addStudent("Joe")
students.count()
students.sort(with: >)
print()
students.printStudents()

// Задание 6
//MARK: - ShoppingList class declaration
final class ShoppingList {
    
    //MARK: - Nested enum ShopStatus
    enum ShopStatus: String {
        case to_buy = "to buy"
        case bought = "bought"
    }
    
    //MARK: - Private properties
    var shoppingList: [String : ShopStatus]
    
    //MARK: - Initializer
    init() {
        
        shoppingList = [:]
        
    }
    
    //MARK: - Subscript
    subscript(key: String) -> ShopStatus? {
        
        get {
            
            if shoppingList[key] != nil {
                shoppingList[key] = .bought
            }
            return shoppingList[key]
        
        }
        
        set {
            
            shoppingList[key] = newValue
            
        }
    }
    
    //MARK: - Public methods
    func printFullList() {
        
        for (key, value) in shoppingList {
            
            print("\(key) \(value.rawValue)")
            
        }
    }
    
}

let shoppingList = ShoppingList()

shoppingList["Eggs"] = .to_buy
shoppingList["Apples"] = .to_buy
shoppingList["Bread"] = .to_buy
shoppingList["Meat"]
shoppingList["Bread"]

shoppingList.printFullList()
