// Блок 13
// Задание 1


var losers: [Programmer] = []

//MARK: - Programmer class declaration
class Programmer {
    
    //MARK: - Public properties
    var programmingLanguage: String
    var librariesKnown: [String]
    var patternsKnown: [String]
    var isEnglishFluent: Bool
    var hasPortfolio: Bool
    
    var hasPassedInterview: Bool = false {
        willSet {
            if !newValue {
                losers.append(self)
            }
        }
    }
    
    //MARK: Initializer
    init(programmingLanguage: String,
         librariesKnown: [String],
         patternsKnown: [String],
         isEnglishFluent: Bool,
         hasPortfolio: Bool) {
        
        self.programmingLanguage = programmingLanguage
        self.librariesKnown = librariesKnown
        self.patternsKnown = patternsKnown
        self.isEnglishFluent = isEnglishFluent
        self.hasPortfolio = hasPortfolio
        
    }
    
}

let programmer = Programmer(programmingLanguage: "Swift",
                            librariesKnown: ["UIKit", "SwiftUI", "ARKit", "SpriteKit"],
                            patternsKnown: ["MVC", "SOLID"],
                            isEnglishFluent: true,
                            hasPortfolio: false)

// Задание 2
//MARK: - Programmer class extension
extension Programmer {
    
    //MARK: - Print to console method
    func printAll() {
        
        print("Candidate knows \(programmingLanguage).")
        
        print("Libraries:", terminator: " ")
        for library in librariesKnown {
            
            print(library, terminator: " ")
            
        }
        print()
        
        print("Patterns:", terminator: " ")
        for pattern in patternsKnown {
            
            print(pattern, terminator: " ")
            
        }
        print()
        
        print("""
        His english is fluent: \(isEnglishFluent ? "yes" : "no")
        He has a portfolio: \(hasPortfolio ? "yes" : "no")
        """)
    }
    
}

programmer.printAll()

// Задание 3-4
//MARK: - HRManager class declaration
class HRManager {
    
    //MARK: - Private properties
    
    //MARK: - Public methods
    func interviewWith(_ programmer: Programmer) {
        
        if programmer.librariesKnown.contains("SwiftUI") &&
            programmer.patternsKnown.contains("MVC") &&
            programmer.isEnglishFluent &&
            programmer.hasPortfolio {
            
            programmer.hasPassedInterview = true
            
        } else {
            
            programmer.hasPassedInterview = false
            
        }
    }
    
    
}

let hrManager = HRManager()
hrManager.interviewWith(programmer)
losers
