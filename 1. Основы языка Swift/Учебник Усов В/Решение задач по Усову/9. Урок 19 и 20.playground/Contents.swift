import Darwin

// Урок 19
// Задание 1

enum ArithmeticExpression {
    // указатель на конкретное значение
    case number(Int)
    // указатель на операцию сложения
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    // указатель на операцию вычитания
    indirect case subtraction(ArithmeticExpression, ArithmeticExpression)
    // указатель на операцию умножения
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
    // указатель на операцию вычитания
    indirect case division(ArithmeticExpression, ArithmeticExpression)
    // указатель на операцию вычитания
    indirect case power(ArithmeticExpression, ArithmeticExpression)
    // метод, проводящий операцию
    func evaluate(_ expression: ArithmeticExpression? = nil) -> Int {
        // определение типа операнда (значение или операция)
        switch expression ?? self {
        case let .number(value):
            return value
        case .addition(let valueLeft, let valueRight):
            return evaluate(valueLeft) + evaluate(valueRight)
            
        case .subtraction(let valueLeft, let valueRight):
            return evaluate(valueLeft) - evaluate(valueRight)
            
        case .multiplication(let valueLeft, let valueRight):
            return evaluate(valueLeft) * evaluate(valueRight)
            
        case .division(let valueLeft, let valueRight):
            return evaluate(valueLeft) / evaluate(valueRight)
            
        case .power(let valueLeft, let valueRight):
            var result = evaluate(valueLeft)
            
            if evaluate(valueRight) == 0 {
                return 1
            } else {
                for _ in 1..<evaluate(valueRight) {
                    result *= evaluate(valueLeft)
                }
            }
            return result
        }
    }
}

var hardExpr = ArithmeticExpression.addition( .number(20),
              .subtraction( .number(10), .number(34) ) )
hardExpr.evaluate() // -4

hardExpr = .multiplication(.number(10), .division(.number(20), .number(10)))
hardExpr.evaluate()

hardExpr = .power(.number(2), .number(4))
hardExpr.evaluate()

// Задание 2
enum Seasons {
    case winter, spring, summer, autumn
}
let whiteSeason = Seasons.winter
var greenSeason: Seasons = .spring
greenSeason = .summer
var orangeSeason = Seasons.autumn
var bestSeason = whiteSeason
bestSeason = .summer

// Задание 3
enum Chessman {
    enum Color {
        case black, white
    }
    case king (color: Color)
    case queen (color: Color)
    case rook (color: Color)
    case bishop (color: Color)
    case knight (color: Color)
    case pawn (color: Color)
}

let chessKing = Chessman.king(color: .white)
var chessBishop = Chessman.bishop(color: .black)
var chessPawn = Chessman.pawn(color: .white)

switch chessBishop {
case .king(let color):
    if color == .black {
        print("Black king")
    } else {
        print("White king")
    }
case .queen(let color):
    if color == .black {
        print("Black queen")
    } else {
        print("White queen")
    }
case .rook(let color):
    if color == .black {
        print("Black rook")
    } else {
        print("White rook")
    }
case .bishop(let color):
    if color == .black {
        print("Black bishop")
    } else {
        print("White bishop")
    }
case .knight(let color):
    if color == .black {
        print("Black knight")
    } else {
        print("White knight")
    }
case .pawn(let color):
    if color == .black {
        print("Black pawn")
    } else {
        print("White pawn")
    }
}

let chessColor: Chessman.Color = .black

// Задание 4
enum Day {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    var label: String {
        switch self{
        case .monday:
            return "Понедельник"
        case .tuesday:
            return "Вторник"
        case .wednesday:
            return "Среда"
        case .thursday:
            return "Четверг"
        case .friday:
            return "Пятница"
        case .saturday:
            return "Суббота"
        case .sunday:
            return "Воскресенье"
        }
    }
}

let mon = Day.monday
print(mon.label)
print(Day.friday.label)

// Урок 20
// Задание 1
func power (_ number: Int, _ exponent: Int) -> Double {
    
    if exponent == 0 {
        return 1.0
    } else {
        var result = Double(number)
        for _ in 1..<exponent {
            result *= Double(number)
        }
        return result
    }
}

struct Point {
    var x: Int
    var y: Int
    
    func distance(between point2: Point) -> Double {
        return ( power((point2.x - self.x), 2) + power((point2.y - self.y), 2)).squareRoot()
    }
}

var somePoint = Point(x: 10, y: 20)
var anotherPoint = Point(x: 15, y: 22)
somePoint.distance(between: anotherPoint)

// Задание 2

enum Color: String {
    case black = "black"
    case white = "white"
}

enum Figure: String {
    case king = "king"
    case queen = "aueen"
    case rook = "rook"
    case bishop = "bishop"
    case knight = "knight"
    case pawn = "pawn"
}

var someColor = Color.black
var someFigure = Figure.bishop

struct Chessman2 {
    let color: Color
    let figure: Figure
    let symbol: Character
    var coordinates: (Character, UInt)?
    
    init (_ figure: Figure, _ color: Color) {
        self.color = color
        self.figure = figure
        self.symbol = "?"
        self.coordinates = nil
    }
    
    init (_ figure: Figure, _ color: Color, _ symbol: Character, _ coords: (Character, UInt)?) {
        self.color = color
        self.figure = figure
        self.symbol = symbol
        self.coordinates = coords
    }
    
    mutating func setCoordinates(_ char: Character,_ num: UInt) {
        self.coordinates = (char, num)
    }
    
    mutating func kill() {
        self.coordinates = nil
    }
}

var whiteKing = Chessman2(.king, .white)
whiteKing.coordinates
whiteKing.setCoordinates("B", 1)
whiteKing.coordinates
whiteKing.kill()
whiteKing.coordinates

// Задание 3

struct User {
    var name: String
    var surname: String
    
    init (name: String) {
        self.name = name
        self.surname = ""
    }
    
    init (name: String, surname:String) {
        self.name = name
        self.surname = surname
    }
    
    func description() -> String {
        return "User name is \(self.name) \(self.surname)"
    }
    
    mutating func changeName(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }
}

var someUser = User(name: "Ivan")
print(someUser.description())

someUser = User(name: "Ivan", surname: "Petrov")
print(someUser.description())

someUser.changeName(name: "Petr", surname: "Sidorov")
print(someUser.description())
