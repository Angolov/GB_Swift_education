// 1. Константы, переменные и типы данных
// Задача 1

// Константы
let intConst = 10
let uIntConst: UInt = 200
let floatConst: Float = 5.4
let doubleConst = 5.5
let stringConst = "Hello world"

// Переменные
var intVariable = 15
var uIntVariable: UInt = 255
var floatVariable: Float = 3.14
var doubleVariable = 1.27
var stringVariable = "First lines of code"

print("\(Int.min) \(Int.max)")
print("\(UInt.min) \(UInt.max)")

// Задача 2
// Создайте список товаров с различными характеристиками (количество, название). Используйте typealias.

// Задача 3
intVariable = Int(doubleConst)
doubleVariable = Double(floatVariable)
stringVariable += String(intConst)

// Задача 4
/*
import Foundation

var firstNumber: Decimal = 0
var secondNumber: Decimal = 0
var restart: Bool = true
var result: Decimal = 0

while restart == true {
    restart = false
    print("Input the first number:")
    if let userInput = readLine() {
        if let correctInput = Double(userInput){
            firstNumber = Decimal(correctInput)
        } else { 
            print("It is not a number.")
            restart = true
        }
    } else {
        print("There was no input.")
        restart = true
    }
    if restart == false {
        print("Input the second number:")
        if let userInput = readLine() {
            if let correctInput = Double(userInput){
                secondNumber = Decimal(correctInput)
            } else { 
                print("It is not a number.")
                restart = true
            }
        } else {
            print("There was no input.")
            restart = true
        }
    } 
    if restart == false {
        print("Input the type of operation to calculate:")
        if let userInput = readLine() {
            if userInput == "+" {
                result = firstNumber + secondNumber
            } else if userInput == "-" {
                result = firstNumber - secondNumber
            } else if userInput == "*" {
                result = firstNumber * secondNumber
            } else if userInput == "/" {
                result = firstNumber / secondNumber
            } else { 
                print("Wrong operation type.")
                restart = true
            }
        } else {
            print("There was no input.")
            restart = true
        }
    }
}

print("The result is: \(result)")
*/
// Задача 5
var stringReadline = "Input string"
if let correctInput = readLine(){
    stringReadline = correctInput
    print(stringReadline)
}
if let correctInput = readLine(){
    stringReadline = correctInput
    print(stringReadline)
}
print(stringReadline)

// 2. Строки
// Задача 1
let stringOne = "Anton"
let stringTwo = "Golovatyy"
let stringThree = "32"
let stringFour = "Moscow"

// Задача 2
let resultString = "\(stringOne) \(stringTwo) age of \(stringThree), lives in \(stringFour)"
print(resultString)

// Задача 3
let stringFive = "sales"
let stringSix = "traveling on motorcycle"
let stringSeven = "programming and DevSecOps"
let stringEight = "married"
let stringNine = "three children"
let stringTen = "two girls and a boy"

let resultString2 = resultString + ".\nWorks in \(stringFive).\nHis hobby is \(stringSix).\nNow he is studying \(stringSeven).\nHe is \(stringEight) and has \(stringNine): \(stringTen)."
print(resultString2)

// Задача 4
var myName = stringOne
while !myName.isEmpty{
    if let correctChar = myName.first { print(correctChar) }
    myName.removeFirst()
}

// Задача 5
var someNumber = 1500
var someString = "The number is equal to "

someString += String(someNumber)
print(someString)

// Продвинутый уровень
// Задача 1
let cityOne = "Moscow"
let cityTwo = "London"
let cityThree = "New York"
let cityFour = "Berlin"
let cityFive = "Milan"

let countryOne = "Russia"
let countryTwo = "UK"
let countryThree = "USA"
let countryfour = "Germany"
let countryFive = "Italy"

if cityOne == "Moscow" && countryOne == "Russia" { print("\(cityOne) \(countryOne) Correct!") } 
else{ print("\(cityOne) \(countryOne) Incorrect!") }
if cityThree == "New York" && countryTwo == "USA"{ print("\(cityThree) \(countryTwo) Correct!") }
else{ print("\(cityThree) \(countryTwo) Incorrect!") }

// Задача 2
cityOne.contains("a")
cityFive.contains("a")

// Задача 3
let cyrilicString = "Привет"

// Задача 4
import Foundation

let upperCased = cyrilicString.uppercased()
var latinString: NSString = cyrilicString.lowercased() as NSString
latinString.applyingTransform(kCFStringTransformToLatin as StringTransform, reverse: false)


// Задача 5
var tempString = cyrilicString
var indexOfCharacter = 0

while !tempString.isEmpty{
    if let stringCharacter = tempString.first { print("\(stringCharacter) at index number \(indexOfCharacter)") }
    tempString.removeFirst()
    indexOfCharacter += 1
}








