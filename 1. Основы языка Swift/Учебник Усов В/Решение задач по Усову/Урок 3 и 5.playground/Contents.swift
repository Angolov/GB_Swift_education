// Урок 3
// Задание 1
let myName = "Anton"
var myAge: UInt8 = 32
var myData: (name: String, age: Int) 
myData.name = myName
myData.age = Int(myAge)

// Задание 2
var intTuple: (Int16, Int16, Int16)
let (firstNumer, secondNumber) = (12, 15)
intTuple = (Int16(firstNumer), Int16(secondNumber), Int16(firstNumer + secondNumber))

// Задание 3
// Исправленный вариант
var someTuple = (myName: "Alex", myAge: 12, "Russia")

// Задание 4
// Исправленный вариант
var tupleOne = (first: 1, second: 2)
var tupleTwo = (first: 3, second: 4)
tupleTwo = tupleOne
tupleTwo.first

// Задание 5
var (firstVariable, secondVariable) = (12, 21)
(firstVariable, secondVariable) = (secondVariable, firstVariable)

// Задание 6
var firstTuple = (favouriteFilm: "Interstellar", favouriteNumber: 7)
let (filmName, myNumber) = firstTuple
print(filmName, myNumber)
typealias Man = (favouriteFilm: String, favouriteNumber: Int)
var secondTuple: Man = ("Batman", 12)

// Кортежи из кортежей - это пушка!
(firstTuple, secondTuple) = (secondTuple, firstTuple)

let finalTuple = (firstTuple.favouriteNumber, secondTuple.favouriteNumber, firstTuple.favouriteNumber - secondTuple.favouriteNumber)

// Урок 5
// Задание 1
let firstRange = 1...9
let secondRange = 1..<10

// Задание 2
var rangeOne = "a"..."z"
var rangeTwo = "1"..."y"
rangeOne = rangeTwo

// Задание 3
var range1 = 1..<10 // Range<Int>
var range2 = 1... // PartialRangeFrom<Int>
var range3 = ..<5 // PartialRangeUpTo<Int>
var range4 = -100...100 // ClosedRange<Int>

// Задание 4
// Первогозначения у диапазона var range = ..<UInt8(10) нет.

// Задание 5
var a = 1...2
var b = 2...3
let comparable = a == b // false
// ниже выдаст ошибку компиляции, т.к. нельзя диапазоны сравнивать.
// let comparable2 = a < b

// Задание 6
let range = -100...100
var item: UInt = 21
var containsCheck: Bool = range.contains(Int(item))

// Задание 7
let latinLettersUpperCase = "A"..."Z"
// методы min() и max() не применимы к диапазону из строк
latinLettersUpperCase.lowerBound // "A"
latinLettersUpperCase.upperBound // "Z"

// Задание 8
let floatRange1: ClosedRange<Float> = 1.1...3.1
let floatRange2: PartialRangeFrom<Float> = 1.1...
let floatRange3 = Float(1)...3


