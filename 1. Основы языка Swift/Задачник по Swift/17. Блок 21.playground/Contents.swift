// Блок 21
// Задание 1
//MARK: - InterviewProtocol declaration
protocol InterviewProtocol {
    
    var surname: String { get set }
    func successOfinterview()
    func failureOfInterview()
}

// Задание 2-5
//MARK: - Developer class declaration
class Developer: InterviewProtocol {
    
    //MARK: - Internal properties
    var name: String
    var surname: String
    var exp: Int
    var skill: String?
    var inSearchOfJob: Bool?
    var isSuitable: Bool
    
    //MARK: - Type properties
    static var okArray: [String] = []
    static var failArray: [String] = []
    
    //MARK: - Initializer
    init(name: String,
         surname: String,
         exp: Int,
         skill: String? = nil,
         inSearchOfJob: Bool? = nil,
         isSuitable: Bool) {
        
        self.name = name
        self.surname = surname
        self.exp = exp
        self.skill = skill
        self.inSearchOfJob = inSearchOfJob
        self.isSuitable = isSuitable
    }
    
    //MARK: - Public methods
    func successOfinterview() {
        guard let inSearchOfJob = inSearchOfJob else { return }
        
        if inSearchOfJob {
            print("Passed")
            Developer.okArray.append(surname)
            Developer.okArray.sort() { $0 < $1 }
        }
    }
    
    func failureOfInterview() {
        print("Failed")
    }
}

// Задание 7
//MARK: - TechnicalInterviewProtocol declartion
protocol TechnicalInterviewProtocol: InterviewProtocol {
    
    var isSuitable: Bool { get set }
    func successTechnicalOfinterview()
    func failureTechnicalOfInterview()
}

// Задание 8-13
//MARK: - Tester class declaration
class Tester: InterviewProtocol {
    
    //MARK: - Internal properties
    var name: String
    var surname: String
    var exp: Int
    var skill: String?
    var inSearchOfJob: Bool?
    var isSuitable: Bool
    
    //MARK: - Type properties
    static var okArray: [String] = []
    static var failArray: [String] = []
    
    //MARK: - Initializer
    init(name: String,
         surname: String,
         exp: Int,
         skill: String? = nil,
         inSearchOfJob: Bool? = nil,
         isSuitable: Bool) {
        
        self.name = name
        self.surname = surname
        self.exp = exp
        self.skill = skill
        self.inSearchOfJob = inSearchOfJob
        self.isSuitable = isSuitable
    }
    
    //MARK: - Public methods
    func successOfinterview() {
        guard let inSearchOfJob = inSearchOfJob else { return }
        
        if inSearchOfJob {
            print("Passed")
            Tester.okArray.append(surname)
            Tester.okArray.sort() { $0 < $1 }
        }
    }
    
    func failureOfInterview() {
        print("Failed")
    }
}

//MARK: - Developer class extension for TechnicalInterviewProtocol
extension Developer: TechnicalInterviewProtocol {
    func successTechnicalOfinterview() {
        guard let inSearchOfJob = inSearchOfJob else { return }
        
        if inSearchOfJob, skill == "ios" {
            print("You have passed, wait for the offer.")
            Developer.okArray.append(name)
            Developer.okArray.sort() { $0 < $1 }
        }
    }
    
    func failureTechnicalOfInterview() {
        print("We're sorry but the developer \(name) failed")
    }
}

//MARK: - Tester class extension for TechnicalInterviewProtocol
extension Tester: TechnicalInterviewProtocol {
    func successTechnicalOfinterview() {
        guard let inSearchOfJob = inSearchOfJob else { return }
        
        if inSearchOfJob, skill == "QA" {
            print("You have passed, wait for the offer.")
            Tester.okArray.append(name)
            Tester.okArray.sort() { $0 < $1 }
        }
    }
    
    func failureTechnicalOfInterview() {
        print("We're sorry but the tester \(name) failed")
    }
}

// Задание 14-16
//MARK: - CVBase struct declaration
struct CVBase {
    
    //MARK: - Public property
    var base: [Any] = []
}

let dev1 = Developer(name: "Ivan", surname: "Black", exp: 10, skill: "ios", inSearchOfJob: true, isSuitable: false)
let dev2 = Developer(name: "Alex", surname: "Black", exp: 10, skill: "andoid", inSearchOfJob: false, isSuitable: false)
let dev3 = Developer(name: "Joell", surname: "Black", exp: 10, skill: "", inSearchOfJob: true, isSuitable: false)
let dev4 = Developer(name: "Marcus", surname: "Black", exp: 10, skill: "c++", inSearchOfJob: true, isSuitable: false)
let dev5 = Developer(name: "Ken", surname: "Black", exp: 10, skill: "python", inSearchOfJob: false, isSuitable: false)
let dev6 = Developer(name: "Joe", surname: "Black", exp: 10, skill: "", inSearchOfJob: false, isSuitable: false)
let dev7 = Developer(name: "Maximus", surname: "Black", exp: 10, skill: "ios", inSearchOfJob: true, isSuitable: false)


let tester1 = Tester(name: "Ivan", surname: "Black", exp: 10, skill: "QA", inSearchOfJob: true, isSuitable: false)
let tester2 = Tester(name: "Alex", surname: "Black", exp: 10, skill: "", inSearchOfJob: true, isSuitable: false)
let tester3 = Tester(name: "Maximus", surname: "Black", exp: 10, skill: "QA", inSearchOfJob: false, isSuitable: false)
let tester4 = Tester(name: "Marcus", surname: "Black", exp: 10, skill: "", inSearchOfJob: true, isSuitable: false)
let tester5 = Tester(name: "Joe", surname: "Black", exp: 10, skill: "", inSearchOfJob: true, isSuitable: false)
let tester6 = Tester(name: "Ken", surname: "Black", exp: 10, skill: "", inSearchOfJob: true, isSuitable: false)
let tester7 = Tester(name: "Joell", surname: "Black", exp: 10, skill: "", inSearchOfJob: true, isSuitable: false)
 
var cvBase = CVBase()

cvBase.base.append(dev1)
cvBase.base.append(dev2)
cvBase.base.append(dev3)
cvBase.base.append(dev4)
cvBase.base.append(dev5)
cvBase.base.append(dev6)
cvBase.base.append(dev7)
cvBase.base.append(tester1)
cvBase.base.append(tester2)
cvBase.base.append(tester3)
cvBase.base.append(tester4)
cvBase.base.append(tester5)
cvBase.base.append(tester6)
cvBase.base.append(tester7)

cvBase
