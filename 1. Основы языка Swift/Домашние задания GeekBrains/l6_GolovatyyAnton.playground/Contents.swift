// Домашнее задание 5
// Упражнение 1

import Foundation

//MARK: - Queue structure declaration
struct Queue<Element: Hashable> {
    
    //MARK: - Private properties
    private var elements: [Element] = []
    
    //MARK: - Public methods
    mutating func add(_ element: Element) {
        
        elements.append(element)
        
    }
    
    mutating func get() -> Element? {
        
        return elements.removeFirst()
        
    }
    
    func printAllElements() {
        
        for element in elements {
            print(element, terminator: " ")
        }
        print()
        
    }
}

//MARK: - Tests excercise 1
print("====================================")
print("Excercise 1 tests\n")

var someNumbers = Queue<Int>()

someNumbers.add(22)
someNumbers.add(7)
someNumbers.add(5)
someNumbers.add(30)
someNumbers.add(11)

someNumbers.printAllElements()

someNumbers.get()
someNumbers.get()
someNumbers.add(25)
someNumbers.add(50)
someNumbers.add(17)

someNumbers.printAllElements()

var someStrings = Queue<String>()

someStrings.add("Alex")
someStrings.add("John")
someStrings.add("Nicole")
someStrings.add("Mary")

someStrings.printAllElements()

someStrings.get()
someStrings.add("Andrew")
someStrings.add("Barry")

someStrings.printAllElements()

// Упражнение 2
//MARK: - Queue extension with methods
extension Queue where Element: Comparable {
    
    mutating func sort(with closure: (Element, Element) -> Bool) {
        
        elements.sort(by: closure)
        
    }
    
    mutating func filter(_ closure: (Element) -> Bool) {
        
        elements = elements.filter(closure)
        
    }
    
    mutating func calculate(with closure: (Element, Element) -> Element) -> Element? {
        
        guard elements.count > 0 else { return nil }
        guard elements.count > 1 else { return elements[0] }
            
        var result = elements[0]
        
        for i in 1..<elements.count {
            
            result = closure(result, elements[i])
            
        }
        
        return result
        
    }
    
}

//MARK: - Tests excercise 2
print("====================================")
print("Excercise 2 tests\n")

someNumbers.sort() { $0 > $1 }
someNumbers.printAllElements()

someNumbers.filter() { $0 % 5 == 0 }
someNumbers.printAllElements()

someNumbers.calculate(with: +)

someStrings.sort() { $0.lowercased() < $1.lowercased() }
someStrings.printAllElements()

someStrings.filter() { $0 != "Barry" }
someStrings.printAllElements()

someStrings.calculate(with: +)

// Упражнение 3
//MARK: - Queue extension with subscript
extension Queue {
    
    subscript(index: Int) -> Element? {
        
        get {
            
            return index < elements.count - 1 ? elements[index] : nil
            
        }
        
        set {
            
            if let element = newValue {
                
                if index >= elements.count {
                    
                    elements.append(element)
                    
                } else {
                    
                    elements[index] = element
                    
                }
                
            }
        }
    }
}

//MARK: - Tests excercise 3
print("====================================")
print("Excercise 3 tests\n")

someNumbers.printAllElements()
someNumbers[4]
someNumbers[10] = 20
someNumbers[0] = nil
someNumbers[2] = 17
someNumbers.printAllElements()

someStrings.printAllElements()
someStrings[5]
someStrings[7] = "Adam"
someStrings[1] = nil
someStrings[3] = "Jane"
someStrings.printAllElements()
