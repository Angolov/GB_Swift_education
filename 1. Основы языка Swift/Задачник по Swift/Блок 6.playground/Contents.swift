// Блок 6 Управление потоком: циклы
// Задание 1

typealias DaysMonths = (month: String, numberOfDays: UInt8)
var daysInMonths: Array<DaysMonths> = []
daysInMonths.append(("january", 31))
daysInMonths.append(("february", 28))
daysInMonths.append(("march", 31))
daysInMonths.append(("april", 30))
daysInMonths.append(("may", 31))
daysInMonths.append(("june", 30))
daysInMonths.append(("july", 31))
daysInMonths.append(("august", 31))
daysInMonths.append(("september", 30))
daysInMonths.append(("october", 31))
daysInMonths.append(("november", 30))
daysInMonths.append(("december", 31))

for month in daysInMonths {
    print("There are \(month.numberOfDays) days in \(month.month).")
}

// Задача 2
let ageOfMan = 27

if ageOfMan < 7 {
    print("Go to kindergarden!")
} else if ageOfMan >= 7 && ageOfMan < 18 {
    print("Go to school!")
} else if ageOfMan >= 18 && ageOfMan < 24 {
    print("Go to university!")
} else if ageOfMan >= 24 && ageOfMan < 55 {
    print("Go to work!")
} else {
    print("Youre old enough, take a rest!")
}

switch ageOfMan {
case 0...6:
    print("Go to kindergarden!")
case 7...17:
    print("Go to school!")
case 18...23:
    print("Go to university!")
case 24...54:
    print("Go to work!")
default:
    print("Youre old enough, take a rest!")
}

// Задание 3
let schoolMark = 7

if schoolMark < 5 {
    print("Not so good, try harder!")
} else if schoolMark < 7 {
    print("Not great, but you've passed!")
} else if schoolMark < 10 {
    print("Not bad at all!")
} else {
    print("Great results!")
}

switch schoolMark {
case 0...4:
    print("Not so good, try harder!")
case 5...6:
    print("Not great, but you've passed!")
case 7...9:
    print("Not bad at all!")
case 10...12:
    print("Great results!")
default: break
}

// Задание 4
var l = 0
for _ in 1...200 {
    for _ in 1...15 {
        l += 1
    }
    break
    //l += 1
}
print(l)

// Задание 5-8 Псевдо-шахматы
typealias ChessCoordinates = (char: Character, number: Int)
typealias ChessFigure = (figure: Character, coords: ChessCoordinates)

var chessBoard: Array<ChessFigure> = []

chessBoard.append(("\u{265A}", ("h", 7))) // Black king
chessBoard.append(("\u{265F}", ("d", 5))) // Black pawn
chessBoard.append(("\u{265F}", ("a", 7))) // Another black pawn
chessBoard.append(("\u{265C}", ("c", 8))) // Black rook
chessBoard.append(("\u{2654}", ("b", 1))) // White king
chessBoard.append(("\u{2655}", ("f", 3))) // White queen
chessBoard.append(("\u{2659}", ("c", 2))) // White pawn
chessBoard.append(("\u{2656}", ("d", 1))) // White rook

chessBoard

// Делаем ход черной турой
// сначала будет ошибочный ход "сквозь" пешку

var endCoordinates: ChessCoordinates = ("c", 1)
var chessCoordinates: Array<ChessCoordinates> = []
var isPossibleMove = true

for figure in chessBoard {
    chessCoordinates.append(figure.coords)
}
chessCoordinates.remove(at: 3)
chessCoordinates
for i in 0...chessBoard[3].coords.number-endCoordinates.number-1 {
    let currentCoordsToCheck: ChessCoordinates = (endCoordinates.char, chessBoard[3].coords.number - i)
    for coords in chessCoordinates {
        if currentCoordsToCheck == coords {
            isPossibleMove = false
        }
    }
}
if !isPossibleMove {
    print("You cannot move through other figures with a rook")
}

// Съедаем фигуру соперника
endCoordinates = ("c", 2)
isPossibleMove = true

for i in 0...chessBoard[3].coords.number-endCoordinates.number-1 {
    let currentCoordsToCheck: ChessCoordinates = (endCoordinates.char, chessBoard[3].coords.number - i)
    for coords in chessCoordinates {
        if currentCoordsToCheck == coords {
            print(currentCoordsToCheck)
            print(coords)
            isPossibleMove = false
        }
    }
}
if isPossibleMove {
    var isKilled = false
    var index = 0
    for coords in chessCoordinates {
        if endCoordinates == coords {
            isKilled = true
            break
        }
        index += 1
    }
    chessCoordinates.insert(endCoordinates, at: 3)
    if isKilled {
        chessCoordinates.remove(at: index + 1)
        chessBoard[3].coords = endCoordinates
        chessBoard.remove(at: index + 1)
    }
} else {
    print("You cannot move through other figures with a rook")
}
chessBoard
