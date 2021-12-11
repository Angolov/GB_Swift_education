// Урок 22
// Упражнение 1 (единственное)

class RandomNumberGenerator {
    let min: Int
    let max: Int
    
    init(min: Int, max: Int) {
        self.min = min
        self.max = max
    }
    
    func getNumber() -> Int {
        return Int.random(in: min...max)
    }
}

struct Employee {
    let firstName: String
    let lastName: String
    var salary: Int
    
    init(firstName: String, lastName: String, salary: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.salary = salary
    }
    
    init(firstNames: [String], lastNames: [String]) {
        var randomNumber = RandomNumberGenerator(min: 0, max: firstNames.count - 1).getNumber()
        self.firstName = firstNames[randomNumber]
        randomNumber = RandomNumberGenerator(min: 0, max: lastNames.count - 1).getNumber()
        self.lastName = lastNames[randomNumber]
        self.salary = RandomNumberGenerator(min: 20000, max: 100000).getNumber()
    }
}

let firstNames = ["Alex", "John", "James", "Carl", "Mike"]
let lastNames = ["Black", "Kennedy", "Walker", "Chan", "Andrews"]

let firstEmployee = Employee(firstNames: firstNames, lastNames: lastNames)
let secondEmployee = Employee(firstNames: firstNames, lastNames: lastNames)
let thirdEmployee = Employee(firstNames: firstNames, lastNames: lastNames)

// Урок 23
// Упражнение 1
// TODO пункт 4 и пункт 5
/*
 5) Если вы чувствуете в себе силы, то реализуйте следующий функционал:
 – при попытке передвижения фигуры должна производиться проверка возможности ее перемещения. Попытайтесь реализовать хотя бы для одного типа фигур (к примеру пешка). При этом должны учитываться: особенности первого хода, будет ли съедена в результате хода фигура противника и т.д.
 */

class Chessman {
    
    enum ChessmanType {
        case king, castle, bishop, pawn, knight, queen
    }
    
    enum ChessmanColor {
        case black, white
    }
    
    enum ChessmanFigure: Character {
        case whiteKing = "\u{2654}"
        case whiteQueen = "\u{2655}"
        case whiteBishop = "\u{2657}"
        case whiteKnight = "\u{2658}"
        case whiteCastle = "\u{2656}"
        case whitePawn = "\u{2659}"
        
        case blackKing = "\u{265A}"
        case blackQueen = "\u{265B}"
        case blackBishop = "\u{265D}"
        case blackKnight = "\u{265E}"
        case blackCastle = "\u{265C}"
        case blackPawn = "\u{265F}"
    }
    
    let type: ChessmanType
    let color: ChessmanColor
    var coordinates: (String, Int)? = nil
    let figureSymbol: ChessmanFigure
    
    init(type: ChessmanType, color: ChessmanColor, figure: ChessmanFigure) {
        self.type = type
        self.color = color
        figureSymbol = figure
    }
    
    init(type: ChessmanType, color: ChessmanColor, figure: ChessmanFigure, coordinates: (String, Int)) {
        self.type = type
        self.color = color
        figureSymbol = figure
        setCoordinates(char: coordinates.0, num:coordinates.1)
    }
    
    func setCoordinates(char c:String, num n: Int) {
        coordinates = (c, n)
    }
    
    func kill() {
        coordinates = nil
    }
}

class GameDesk {
    
    var blackKilled: [Chessman] = []
    var whiteKilled: [Chessman] = []
    
    var desk: [Int:[String:Chessman]] = [:]
    
    init(){
        for i in 1...8 {
            desk[i] = [:]
        }
    }
    
    subscript(alpha: String, number: Int) -> Chessman? {
        
        get {
            return self.desk[number]![alpha]
        }
        
        set {
            if let chessman = newValue {
                self.setChessman(chess: chessman, coordinates: (alpha, number))
            } else {
                if self.desk[number]![alpha]!.color == Chessman.ChessmanColor.black {
                    self.blackKilled.append(self.desk[number]![alpha]!)
                } else {
                    self.whiteKilled.append(self.desk[number]![alpha]!)
                }
                self.desk[number]![alpha]!.kill()
                self.desk[number]![alpha] = nil
            }
        }
        
    }
    
    func setChessman(chess: Chessman , coordinates: (String, Int)) {
        let rowRange = 1...8
        let colRange = "A"..."H"
        if rowRange.contains(coordinates.1) && colRange.contains(coordinates.0) {
            self.desk[coordinates.1]![coordinates.0] = chess
            chess.setCoordinates(char: coordinates.0, num: coordinates.1)
        } else {
            print("Coordinates out of range")
        }
    }
    
