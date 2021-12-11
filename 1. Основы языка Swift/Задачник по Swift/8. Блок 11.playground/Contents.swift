// Блок 11
// Задание 2
//MARK: Calculator class declaration
class Calculator {
    
    //MARK: Public properties
    var firstNumber: Int
    var secondNumber: Int
    
    //MARK: Computed properties
    var getSum: Int {
        
        return firstNumber + secondNumber
        
    }
    
    var getSub: Int {
        
        return firstNumber - secondNumber
    
    }
    
    var getMulti: Int {
        
        return firstNumber * secondNumber
        
    }
    
    var getDiv: Int {
        
        return firstNumber / secondNumber
        
    }
    
    //MARK: Initializer
    init(fistNumber: Int, secondNumber: Int) {
        
        self.firstNumber = fistNumber
        self.secondNumber = secondNumber
        
    }
    
}

let calculator = Calculator(fistNumber: 11, secondNumber: 12)
calculator.getSum
calculator.getSub
calculator.getMulti
calculator.getDiv

// Задание 3
//MARK: AppStore class declaration
class AppStore {
    
    //MARK: Private properties
    private var programs: [String]
    private var programsRating: [String : [Int]]
    private var programsFeedback: [String : [String]]
    
    //MARK: Initializer
    init() {
        
        programs = []
        programsRating = [:]
        programsFeedback = [:]
        
    }
    
    //MARK: Public methods
    func addProgram(_ programName: String) {
        
        if programs.contains(programName) {
            
            print("\(programName) version updated")
            
        } else {
            
            print("\(programName) added to AppStore")
            programs.append(programName)
            
        }
    }
    
    func launchProgram(_ programName: String) {
        
        if programs.contains(programName) {
            
            print("\(programName) is launched")
            
        } else {
            
            print("\(programName) not found")
            
        }
    }
    
}

let appStore = AppStore()

appStore.addProgram("XCode")
appStore.addProgram("Instagram")
appStore.addProgram("WhatsApp")

appStore.launchProgram("Telegram")
appStore.launchProgram("XCode")
appStore.addProgram("Instagram")

print()

// Задание 4
//MARK: - AppStore class extension
extension AppStore {
    
    //MARK: - Feedback methods
    func addFeedback(_ feedback: String, to program: String) {
        
        if programs.contains(program) {
            
            if programsFeedback[program] == nil {
                
                programsFeedback[program] = []
                
            }
            
            programsFeedback[program]?.append(feedback)
            
        } else {
            
            print("\(program) not found")
            
        }
        
    }
    
    func getFeedback(for program: String) {
        
        if programs.contains(program) && programsFeedback[program] != nil {
            
            print("Feedback for \(program):")
            
            for feedback in programsFeedback[program]! {
                
                print(feedback)
                
            }
            
        } else if !programs.contains(program) {
            
            print("\(program) not found")
            
        } else {
            
            print("There is no feedback for \(program)")
            
        }
        
    }
    
}

appStore.addFeedback("Great app!", to: "Instagram")
appStore.addFeedback("Best app!", to: "Instagram")
appStore.addFeedback("Lovely", to: "Instagram")
appStore.addFeedback("Telegram is much better", to: "WhatsApp")
appStore.getFeedback(for: "Instagram")

print()

// Задание 5
//MARK: - AppStore class extension
extension AppStore {
    
    //MARK: Rating methods
    func addRating(_ rating: Int, to program: String) {
        
        if programs.contains(program) {
            
            if programsRating[program] == nil {
                
                programsRating[program] = []
                
            }
            
            programsRating[program]?.append(rating)
            
        } else {
            
            print("\(program) not found")
            
        }
        
    }
    
    func getRating(for program: String) {
        
        if programs.contains(program) && programsRating[program] != nil {
            
            print("Rating for \(program):")
            
            for rating in programsRating[program]! {
                
                print(rating)
                
            }
            
        } else if !programs.contains(program) {
            
            print("\(program) not found")
            
        } else {
            
            print("There is no rating for \(program)")
            
        }
        
    }
    
}

appStore.addRating(5, to: "Instagram")
appStore.addRating(4, to: "Instagram")
appStore.addRating(4, to: "Instagram")
appStore.addRating(2, to: "WhatsApp")
appStore.getRating(for: "Instagram")

print()

// Задание 6
//MARK: AppStore class extension
extension AppStore {
    
    //MARK: - Remove program method
    func removeProgram(_ program: String) {
        
        if programs.contains(program) {
            
            programsFeedback[program] = nil
            programsRating[program] = nil
            programs.remove(at: programs.firstIndex(of: program)!)
            
        }
        
    }
    
}

appStore.removeProgram("WhatsApp")
appStore.getFeedback(for: "WhatsApp")

// Задание 9
//MARK: - Human class declaration
class Human {
    
    //MARK: - Private properties
    var weaponDamage: Int
    var health: Int
    
    //MARK: Initializer
    init(weaponDamage: Int, health: Int) {
        
        self.weaponDamage = weaponDamage
        self.health = health
        
    }
}

//MARK: - Orc class declaration
class Orc: Human {
    
    //MARK: - Overrided properties
    override var health: Int {
        didSet {
            print("Health changed from \(oldValue) to \(health)")
        }
    }
}

//MARK: - Elf class declaration
class Elf: Human {
    
    //MARK: - Overrided properties
    override var weaponDamage: Int {
        didSet {
            print("Weapon damage changed from \(oldValue) to \(weaponDamage)")
        }
    }
}
