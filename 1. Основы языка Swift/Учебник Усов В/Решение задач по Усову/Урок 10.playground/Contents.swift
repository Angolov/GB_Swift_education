// Урок 10
// Задание 1

let name = "Alex"

switch name {
case "Alex": 
    print("Hi \(name)")
case "Andrew":
    print ("Hello \(name)!")
case "Julia":
    print("Nice to meet you \(name)")
default:
    print("Wrong name!")
}

if name == "Alex"{
    print("Hi \(name)")
} else if name == "Andrew"{
    print ("Hello \(name)!")
} else if name == "Julia"{
    print("Nice to meet you \(name)")
} else {
    print("Wrong name!")
}

// Задание 2
var open: Bool = false

// Длинный вариант, последствия СИшника)))
var openString: String

if open {
    openString = "открыто"
} else {
    openString = "закрыто"
}

// Красивый вариант
openString = open ? "открыто" : "закрыто"

// Задание 3
var var1 = 10
var var2 = 27
var var3 = -30

let result = max(var1, var2, var3)
print(type(of: result))

// Задание 4
import Foundation

var tuple1 = (10, 20)
var tuple2 = (0, 0)
var tuple3 = (0, 10)

// Первая проверка, не совпадает ли любая пара точек
if tuple1 == tuple2 || tuple1 == tuple3 || tuple2 == tuple3 {
    print("Это не треугольник")
} else {
    // Находим длины сторон
    var xDistance = Double(tuple1.0 - tuple2.0)
    var yDistance = Double(tuple1.1 - tuple2.1)
    let side1 = sqrt(xDistance * xDistance + yDistance * yDistance)
    
    xDistance = Double(tuple1.0 - tuple3.0)
    yDistance = Double(tuple1.1 - tuple3.1)
    let side2 = sqrt(xDistance * xDistance + yDistance * yDistance)
    
    xDistance = Double(tuple2.0 - tuple3.0)
    yDistance = Double(tuple2.1 - tuple3.1)
    let side3 = sqrt(xDistance * xDistance + yDistance * yDistance)
    
    // Проверка на "треугольник"
    let sideLengthSum1 = side1 + side2
    let sideLenghtSum2 = side1 + side3
    let sideLenghtSum3 = side2 + side3
    
    if sideLengthSum1 > side3 && sideLenghtSum2 > side2 && sideLenghtSum3 > side1 {
        print("Треугольник существует")
    } else {
        print("Это не треугольник")
    }
}

// Задание 5
var lang = "en"
var days: Array<String> = []

switch lang {
case "ru":
    days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вск"]
case "en":
    days = ["Mon", "Tue", "Wed", "Thur", "Fr", "Sat", "Sun"]
default:
    break
}

// Задание 6
var chars = "down"

switch lang {
case "ru" where chars == "up":
    days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вск"]
case "ru" where chars == "down":
    days = ["пн", "вт", "ср", "чт", "пт", "сб", "вск"]
case "en" where chars == "up":
    days = ["Mon", "Tue", "Wed", "Thur", "Fr", "Sat", "Sun"]
case "en" where chars == "down":
    days = ["mon", "tue", "wed", "thur", "fr", "sat", "sun"]
default:
    break
}
print(days)

// Задание 7
typealias Operation = (operandOne: Double, operandTwo: Double, operation: Character)

let firstOperation: Operation = (3.1, 33, "+")
//let firstOperation: Operation = (24.9, 22.32, "*")
//let firstOperation: Operation = (11.3, 5, "/")
//let firstOperation: Operation = (5, 2.5, "-")

var resultOfOperation: Double = 0

switch firstOperation {
case (let operandOne, let operandTwo, "+"):
    resultOfOperation = operandOne + operandTwo
case (let operandOne, let operandTwo, "-"):
    resultOfOperation = operandOne - operandTwo
case (let operandOne, let operandTwo, "*"):
    resultOfOperation = operandOne * operandTwo
case (let operandOne, let operandTwo, "/"):
    resultOfOperation = operandOne / operandTwo
default: print("Wrong input values")
}
print(resultOfOperation)

