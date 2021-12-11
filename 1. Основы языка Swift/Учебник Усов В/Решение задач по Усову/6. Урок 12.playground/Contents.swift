// Урок 12
// Задание 1
func boolToString (_ boolValue: Bool) -> String {
    String(boolValue)
}
boolToString(true)

// Задание 2
func arraySumOfPositives (_ array: Array<Int>) -> Int {
    var sumOfValues = 0
    for number in array {
        sumOfValues += number > 0 ? number : 0
    }
    return sumOfValues
}
arraySumOfPositives([1,-2,3,4,-5])

// Задание 3
func arrayMultiplied (_ array: [Int]) -> Int {
    if array.count == 0 {
        return 0
    } else {
        var result = 1
        for number in array {
            result *= number
        }
        return result
    }
}
arrayMultiplied([1,2,3,4])
arrayMultiplied([])

// Задание 4
func multiplication (_ num1: Int, _ num2: Int) -> Int {
    return num1 * num2
}
func multiplication (_ num1: Double, _ num2: Double) -> Double {
    return num1 * num2
}
multiplication(4, 5)
multiplication(4.1, 5.2)

// Задание 5
func returnOpposite (_ num: Int) -> Int {
    -num
}
returnOpposite(-12)
returnOpposite(32)

// Задание 6
func leaseCost(forDays days: Int) -> Int {
    let costPerDay = 850
    switch days {
    case 0...2:
        return days * costPerDay
    case 3...6:
        return days * costPerDay - 550
    case 7...:
        return days * costPerDay - 1620
    default:
        return 0
    }
}
leaseCost(forDays: 5)
leaseCost(forDays: 9)

// Задание 7
func isThere (number num: Int, inArray array: [Int]) -> Bool {
    array.contains(num)
}
isThere(number: 4, inArray: [1,2,3])
isThere(number: 3, inArray: [2,3,4])

// Задание 8
func repeatString (_ someString: String, for num: Int) -> String {
    var resultString: String = ""
    for _ in 0..<num {
        resultString += someString
    }
    return resultString
}

repeatString("Swift", for: 2)
repeatString("Xcode", for: 0)

// Задание 9
func ballJumpCount (floorHeight height: Int, sonFloor son: Int, momFloor mom: Int, jumpCoeff coeff: Double) -> Int {
    if son >= mom {
        let momHeight = Double(mom * height)
        var ballFloorJumpHeight = Double(son * height)
        var counter = 0
        repeat {
            counter += 1
            ballFloorJumpHeight *= coeff
            if ballFloorJumpHeight >= momHeight {
                counter += 1
            }
        } while ballFloorJumpHeight >= momHeight
        return counter
    }
    return 0
}
ballJumpCount(floorHeight: 10, sonFloor: 2, momFloor: 1, jumpCoeff: 0.75)

// Задание 10
func isCharRepeats (_ str: String) -> Bool {
    var usedChars = [Character]()
    for char in str {
        if usedChars.contains(char) {
            return false
        }
        usedChars.append(char)
    }
    return true
}

func isCharRepeats2 (_ str: String) -> Bool {
    Set(str).count == str.count
}
isCharRepeats2("Swift")
isCharRepeats2("Programmer")

// Задание 11
func areCharsSame (between str1: String, and str2: String) -> Bool {
    var mutableString = str1.count >= str2.count ? str1 : str2
    let otherString = str1.count < str2.count ? str1 : str2
    
    for char in otherString {
        if let charIndex = mutableString.firstIndex(of: char) {
            mutableString.remove(at: charIndex)
        }
    }
    return mutableString.count == 0
}
areCharsSame(between: "abc", and: "bca")
areCharsSame(between: "abc", and: "bcaa")

// Задание 12
func getSimpleNumbers (from range: Range<Int>) -> Array<Int> {
    var arrayOfSimpleNums = [Int]()
    var isSimple: Bool
    for i in range {
        isSimple = true
        if i >= 4 {
            for j in 2...i-1 {
                if i % j == 0 {
                    isSimple = false
                }
            }
            if isSimple {
                arrayOfSimpleNums.append(i)
            }
        } else {
            arrayOfSimpleNums.append(i)
        }
    }
    return arrayOfSimpleNums
}

getSimpleNumbers(from: 1..<10)

// Задание 13
func power (_ num: Int, _ pow: Int) -> Int {
    var result = 1
    for i in 0..<pow {
        result *= num
    }
    return result
}

power(2, 4)
power(2, 0)
power(2, 1)
power(2, 8)
