// Урок 13
// Задание 1

let greetings = { print("Hello, World!") }
greetings()
type(of: greetings)

// Задание 3
let stringClosure = { (str: String) in print(str) }
stringClosure("Some string")
type(of: stringClosure)

let stringClosure2: (String) -> Void = { print($0) }
stringClosure2("Some other string")

// Задание 4
let sumOfTwoInts: (Int, Int) -> Int = { $0 + $1 }
sumOfTwoInts(4, 7)

// Задание 5

// Первоначальный вариант
//let someClosure: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
//    return a * b
//}

// Упрощенный вариант
let someClosure: (Int, Int) -> Int = { $0 * $1 }
someClosure(5, 5)

// Задание 6
let substractionClosure: (Int, Int) -> Int = { $0 - $1}

func mathOperation (between num1: Int, and num2: Int, with closure: (Int, Int) -> Int) -> Int {
    closure(num1, num2)
}

mathOperation(between: 10, and: 8, with: substractionClosure)
mathOperation(between: 5, and: 5, with: *)

// Задание 7
func someAction() -> (() -> Int) {
    var currentValue = 0
    return {
        currentValue = currentValue + 1
        return currentValue
    }
}
let increment = someAction()
print(increment())
print(increment())

// Задание 8
var a = 11
var b = 22
let closure: () -> Int = { return a + b}
print(closure())
a = 10
b = 20
print(closure())

// Задание 9
let arrayOfInt = [2,55,1,2,77,24,1,2]
print(arrayOfInt.sorted(by: >))

// Задание 10
let arrayIfFloat = [2,4,6.2,11,2,7,6.7]
let sortedArray = arrayIfFloat.sorted() { $0 > $1 }
print(sortedArray)
