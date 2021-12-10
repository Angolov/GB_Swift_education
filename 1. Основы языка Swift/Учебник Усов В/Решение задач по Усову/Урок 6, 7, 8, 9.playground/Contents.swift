// Урок 6
// Задание 1
var arr1 = [1,2,3,4,5,6] // Были разные типы данных
var arr2 = ["a","Z"]
var arr3 = [Character("a"), "b"]
var arr4 = ["a", "zz"] // Опять же разные типы данных
var arr5: [ClosedRange<Float>] = [1...3, 2.1...2.3]

// Задание 2
let myArr1 = Array(1...10)
let myArr2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let myArr3 = Array(arrayLiteral: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

// Задание 3
let myArr4 = Array(arrayLiteral: 1, 1, 1, 1, 1)
let myArr5 = [1, 1, 1, 1, 1]
let myArr6 = Array(repeating: 1, count: 5)

// Задание 4
var myArr7 = Array(arrayLiteral: 5, 29, 12, 1)
// Опять зловеще поиздевался над возможностями языка. Конечно можно было сделать гораздо нагляднее и понятнее, но так короче)
myArr7[1...2] = [myArr7[0] + myArr7[myArr7.count-1]]
// Наглядный вариант
/*
 myArr7.remove(at: 1)
 myArr7[1] = myArr7[0]+myArr7[2]
 myArr7
*/
myArr7.sort()

// Задание 5
var firstArr = Array(1...100)
var secondArr = [Int]()
secondArr = Array(firstArr[24...49])

// Задание 6
var arr: Array<Character> = Array(repeating: "a", count: 5)
arr.insert("z", at: 1)
var i = UInt8(arr.count)

// Задание 7
let someNumber = firstArr[firstArr.count - 2]

// Задание 8
/*
var arr = [1,2,3,4,100]
 Array<Int>
 
var arr = [Character("2"), "c","5"]
 Array<Character>
 
var arr = [[1...10],[2...8],[3...7]]
 Array<Array<ClosedRange<Int>>>
 
var arr = [1...2, 3...4, 5..<6]
 Ошибка, третий элемент другого типа Диапазона
 
var arr = [1, arr.0+1, arr.1+1]
 Ошибки компиляции
 */

// Задание 9
var arr9 = [Array<Character>]()
arr9.append(["a", "b", "c"])
arr9.append(["d", "e", "f"])
arr9.remove(at:1)
var arr92 = arr9.remove(at: 0)
print(arr92[0])

// Задание 10
var firstArray = [1,2,3,4,5]
var secondArray = [UInt]()
var tempArray = Array(firstArray.dropLast())
for i in 0...tempArray.count-1{
    secondArray.append(UInt(tempArray[i]))
}
print(secondArray)
print(type(of: secondArray))

// Урок 7
// Задание 1»
var set1 = [1, 2, 3, 4, 5] //Array<Int>
var set2: Set = [1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0] //Set<Int>
var set3: Set = ["a","c"] //Set<String>
var set4 = Set(arrayLiteral: -0, +0, 1, 2, 3) //Set<Int>
var set5 = Set(arrayLiteral: 0, 1, 2, 3, 4) //Set<Int>

// Задание 2
// Исправленный вариант
var mySet: Set<Double> = []
mySet.insert(13.4)
print( type (of: mySet.count ) )

// Задание 3
var mySet2: Set = [13.4, 15.1]
print( mySet2.contains( Double(13.4) ) ) // true

// Задание 4
var setA: Set = [1, 2, 3, 4, 5] //Set<Int>
var setB = Set( arrayLiteral: 1, 2, 3, 4, 5 ) //Set<Int>

// Задание 5
var setOne: Set = [0, 1, 2, 3]
var setTwo: Set = [0, 2, 4, 6]
var resultSet = setOne.union(setTwo)
resultSet.remove(4)

// Задание 6
var taskSet1 = Set(1...10)
var taskSet2 = Set(5...15)
var taskSet3 = taskSet1.union(taskSet2)
var taskSet4 = taskSet1.symmetricDifference(taskSet2)
var count: UInt8 = UInt8(taskSet4.count)

// Урок 8
// Задание 1
var dict1: Dictionary = ["One":(100,101),"Two":(200,201)] //Dictionary<String, (Int, Int)>
//var dict2: Dictionary = [(1,2,3):1, (2,3,4):2] // Кортежи не могут быть ключами
//var dict3: Dictionary<Int,Int> = [1: 13.3, 2: 14.1, 3: 16.9] //Задан словарь Int:Int, переданы значения Double, ошибка.
var dict4 = Dictionary(uniqueKeysWithValues: [(1,2), (3,4), (5,6)]) //Dictionary<Int, Int>
var dict5 = ["Alex": 1989, "John": 2002, "Harold": 1951] //Dictionary<String, Int>
//var dict6: Dictionary = [1, 2, 3, 4] //Не словарь, а массив создан.

// Задание 2
// 1. Будет иметь тип Dictionary<String, Character>
var dict6: Dictionary<String, Character> = ["One": "1", "Two": "2"]
var dict7 = Dictionary(dictionaryLiteral: ("One", Character("1")), ("Two", "2"))
var dict8 = ["One": Character("1"), "Two": "2"]

// Задание 3
var myArray1: Array<UInt> = [1,2,3,4,5]
var myDict1 = [1:2, 3:4, 5:6]
var result = myArray1.count + Int(myArray1[3]) + myDict1.count //5+4+3=12

// Задание 4
var myDict = [1: "One", 2: "Two", 3: "Three"]
var setOfKeys = Set(myDict.keys)
var arrayOfValues = Array(myDict.values)

var setOfKeysString: Set<String> = Set(setOfKeys.map {String($0)})
var resultSet2 = setOfKeysString.union(Set(arrayOfValues))

// Задание 5
var lastDict = [1: ["Moscow", "Capital"], 2: ["Sochi", "Leasure"]]
type(of: (lastDict))
let dictElCount = lastDict.count
var newArr = Array(repeating: dictElCount, count: dictElCount) //Array<Int>
type(of: newArr)

// Урок 9
// Задание 1
var swiftString = "Swift"
let someCharacter: Character = "!"
let stringArr = Array(repeating: String(someCharacter), count: swiftString.count)
swiftString = String(someCharacter)

// Задание 2
let heroName = "JohnWick"
var stringIndex = heroName.startIndex
print(heroName[stringIndex])
stringIndex = heroName.index(before: heroName.endIndex)
print(heroName[stringIndex])

let additionalString = "БабаЯга"
let startIndex = additionalString.startIndex
stringIndex = additionalString.index(additionalString.startIndex, offsetBy: 3)
let subString = additionalString[startIndex...stringIndex]

print(subString)

// Задание 3
var whiteFigures: Set<Character> = [Character("\u{2654}"), "\u{2655}", "\u{2659}"]
var blackFigures: Set<Character> = [Character("\u{265A}"), "\u{265B}", "\u{265F}"]

