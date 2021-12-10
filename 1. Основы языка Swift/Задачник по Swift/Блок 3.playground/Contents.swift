// 3. Массивы
// Задача 1
var studentsArray: Array<String> = ["Alex", "Greg", "Mike", "Anton", "John", "Samuel", "Lex", "Adam", "Fred", "Harry", "Kevin", "Walter"]

// Задача 2
studentsArray.append("Elizabeth")
studentsArray.append("Nicole")
studentsArray.append("Tina")
studentsArray.insert("Alice", at: 3)
studentsArray.insert("Kate", at: 7)
studentsArray.insert("Marry", at: 5)
studentsArray.insert("Zoe", at: 10)

// Задача 3
studentsArray.removeSubrange(0...7)
studentsArray.remove(at: 1)
print(studentsArray)

// Задача 4
let marksArrayOne: Array<Int> = [0, 1, 2, 3, 4, 5]
let marksArrayTwo: Array<Int> = [6, 7, 8, 9, 10]
let marksArray = marksArrayOne + marksArrayTwo
print(marksArray)

// Задача 5
for i in 0...studentsArray.count-1 {
    if let existMark = marksArray.randomElement(){
        let randomMark = Int(existMark)
        switch randomMark {
        case 0...4:
            studentsArray[i] += " - \(randomMark). Not good."
        case 5...7:
            studentsArray[i] += " - \(randomMark). Nice job!"
        case 8...10:
            studentsArray[i] += " - \(randomMark). You're great!"
        default:
            break
        }
    }
}
print(studentsArray)

// Задача 6
let moneyArray = [1, 5, 2, 1, 10, 25, 50, 100, 100, 10, 5, 25]
var moneySum: Int = 0
for money in moneyArray {
    moneySum += money
}
print(moneySum)

// Задача 7
let firstString = "Russia"
let secondString = "America"
let thirdString = "UK"
let forthString = "Germany"
let fifthString = "Italy"
let sixthString = "France"
let seventhString = "Norway"
let eightString = "Sweden"
let ninethString = "Denmark"
let tenthString = "Spain"

var countryArray: Array<String> = []
let tempArray = [firstString, secondString, thirdString, forthString, fifthString, sixthString, seventhString, eightString, ninethString, tenthString]

for string in tempArray {
    if string.count >= 5 {
        if string.contains("A") {
            var tempString: String = string
            var indexA = string.firstIndex(of: "A")!
            tempString.insert("B", at: indexA)
            indexA = tempString.firstIndex(of: "A")!
            tempString.remove(at: indexA)
            countryArray.append(tempString)
        } else {
            countryArray.append(string)
        }
    }
}
print(countryArray)

// Задача 8 Линейная сортировка
var exampleArray = [3, 6, 1, 15, 20, 10, 4, 2, 7, 9]

for i in 0...exampleArray.count-2 {
    let exampleArraySlice = exampleArray[i...exampleArray.count-1]
    let minimumNumberIndex = exampleArraySlice.firstIndex(of: exampleArraySlice.min()!)!
    (exampleArray[i], exampleArray[minimumNumberIndex]) = (exampleArray[minimumNumberIndex], exampleArray[i])
}
let linearSortedArray = exampleArray

// Задача 9 Сортировка пузырьком
exampleArray = [3, 6, 1, 15, 20, 10, 4, 2, 7, 9]

for i in 0...exampleArray.count-2 {
    for j in 0...exampleArray.count-2-i {
        if exampleArray[j] > exampleArray[j+1] {
            (exampleArray[j], exampleArray[j+1]) = (exampleArray[j+1], exampleArray[j])
        }
    }
}
let bubleSortedArray = exampleArray

// Задача 10 Метод быстрой сортировки
// 2 10 5 1 3 4 7
// 1 step 2 10 1 5 3 4 7
// 2 step 2 3 1 5 10 4 7
// 3 step 2 3 1 5 10 4 7
// 4 step 2 3 1 5 10 4 7

exampleArray = [3, 6, 1, 15, 20, 10, 4, 2, 7, 9]

let midElement = exampleArray[exampleArray.count/2]
var i = 0
var j = exampleArray.count-1

// Необходимы знания по функциям, чтобы реализовать рекурсивный механизм. Повторять N раз код не корректно.
while i <= j {
    while exampleArray[i] < midElement {
        i += 1
    }
    while exampleArray[j] > midElement {
        j -= 1
    }
    if i <= j {
        (exampleArray[i], exampleArray[j]) = (exampleArray[j], exampleArray[i])
        i += 1
        j -= 1
    }
}
exampleArray

//i = 0
//j = exampleArray.firstIndex(of: midElement)!-1
//let midElement2 = exampleArray[j/2]
//while i <= j {
//    while exampleArray[i] < midElement2 {
//        i += 1
//    }
//    while exampleArray[j] > midElement2 {
//        j -= 1
//    }
//    if i <= j {
//        (exampleArray[i], exampleArray[j]) = (exampleArray[j], exampleArray[i])
//        i += 1
//        j -= 1
//    }
//}
//exampleArray
//
//i = 0
//j = exampleArray.firstIndex(of: midElement2)!-1
//let midElement3 = exampleArray[j/2]
//while i <= j {
//    while exampleArray[i] < midElement3 {
//        i += 1
//    }
//    while exampleArray[j] > midElement3 {
//        j -= 1
//    }
//    if i <= j {
//        (exampleArray[i], exampleArray[j]) = (exampleArray[j], exampleArray[i])
//        i += 1
//        j -= 1
//    }
//}
//exampleArray

// Задача 11 Сортировка коктейлем)
exampleArray = [3, 6, 1, 15, 20, 10, 4, 2, 7, 9]

var isSwapped = false

mainloop: repeat {
    for i in 0...exampleArray.count-2 {
        if exampleArray[i] > exampleArray[i+1] {
            (exampleArray[i], exampleArray[i+1]) = (exampleArray[i+1], exampleArray[i])
            isSwapped = true
        }
    }
    if !isSwapped {
        break mainloop
    }
    isSwapped = false
    for i in 1...exampleArray.count-1 {
        let j = exampleArray.count - i
        if exampleArray[j-1] > exampleArray[j] {
            (exampleArray[j], exampleArray[j-1]) = (exampleArray[j-1], exampleArray[j])
            isSwapped = true
        }
    }
} while isSwapped

let coctailSortedArray = exampleArray

// Задача 12 Сортировка по чет-нечет алгоритму

exampleArray = [3, 6, 1, 15, 20, 10, 4, 2, 7, 9]

mainloop2: repeat {
    isSwapped = false
    for i in 0...exampleArray.count-2 {
        if (i % 2) == 0 {
            if exampleArray[i] > exampleArray[i+1] {
                (exampleArray[i], exampleArray[i+1]) = (exampleArray[i+1], exampleArray[i])
                isSwapped = true
            }
        }
    }
    for i in 1...exampleArray.count-2 {
        if (i % 2) != 0 {
            if exampleArray[i] > exampleArray[i+1] {
                (exampleArray[i], exampleArray[i+1]) = (exampleArray[i+1], exampleArray[i])
                isSwapped = true
            }
        }
    }
} while isSwapped

let oddEvenSortedArray = exampleArray
