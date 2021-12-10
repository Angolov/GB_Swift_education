// 4 Словари
// Задание 1

let ruMonths: Dictionary<Int, String> = [1: "январь", 2: "февраль", 3: "март", 4: "апрель", 5: "май", 6: "июнь", 7: "июль", 8: "август", 9: "сентябрь", 10: "октябрь", 11: "ноябрь", 12: "декабрь"]
let enMonths: Dictionary<Int, String> = [1: "january", 2: "february", 3: "march", 4: "april", 5: "may", 6: "june", 7: "july", 8: "august", 9: "september", 10: "october", 11: "november", 12: "december"]

// Задание 2
print(ruMonths.keys)
print(ruMonths.values)
print(enMonths.keys)
print(enMonths.values)

// Задание 3 и 4
var cars: Dictionary<String, String> = [:]

if cars.isEmpty {
    cars["Range Rover"] = "Evoque"
}

// Задание 5
cars["Lada"] = "Vesta"

print(cars.keys)
print(cars.values)

cars.removeValue(forKey: "Range Rover")
cars["Lada"] = nil

// Задание 6
var soldiers = ["Ivanov": "Hi", "Petrov": "Ho", "Sidorov": "Aloha"]

// Задание 7
for soldier in soldiers {
    print(soldier.key)
}

// Задание 8
for soldier in soldiers {
    print(soldier.value)
}

// Задание 9
let sortedDictionary = soldiers.sorted(by: { $0.key < $1.key } )
sortedDictionary

// Задание 10
for soldier in soldiers {
    print(soldier.key)
    if soldier.key == "Ivanov" {
        print("It is a sniper")
    }
}

// 5 Кортежи
// Задание 1
let tuple1 = (1, "abcd", "red", 2.0)

print(tuple1.0, tuple1.1, tuple1.2, tuple1.3)

// Задание 2
typealias GaiTuple = (speeder: Int, drunkDrivers: Int, noDocs: Int)

let firstGaiTuple: GaiTuple = (10, 15, 0)

print(firstGaiTuple)

// Задание 3
print(firstGaiTuple.0, firstGaiTuple.1, firstGaiTuple.2)
print(firstGaiTuple.speeder, firstGaiTuple.drunkDrivers, firstGaiTuple.noDocs)

// Задание 4
let secondGaiTuple: GaiTuple = (50, 2, 5)

// Задание 5
var tupleDifference: GaiTuple = (0, 0, 0)

if firstGaiTuple.speeder >= secondGaiTuple.speeder {
    tupleDifference.speeder = firstGaiTuple.speeder - secondGaiTuple.speeder
} else {
    tupleDifference.speeder = secondGaiTuple.speeder - firstGaiTuple.speeder
}
if firstGaiTuple.drunkDrivers >= secondGaiTuple.drunkDrivers {
    tupleDifference.drunkDrivers = firstGaiTuple.drunkDrivers - secondGaiTuple.drunkDrivers
} else {
    tupleDifference.drunkDrivers = secondGaiTuple.drunkDrivers - firstGaiTuple.drunkDrivers
}
if firstGaiTuple.noDocs >= secondGaiTuple.noDocs {
    tupleDifference.noDocs = firstGaiTuple.noDocs - secondGaiTuple.noDocs
} else {
    tupleDifference.noDocs = secondGaiTuple.noDocs - firstGaiTuple.noDocs
}
print(tupleDifference)

// Задание 6 и 7
typealias Programmer = (name: String, age: UInt?, experience: UInt?, specialization: String?)

var listOfProgrammers: Array<Programmer> = []

listOfProgrammers.append(("Alex", 24, 2, "ios"))
listOfProgrammers.append(("Mark", 19, nil, nil))
listOfProgrammers.append(("Adam", 22, nil, nil))
listOfProgrammers.append(("Kate", 30, 0, "ios"))
listOfProgrammers.append(("Nicole", 20, nil, nil))
listOfProgrammers.append(("John", nil, 4, "c++"))
listOfProgrammers.append(("Meloni", 27, 5, "java"))

// Задание 8-10
var resultArray: Array<Programmer> = []

for programmer in listOfProgrammers {
    if let age = programmer.age {
        if let specialization = programmer.specialization {
            if age > 23 && programmer.experience != nil && specialization == "ios" {
                print("\(programmer.name) is good for the job.")
            } else if specialization != "ios" {
                resultArray.append(programmer)
            }
        }
        if age < 23 {
            resultArray.append(programmer)
        }
    }
}
resultArray
resultArray.sort(by: {$0.age ?? 100 < $1.age ?? 100 } )
resultArray
