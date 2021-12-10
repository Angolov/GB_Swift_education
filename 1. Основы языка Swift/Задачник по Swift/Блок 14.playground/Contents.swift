// Блок 14
// Задание 1-2

//MARK: - Coordinates struct declaration
struct Coordinate {
    
    //MARK: - Enums
    enum Surface: Int {
        
        case mountains = 1
        case river
        case castle
        case desert
        
    }
    
    enum Color: Int {
        
        case red = 1
        case blue
        case white
        case green
        
    }
    
    enum Occupation: Int {
        
        case orc = 1
        case elf
        case animal
        case none
        case player
        
    }
    
    //MARK: - Private properties
    fileprivate let surface: Surface
    fileprivate let color: Color
    fileprivate let xCoordinate: Int
    fileprivate let yCoordinate: Int
    
    fileprivate var occupation: Occupation
    
    //MARK: - Initializer
    init(xCoordinate: Int, yCoordinate: Int) {
        
        self.xCoordinate = xCoordinate
        self.yCoordinate = yCoordinate
        self.surface = Surface(rawValue: Int.random(in: 1...4))!
        self.color = Color(rawValue: Int.random(in: 1...4))!
        self.occupation = Occupation(rawValue: Int.random(in: 1...4))!
        
    }
    
    //MARK: - Public methods
    func description() -> String {
        
        return "(x:\(xCoordinate), y:\(yCoordinate)) \(color) \(surface) occupied by \(occupation)"
        
    }
    
    func shortDescription() -> String {
        
        return "\(color) \(surface) (x: \(xCoordinate), y: \(yCoordinate))"
        
    }
    
}

// MARK: - GameMap class declaration
class GameMap {
    
    //MARK: - Private properties
    fileprivate var gameMap: [Coordinate]
    
    //MARK: - Type properties
    fileprivate static let xDimension = 4
    fileprivate static let yDimension = 4
    
    //MARK: - Initializer
    init() {
        
        gameMap = []
        for y in 1...GameMap.yDimension {
            
            for x in 1...GameMap.xDimension {
                
                gameMap.append(Coordinate(xCoordinate: x, yCoordinate: y))
                
            }
        }
    }
    
    //MARK: - Public methods
    func printCurrentMapState() {
        
        for (index, value) in gameMap.enumerated() {
            print(index, value.description())
        }
        
    }
    
}

let gameMap = GameMap()
gameMap.printCurrentMapState()

//Задание 3-4 и продвинутый уровень 1-5
//MARK: - Hero class declaration
class Hero {
    
    //MARK: - Direction enum
    enum Direction {
        case up
        case down
        case left
        case right
    }
    
    //MARK: - Private properties
    fileprivate var currentGameMap: GameMap
    fileprivate var currentCoordinates: (x: Int, y: Int)
    
    //MARK: - Initializer
    init(currentGameMap: GameMap, currentCoordinates: (Int, Int)) {
        
        self.currentGameMap = currentGameMap
        self.currentCoordinates = currentCoordinates
        print("Start coordinates: (x: \(self.currentCoordinates.x), y: \(self.currentCoordinates.y))")
        
        let mapIndex = (self.currentCoordinates.y - 1) * GameMap.yDimension + (self.currentCoordinates.x - 1)
        self.currentGameMap.gameMap[mapIndex].occupation = .player
        
    }
    
    //MARK: - Public methods
    func moveInDirection(_ direction: Direction) {
        
        let oldCoordinates = currentCoordinates
        
        switch direction {
            
        case .up:
            currentCoordinates.y -= 1
            
        case .down:
            currentCoordinates.y += 1
            
        case .left:
            currentCoordinates.x -= 1
            
        case .right:
            currentCoordinates.x += 1
            
        }
        
        let mapIndex = (currentCoordinates.y - 1) * GameMap.yDimension + (currentCoordinates.x - 1)
        let oldMapIndex = (oldCoordinates.y - 1) * GameMap.yDimension + (oldCoordinates.x - 1)
        
        print("Moving \(direction)...")
        
        if currentCoordinates.x < 1 ||
            currentCoordinates.y < 1 ||
            currentCoordinates.x > GameMap.xDimension ||
            currentCoordinates.y > GameMap.yDimension {
            
            currentCoordinates = oldCoordinates
            print("Out of bounds move")
            
        } else if currentGameMap.gameMap[mapIndex].occupation != .none {
            
            currentCoordinates = oldCoordinates
            print("That location is occupied, return back!")
            
        } else {
            
            print("You entered \(currentGameMap.gameMap[mapIndex].shortDescription())")
            currentGameMap.gameMap[mapIndex].occupation = .player
            currentGameMap.gameMap[oldMapIndex].occupation = .none
            
        }
        
    }
    
    func shootAndKill(_ direction: Direction) {
        
        var attackCoordinates = currentCoordinates
        
        switch direction {
            
        case .up:
            attackCoordinates.y -= 1
            
        case .down:
            attackCoordinates.y += 1
            
        case .left:
            attackCoordinates.x -= 1
            
        case .right:
            attackCoordinates.x += 1
            
        }
        
        let mapIndex = (attackCoordinates.y - 1) * GameMap.yDimension + (attackCoordinates.x - 1)
        
        print("Attacking \(direction)...")
        
        if attackCoordinates.x < 1 ||
            attackCoordinates.y < 1 ||
            attackCoordinates.x > GameMap.xDimension ||
            attackCoordinates.y > GameMap.yDimension {
            
            print("Out of bounds attack")
            
        } else if currentGameMap.gameMap[mapIndex].occupation == .none {
            
            print("That location was empty... Attack failed")
            
        } else {
            
            print("Your attack was successful, \(currentGameMap.gameMap[mapIndex].occupation) is killed!")
            currentGameMap.gameMap[mapIndex].occupation = .none
            
        }
        
    }
}

print()
let hero = Hero(currentGameMap: gameMap, currentCoordinates: (2, 1))
gameMap.printCurrentMapState()
hero.moveInDirection(.down)
hero.shootAndKill(.down)
hero.moveInDirection(.down)
hero.shootAndKill(.down)
hero.moveInDirection(.down)
hero.shootAndKill(.down)
hero.moveInDirection(.down)
hero.shootAndKill(.down)
hero.moveInDirection(.down)
hero.shootAndKill(.down)
print()
gameMap.printCurrentMapState()
