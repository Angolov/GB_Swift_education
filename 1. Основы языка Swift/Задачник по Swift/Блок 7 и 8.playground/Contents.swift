// Блок 7
// Задание 1
func sortArray(_ array: [Int]) {
    let result = array.sorted() { $0 < $1 }
    print(result)
}

func stringArrayManipulations(_ array: [String]) {
    var result = array
    
    if array.count > 3 {
        result[0] = "aaa"
        result[1] = "bbb"
        result[2] = "ccc"
    }
    print(result.sorted() { $0 < $1 })
}

func stringArrayCombine(_ array1: [String], _ array2: [String]) {
    let result = array1 + array2
    print(result)
}

let numArray = [0, 20, 5, 1]
let stringArray = ["vkdjfh", "akjshd", "wkrh", "kahsdkjsdh", "aa"]
let anotherStringArray = ["sdfvkdjfh", "sdfakjshd", "sdfwkrh", "dfgkahsdkjsdh", "aa"]

sortArray(numArray)
stringArrayManipulations(stringArray)
stringArrayCombine(stringArray, anotherStringArray)

// Задание 2
func addNewStudent(name: String, profession: String, mark: Int) -> [(String, String, Int)]{
    return [(name, profession, mark)]
}

var someArray = [(String, String, Int)]()

let names: Set<String> = Set(arrayLiteral: "Ivan", "Alex", "Nicole", "Petr", "Rita", "Marry")
let professions: Set<String> = Set(arrayLiteral: "iOS", "Android", "Python", "C++")
let marks = Set(arrayLiteral: 2, 3, 4, 5)

for _ in 1...10 {
    someArray += addNewStudent(name: names.randomElement()!,
                               profession: professions.randomElement()!,
                               mark: marks.randomElement()!)
}

for student in someArray {
    print(student)
}

// Задание 3
func addNewMember(name: String, surname: String) -> [(String, String)] {
    return [(name, surname)]
}

var anotherArray = [(String, String)]()

for _ in 1...10 {
    anotherArray += addNewMember(name: names.randomElement()!, surname: "Black")
}

for member in anotherArray {
    print(member)
}

// Задание 4
func circleArea(with radius: Double) -> Double {
    return 3.14 * radius * radius
}

// Задание 5
var students = Dictionary(dictionaryLiteral: ("name", ("Mary", "Alex", "Adam", "Olga", "Mark")), ("score", ("1", "5", "2", "4", "5")))

if let names = students["name"] {
    print(names)
}

// Задание 6
func sumOfStringArrays (_ firstArray: [String], _ secondArray: [String], _ thirdArray: [String]) -> Int {
    
    let sumArray = firstArray + secondArray + thirdArray
    var sum = 0
    
    for member in sumArray {
        if let number = Int(member) {
            sum += number
        }
    }
    return sum
}

let firstArray = ["sdkfjh", "129371", "123skfjh1"]
let secondArray = ["skjfh", "aksjh", "ksjdfh"]
let thirdArray = ["1984", "394857", "19247"]

print(sumOfStringArrays(firstArray, secondArray, thirdArray))

// Блок 8
// Задание 2
var sortedArray = firstArray.sorted() { $0 < $1 }
var filteredArray = secondArray.filter() { $0.count < 6 }
sortedArray = firstArray.sorted() { $0 > $1 }
filteredArray = secondArray.filter() { $0.count > 5 }

print(filteredArray)

// Задание 3
let checkArray = { (array: [Int]) in return array.isEmpty ? array + [1] : array }
   
let numArray2 = checkArray([Int]())
let numArray3 = checkArray(numArray)

// Задание 4
let site = { (name: String, surname: String, nickname: String, email: String, password: String) in
    print(name, surname, nickname, email, password) }

site("Ivan", "Ivanov", "ivava", "i.ivanov@mail.ru", "12345")

// Задание 5
let checkDictionary = { (dictionary: [Int: Int]) in
    return dictionary.isEmpty ? Dictionary(dictionaryLiteral: (1, 1)) : dictionary }

var someDictionary: Dictionary<Int, Int> = Dictionary()

//someDictionary[2] = 2
someDictionary = checkDictionary(someDictionary)
someDictionary

// Задание 6
let getMinValue = { (array: [Int]) -> Int in
    if let minimum = array.min() {
        return minimum
    } else {
        return 0
    }
}

print(getMinValue(numArray))

// Задание 7
let getMaxValue = { (array: [Int]) -> Int in
    if let maximum = array.max() {
        return maximum
    } else {
        return 0
    }
}

print(getMaxValue(numArray))

// Задание 8-9

let charArrayManipulations = { (array: [Character]) in
    
    var vowelsArray = [Character]()
    var consonantsArray = [Character]()
    
    for char in array {
        let charLowered = char.lowercased()
        switch charLowered {
        case "a", "e", "i", "o", "u", "y":
            vowelsArray.append(char)
        default:
            consonantsArray.append(char)
        }
    }
    
    let resultArray = vowelsArray + consonantsArray
    
    print(resultArray)
    print()
    print(vowelsArray)
    print(consonantsArray)
    print()
    vowelsArray = vowelsArray.sorted() { $0.lowercased() < $1.lowercased() }
    consonantsArray = consonantsArray.sorted() { $0.lowercased() < $1.lowercased() }
    print(vowelsArray)
    print(consonantsArray)
    print()
    print(vowelsArray + consonantsArray)
}

charArrayManipulations(["U", "Z", "A", "e", "a", "q"])