    func setNewGame() {
        
        self.desk[1]!["A"] = Chessman(type: .castle, color: .black, figure: .blackCastle, coordinates: ("A", 1))
        self.desk[1]!["B"] = Chessman(type: .knight, color: .black, figure: .blackKnight, coordinates: ("B", 1))
        self.desk[1]!["C"] = Chessman(type: .bishop, color: .black, figure: .blackBishop, coordinates: ("C", 1))
        self.desk[1]!["D"] = Chessman(type: .queen, color: .black, figure: .blackQueen, coordinates: ("D", 1))
        self.desk[1]!["E"] = Chessman(type: .king, color: .black, figure: .blackKing, coordinates: ("E", 1))
        self.desk[1]!["F"] = Chessman(type: .bishop, color: .black, figure: .blackBishop, coordinates: ("F", 1))
        self.desk[1]!["G"] = Chessman(type: .knight, color: .black, figure: .blackKnight, coordinates: ("G", 1))
        self.desk[1]!["H"] = Chessman(type: .castle, color: .black, figure: .blackCastle, coordinates: ("H", 1))
        
        self.desk[8]!["A"] = Chessman(type: .castle, color: .white, figure: .whiteCastle, coordinates: ("A", 8))
        self.desk[8]!["B"] = Chessman(type: .knight, color: .white, figure: .whiteKnight, coordinates: ("B", 8))
        self.desk[8]!["C"] = Chessman(type: .bishop, color: .white, figure: .whiteBishop, coordinates: ("C", 8))
        self.desk[8]!["D"] = Chessman(type: .queen, color: .white, figure: .whiteQueen, coordinates: ("D", 8))
        self.desk[8]!["E"] = Chessman(type: .king, color: .white, figure: .whiteKing, coordinates: ("E", 8))
        self.desk[8]!["F"] = Chessman(type: .bishop, color: .white, figure: .whiteBishop, coordinates: ("F", 8))
        self.desk[8]!["G"] = Chessman(type: .knight, color: .white, figure: .whiteKnight, coordinates: ("G", 8))
        self.desk[8]!["H"] = Chessman(type: .castle, color: .white, figure: .whiteCastle, coordinates: ("H", 8))
        
        for char in "ABCDEFGH" {
            self.desk[2]![String(char)] = Chessman(type: .pawn, color: .black, figure: .blackPawn, coordinates: (String(char), 2))
            self.desk[7]![String(char)] = Chessman(type: .pawn, color: .white, figure: .whitePawn, coordinates: (String(char), 7))
        }
    }
    
    func printDesk() {
        
        let rowRange = 1...8
        let colRange = "ABCDEFGH"
        
        for symbol in blackKilled {
            print("\(symbol.figureSymbol.rawValue)", terminator: " ")
        }
        
        print()
        
        for i in rowRange {
            
            print("\(i)", terminator: " ")
            
            for char in colRange {
               
                if let chessFigure = self.desk[i]![String(char)] {
                    print(chessFigure.figureSymbol.rawValue, terminator: " ")
                } else {
                    print("_", terminator: " ")
                }
                
            }
            
            print()
        }
        
        print(" ", terminator: " ")
        
        for char in colRange {
            print("\(char)", terminator: " ")
        }
        
        print()
        
        for symbol in whiteKilled {
            print("\(symbol.figureSymbol.rawValue)", terminator: " ")
        }
        
        print()
        
    }
    
    // TODO
    func move(from initialCoords: (String, Int), to finalCoords: (String, Int)) -> Int {
        
        /*
         1. определить что за фигура на координатах "from"
         2. определить возможно ли движение на координаты "to" switch case
         3. определить, наступает ли на "вражескую фигуру"
         4. выполнить действие
         5. удалить "вражескую фигуру" если необходимо
         */
        
        guard let figure = self.desk[initialCoords.1]![initialCoords.0]?.type else {
            print("Coordinates out of range")
            return 0
        }
        
        switch figure {

        case .pawn:
            self.desk[initialCoords.1]![initialCoords.0]!.setCoordinates(char: finalCoords.0, num: finalCoords.1)
            self.desk[finalCoords.1]![finalCoords.0] = self.desk[initialCoords.1]![initialCoords.0]!
            self.desk[initialCoords.1]![initialCoords.0] = nil
            break
        default:
            break
        }
        
        
        
        return 0
        
        
    }
}


var game = GameDesk()
//var queenBlack = Chessman(type: .queen, color: .black, figure: .blackQueen, coordinates: ("A", 6))
//
game.setNewGame()
game.printDesk()
game.move(from: ("D", 7), to: ("D", 6))


//game["C",2] = nil
//game["G",8] = nil
//game["D",7] = nil
//game["A",1] = nil
//


game.printDesk()


