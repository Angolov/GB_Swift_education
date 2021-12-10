// Урок 1
// Задание 1
let myConst = "this is my first const"

// Задание 2
var myVariable = 1408

// Задание 3
// Ответ: не может изменить значение myConst, т.к. это константа

// Задание 4
print (myConst)

// Задание 5
var age = 19
print(age)
age = 20
print(age)

// Урок 2
// Задание 1
var lenghtInKilometers: Double = 100
var timeInSeconds: Int = 154

let speedMetersPerMinute = (lenghtInKilometers * 1000) / (Double(timeInSeconds) / 60)

// Задание 2
let numberOne = 111
let numberTwo = 222

let concateNumber = Int(String(numberOne) + String(numberTwo))

// Задание 3
// 1
var minimumInt8: Int8 = Int8.min
var maximumUInt8: UInt8 = UInt8.max

// 2
print("\(minimumInt8) \(maximumUInt8)")

// Задание 4
// 1
var variableOne: Int = 10
var variableTwo = 19

// 2
var additionalVariable = variableOne
variableOne = variableTwo
variableTwo = additionalVariable

// 3
print("The first variable was 10, now it is \(variableOne)")
print("The second variable was 19, now it is \(variableTwo)")

// Задание 5

// 1
let parameterOne: Float = 3.14
var parameterTwo: Double = 7.12

// 2
parameterTwo = 4.56

// Задание 6

// 1
let constOne = 18
let constTwo: Float = 16.4
let constThree = 5.7

// 2
var resultFloat: Float = Float(constOne) + constTwo + Float(constThree)

// 3
var resultMultiFloat = Float(constOne) * constTwo * Float(constThree)
var resultInt = Int(resultMultiFloat)

// 4
var divisionLeft = Double(constTwo.truncatingRemainder(dividingBy: Float(constThree)))
// 5
print(resultFloat)
print(resultInt)
print(divisionLeft)

// Задание 7
// 1 
var a = 2
var b = 3

// 2
let calculation7Result = (a + 4 * b) * (a - 3 * b) + a * a
print(calculation7Result)

// Задание 8
// 1
var c = 1.75
var d = 3.25

// 2
var calculation8Result = 2 * (c + 1) * 2 + 3 * (d + 1)
print(calculation8Result)

// 3 Ответ: Double потому что все переменные этого типа.
print(type(of: calculation8Result))

// Задание 9
// 1
let length = 17

// 2
let squareArea = length * length

// 3
let circlePerimeter = 2 * 3.14 * Double(length)

// 4
let calculation9Result = Double(squareArea) * circlePerimeter

// Задание 10
// 1
var stringVariable = "Hello"

// 2
let charConst: Character = "!"

// 3
let intVariableOne = 15
let intVariableTwo = 25

// 4
let stringResult = stringVariable + String(charConst) + String(intVariableOne + intVariableTwo)

// 5
print(stringResult)

// Задание 11
let graphicW = """
*   *   *
 * * * *
  *   *
"""
print(graphicW)

// Задание 12
// 1
var dayNumber = 2
var monthName = "May"
var yearNumber = 2020

// 2
print("\(yearNumber) \(monthName) \(dayNumber)")

// Задание 13
// 1
var logicVariableOne = true
var logicVariableTwo = false

// 2
var firstlLogicResult = logicVariableOne && logicVariableTwo
var secondLogicResult = logicVariableOne || logicVariableTwo

// Задание 14
// true
// true
// false

// Задание 15
// 1
let myName = "Anton"

// 2
var myWeight: Float = 89.8

// 3
var myHeight = 192

// 4
var myHeightModified = Float(myHeight) / 100
myHeightModified *= myHeightModified
var myWeightIndex = myWeight / myHeightModified

// 5
print("My name is \(myName) and my weight index is \(myWeightIndex)")

// Задание 16
// answer1 = 4610
// answer2 = 5600
// answer3 = 4601
// answer4 = 4600

// Задание 17
// (5 * 3) - ((4 / 2) * 2

// Задание 18
// 1
let a2: Double = 5.5
let b2: Double = 7.2

// 2
let average: Float = Float(a2 + b2) / Float(2)
