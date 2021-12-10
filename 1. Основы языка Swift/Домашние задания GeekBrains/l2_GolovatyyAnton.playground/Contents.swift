//
//  l2_GolovatyyAnton.playground
//
//  Created by Антон Головатый on 21.11.2021.
//

// Домащнее задание по уроку №2


// Упражнение 1
// Написать функцию, которая определяет, четное число или нет.
func isEven (_ num: Int) -> Bool {
    return num % 2 == 0
}



// Упражнение 2
// Написать функцию, которая определяет, делится ли число без остатка на 3
func isDividedByThree (_ num: Int) -> Bool {
    return num % 3 == 0
}



// Упражнение 3
// Создать возрастающий массив из 100 чисел
print("=====================================================================================================\n")
print("Упражнение 3\n")

// Халявный вариант и сразу упорядоченный
var niceArray = [Int](1...100)

print("Халявный массив:\n\(niceArray)\n")

// Рандомный вариант (для оптимизации взят тип UInt8 в качеcтве источника элементов массива)
var randomArray = [Int]()

for _ in 1...100 {
    randomArray.append(Int(UInt8.random(in: UInt8.min...UInt8.max)))
}

randomArray.sort()
print("Массив из рандомных элементов (в качестве источника взят тип UInt8):\n\(randomArray)\n")



// Упражнение 4
print("=====================================================================================================\n")
print("Упражнение 4\n")

// Удалить из массива все четные числа и все числа, которые не делятся на 3.
func removeElements (from array: [Int],
                     that firstCheck: (Int) -> Bool,
                     and secondCheck: (Int) -> Bool) -> [Int] {
    
    var resultArray = array
    
    for number in resultArray {
        if firstCheck(number) || secondCheck(number) {
            if let index = resultArray.firstIndex(of: number){
                resultArray.remove(at: index)
            }
        }
    }
    
    return resultArray
}

let isEven = { $0 % 2 == 0 }
let isntDividedByThree = { $0 % 3 != 0 }

var resultArray = removeElements(from: niceArray,that: isEven,and: isntDividedByThree)
print("Из халявного массива убраны все четные и все числа, которые не делятся на 3:\n\(resultArray)\n")

resultArray = removeElements(from: randomArray,that: isEven,and: isntDividedByThree)
print("Из рандомного массива убраны все четные и все числа, которые не делятся на 3:\n\(resultArray)\n")

// Вариант с filter и замыканием. Лаконично и красиво :)
resultArray = randomArray.filter() { !isEven($0) && isDividedByThree($0) }
print("Из рандомного массива убраны через filter() все четные и все числа, которые не делятся на 3:\n\(resultArray)\n")



// Упражнение 5*
print("=====================================================================================================\n")
print("Упражнение 5\n")

// Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.

// Вариант без рекурсии, но с пробросом массива
func addFiboElements (to array: inout [Int]) -> Void {
    let endIndex = array.endIndex
    
    if endIndex == 0 || endIndex == 1 {
        array.append(1)
    } else {
        array.append(array[endIndex - 1] + array[endIndex - 2])
    }
}

var fiboSequence = [Int]()

for _ in 1...50 {
    addFiboElements(to: &fiboSequence)
}

print("50 первых элементов последовательности Фибоначи:\n\(fiboSequence)\n")

// Вариант с рекурсивной функцией
func recurseGetFiboArray(of maxNum: Int) -> [Int] {
    
    var resultArray = [Int]()
    
    switch maxNum {
    case 2:
        resultArray = recurseGetFiboArray(of: maxNum - 1)
        fallthrough
    case 1:
        resultArray.append(1)
    default:
        resultArray = recurseGetFiboArray(of: maxNum - 1)
        resultArray.append(resultArray[maxNum - 2] + resultArray[maxNum - 3])
    }
    return resultArray
}

fiboSequence = recurseGetFiboArray(of: 50)
print("50 первых элементов последовательности Фибоначи с использованием рекурсии:\n\(fiboSequence)\n")



// Упражнение 6*
print("=====================================================================================================\n")
print("Упражнение 6\n")

// Заполнить массив элементов различными простыми числами (не больше заданного числа n, пусть будет 100).
func createArrayOfPrimes (below upperBorder: Int) -> [Int] {
    var primeNumber = 2
    var temporaryNumber = primeNumber * 2
    var arrayOfPrimes = [Int](1...upperBorder)
    
    repeat {

        repeat {
            if let index = arrayOfPrimes.firstIndex(of: temporaryNumber) {
                arrayOfPrimes.remove(at: index)
            }
            temporaryNumber += primeNumber
        } while temporaryNumber <= upperBorder

        if let index = arrayOfPrimes.firstIndex(of: primeNumber) {
            primeNumber = index < arrayOfPrimes.endIndex - 1 ? arrayOfPrimes[index + 1] : upperBorder
            temporaryNumber = primeNumber * 2
        }

    } while primeNumber < upperBorder

    return arrayOfPrimes
}

let arrayOfPrimes = createArrayOfPrimes(below: 100)

print("Массив из простых числе меньше 100:\n\(arrayOfPrimes)")
