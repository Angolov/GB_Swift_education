// Урок 11
// Задание 1
var easy: String? // nil
var medium: String! // nil, обращение вызывает ошибку
var hard: String // Нет значения, обращение вызывает ошибку

// Задание 2
// Разница между easy и medium в том, что в момент обращения к medium уже не должно быть в нем значения nil. По сути этот опционал уже "извлечен"

// Задание 3
easy = "1"
medium = "contra"
hard = "play game"
easy = medium
hard = medium
//easy = hard! // это не опционал
easy = hard
var gameTuple = (easy, Optional(hard))
var gameText: String
if let text = gameTuple.0 {
    gameText = text
}

// Задание 4
var firstString: String? = "abcde"
var secondString = String(3.14)
var thirdString = Optional("abcde")

// Задание 5
typealias Text = String

let firstText: Text = "12345"
let secondText: Text = "34853"
let thirdText: Text = "1sfjh2198"

let textArray: Array<Text> = [firstText, secondText, thirdText]

for text in textArray{
    if let numbers = Int(text) {
        print(numbers)
    }
}

// Задание 6
typealias TupleType = (numberOne: Text?, numberTwo: Text?)

var tupleTypeOne: TupleType = ("190", "67")
var tupleTypeTwo: TupleType = ("100", nil)
var tupleTypeThree: TupleType = ("-65", "70")

var tupleTypeArray: Array<TupleType> = [tupleTypeOne, tupleTypeTwo, tupleTypeThree]

for tupleType in tupleTypeArray {
    switch tupleType {
    case (let numberOne, let numberTwo) where numberOne != nil && numberTwo != nil:
            print("\(numberOne!), \(numberTwo!)")
    default:
        break
    }
}

// Задание 7
var studyRecords: Dictionary<String, Dictionary<String, UInt>> = [:]

studyRecords["Belov"] = ["10-11-21": 5, "18-11-21": 3]
studyRecords["Alexandrov"] = ["10-11-21": 2, "18-11-21": 3]
studyRecords["Nikolskaya"] = ["10-11-21": 4, "18-11-21": 5]

var averageGradePerClass: Float = 0
var gradesCounter = 0

for student in studyRecords {
    var averageGradePerStudent: Float = 0
    for grades in student.value {
        averageGradePerStudent += Float(grades.value)
        gradesCounter += 1
    }
    averageGradePerClass += averageGradePerStudent
    let numberOfGrades = Float(student.value.count)
    averageGradePerStudent /= numberOfGrades
    print("\(student.key) has average grade of: \(averageGradePerStudent)")
}
averageGradePerClass /= Float(gradesCounter)
print("The class has average grade of: \(averageGradePerClass)")

// Задание 8
studyRecords["Belov"]?["19-11-21"] = 5

// Задание 9

// Пример "говно кода", но по учебнику
/*
typealias Coordinates = (alpha: Character?, num: Int?)
typealias Chessman = [String: Coordinates]

var figures: Chessman = [:]
figures["White King"] = ("A", 7)
figures["Black King"] = ("B", 4)
figures["White Queen"] = nil
 
for singleFigure in figures {
    if singleFigure.value.alpha == nil || singleFigure.value.num == nil {
        print("\(singleFigure.key) is dead")
    } else {
        print("\(singleFigure.key) coordinates are \(singleFigure.value.alpha!)\(singleFigure.value.num!)")
    }
}
*/

// Как сделать лучше
typealias Coordinates = (alpha: Character, num: Int)
typealias Chessman = [String: Coordinates?]

var figures: Chessman = [:]
figures["White King"] = ("A", 7)
figures["Black King"] = ("B", 4)
figures["White Queen"] = nil

for singleFigure in figures {
    if let coordinates = singleFigure.value {
        print("\(singleFigure.key) coordinates are \(coordinates.alpha)\(coordinates.num)")
    } else {
        print("\(singleFigure.key) is dead")
    }
}









