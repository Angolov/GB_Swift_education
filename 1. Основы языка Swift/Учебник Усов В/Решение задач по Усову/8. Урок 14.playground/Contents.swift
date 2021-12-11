// Урок 14
// Задание 1
func summOfPositives(in array: [Int]) -> Int {
    
    return array.filter{ $0 > 0 }.reduce(0, +)
    
}

summOfPositives(in: [1,-2,3,4,-5])

// Задание 2
func makeSquared(array: [Int]) -> [Int] {
    
    return array.map{ $0 * $0 }
    
}

makeSquared(array: [1,2,3,4])

// Задание 3
func multiplication(of array: [Int]) -> Int {
    
    if array.count > 0 {
        
        return array.reduce(1, *)
        
    } else {
        
        return 0
        
    }
}

multiplication(of: [1,2,3,4])

// Задание 4
func getEvenElement(from array: [Int]) -> [Int] {
    
    return array.filter{ $0 % 2 == 0 }
}

getEvenElement(from: [1,4,5,1,2,4,6,3,12,3])

// Задание 5
func numberToString(in string: String) -> String {
    
    let numbers = [Character("1"):"один",
                   "2":"два",
                   "3":"три",
                   "4":"четыре",
                   "5":"пять",
                   "6":"шесть",
                   "7":"семь",
                   "8":"восемь",
                   "9":"девять",
                   "0":"ноль"]
    
    let replacedArray = string.map({ (element: Character) -> String in
        
        if numbers[element] != nil {
            
            return numbers[element]!
            
        } else {
            
            return String(element)
            
        }
    })
    
    var result = ""
    
    for char in replacedArray {
        
        result += char
        
    }
    
    return result
    
}

numberToString(in: "Мне 2 года")
numberToString(in: "Это стоит 10 рублей")
