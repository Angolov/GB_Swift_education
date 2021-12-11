// Блок 15
// Задание 1-3
//MARK: - Security class declaration
class Security {
    
    //MARK: - Internal properties
    let visitor: String

    //MARK: - Initializer
    init(visitor: String) {
        self.visitor = visitor
        print("Ivan came.")
    }
    
    //MARK: - Deinitializer
    deinit {
        print("Secutiry destroyed")
    }
}

var originalSecurity: Security? = Security(visitor: "Ivan")

//Как подвесить объект в памяти...
let closure1 = { [originalSecurity] in
    print(originalSecurity?.visitor ?? "")
}
let closure2 = {
    print(originalSecurity?.visitor ?? "")
}

closure1()
closure2()

originalSecurity = nil //deinit не сработал из-за захвата

closure1()
closure2()

//Как сделать, чтобы deinit сработал
var normalSecurity: Security? = Security(visitor: "Ivan")
normalSecurity = nil

// Задание 4-10
//MARK: - Director class declaration
class Director {
    
    //MARK: - Public property
    let name: String
    
    //MARK: - Initializer
    init(name: String) {
        self.name = name
    }
    
    //MARK: - Public methods
    func getEmployeeListOf(_ company: Company) {
        company.getEmployeeList()
    }
    
    func fireEmployee(_ salesManager: SalesManager, from company: Company) {
        
        if let salesManagers = company.salesManagers {
            
            company.salesManagers = salesManagers.filter() { $0.name != salesManager.name }
            
        }
    }
}

//MARK: - ViceDirector class declaration
class ViceDirector: Director {
    
    //MARK: - Public methods
    func sendReport(_ report: String, to director: Director) {
        print(report)
    }
    
}

//MARK: - SalesManager class declaration
class SalesManager: ViceDirector {
    
    //MARK: - Public methods
    func sendMessage(_ message: String, to salesManager: SalesManager) {
        print(message)
    }
    
    func askForSalaryFrom(_ viceDirector: ViceDirector) {
        print("Where is my salary?")
    }
    
}

//MARK: - Company class declaration
class Company {
    
    //MARK: - Public properties
    var director: Director
    var viceDirector: ViceDirector? = nil
    var salesManagers: [SalesManager]? = nil
    
    //MARK: - Initializer
    init(director: Director,
         viceDirector: ViceDirector? = nil,
         salesManagers: [SalesManager]? = nil) {
        
        self.director = director
        self.viceDirector = viceDirector
        self.salesManagers = salesManagers
    }
    
    //MARK: - Public method
    func getEmployeeList() {
        
        print(director.name)
        if let viceDirector = viceDirector {
            print(viceDirector.name)
        }
        salesManagers?.forEach() {
            print($0.name)
        }
        
    }
}

print()
let director = Director(name: "Alex")
let viceDirector = ViceDirector(name: "Ivan")
let firstSalesManager = SalesManager(name: "Mark")
let secondSalesManager = SalesManager(name: "Max")
let thirdSalesManager = SalesManager(name: "Marry")

let company = Company(director: director)

company.viceDirector = viceDirector

company.salesManagers = [SalesManager]()
company.salesManagers?.append(firstSalesManager)
company.salesManagers?.append(secondSalesManager)
company.salesManagers?.append(thirdSalesManager)

director.getEmployeeListOf(company)

print()
director.fireEmployee(firstSalesManager, from: company)
director.getEmployeeListOf(company)
