//
//  classes.swift
//  l4_GolovatyyAnton
//
//  Created by Антон Головатый on 01.12.2021.
//

//MARK: Car class declaration
class Car {
    
    // MARK: Enums
    enum Engine {
        case on
        case off
    }
    
    enum Window {
        case opened
        case closed
    }
    
    enum Transmission {
        case AT
        case MT
    }
    
    enum Gear {
        case P
        case D
        case R
        case N
        case first
        case second
        case third
        case forth
        case fifth
        case sixth
    }
    
    enum Trunk {
        case load (with: Int)
        case unload (with: Int)
    }
    
    //MARK: Constants and variables
    fileprivate let model: String
    fileprivate let year: Int
    fileprivate let maximumSpeed: Int
    
    fileprivate var trunkVolume: Int
    fileprivate var currentSpeed = 0 {
        didSet {
            if currentSpeed > maximumSpeed {
                currentSpeed = maximumSpeed
                print("You cannot go faster than \(maximumSpeed) km/h as it is cars maximum speed")
            }
        }
    }
    fileprivate var gearType: Transmission = .MT
    fileprivate var currentGear: Gear
    fileprivate var engine: Engine = .off
    fileprivate var window: Window = .closed
    fileprivate var volumeUsed: Int = 0
    
    
    //MARK: Initializer
    init(model: String, year: Int, trunkVolume: Int = 300, maximumSpeed: Int = 220, maximumPossibleSpeed: Int = 220) {
        
        self.model = model
        self.year = year
        self.trunkVolume = trunkVolume
        currentGear = .N
        
        if maximumSpeed > maximumPossibleSpeed {
            print("Uncorrect maximum speed")
            self.maximumSpeed = maximumPossibleSpeed
        } else {
            self.maximumSpeed = maximumSpeed
        }
        
        print("By the way, maximum speed is \(self.maximumSpeed)")
        print("Engine is \(self.engine) and windows are \(self.window)")
        print("Current gear is \(self.currentGear) and current speed is \(self.currentSpeed)")
        print("Trunk capacity is \(self.trunkVolume), used \(self.volumeUsed)\n")
        
    }
    
    //MARK: Functions
    func turnEngine(_ status: Engine) {
        
        engine = status
        print("Engine turned \(status)")
        
        if engine == .off {
            currentSpeed = 0
        }
    
    }
    
    func makeWindows(_ status: Window) {
        
        window = status
        print("Windows are \(status)")
        
    }
    
    func speedUp(to speed: Int) {
        
        if engine == .off {
            turnEngine(.on)
        }
        
        if currentSpeed != maximumSpeed && currentSpeed != speed {
            currentSpeed = speed
            print("Car speed changed to \(currentSpeed)")
        } else if currentSpeed > speed {
            currentSpeed = speed
            print("Car speed changed to \(currentSpeed)")
        } else {
            print("You cannot go faster than \(maximumSpeed) km/h as it is cars maximum speed")
        }
        
    }
    
    func switchGear(to gear: Gear) {
        
        if (gear != .N || gear != .P) && engine == .off {
            turnEngine(.on)
        }
        
        switch gear {
            
        case .P, .D:
            if self.gearType == .AT {
                currentGear = gear
                print("Gear switched to \(gear)")
            } else {
                print("You have MT transmission")
            }
            
        case .first, .second, .third, .forth, .fifth, .sixth:
            if self.gearType == .MT {
                currentGear = gear
                print("Gear switched to \(gear)")
            } else {
                print("You have AT transmision")
            }
            
        default:
            currentGear = gear
            print("Gear switched to \(gear)")
            
        }
    }
    
    func stop() {
        
        print("Emergency stop activated!")
        
        speedUp(to: 0)
        switchGear(to: .N)
        
        print()
        
    }
    
    func changeTrunkStatus(_ trunk: Trunk) {
        
        switch trunk {
        
        case .load (let volume):
            
            print("Loading cargo amount \(volume)")
            
            if volume > (trunkVolume - volumeUsed) {
                
                print("\(model) trunk capacity is only \(trunkVolume)")
                print("Car is loaded with \(trunkVolume - volumeUsed)")
                self.volumeUsed += trunkVolume
                
            } else {
                
                print("Car is loaded with \(volume)")
                self.volumeUsed += volume
                
            }
        
        case .unload (let volume):
            
            print("Unloading cargo amount \(volume)")
            
            if volume > volumeUsed {
                
                print("\(model) trunk was loaded only for \(volumeUsed)")
                print("Car is unloaded with \(volumeUsed)")
                self.volumeUsed = 0
                
            } else {
                
                print("Car is unloaded with \(volume)")
                self.volumeUsed -= volume
                
            }
        }
        
        print()
    }
    
    func printDescription() {
        
        print("Current car is \(self.model)")
        print("Engine is \(self.engine) and windows are \(self.window)")
        print("Current gear is \(self.currentGear) and current speed is \(self.currentSpeed)")
        print("Trunk capacity is \(self.trunkVolume), used \(self.volumeUsed)\n")
        
    }
    
}

//MARK: SportCar class declaration
final class SportCar: Car {
    
    //MARK: Type property
    static var counter = 0
    
    //MARK: Initializer
    init(model: String, year: Int, trunkVolume: Int = 50, maximumSpeed: Int, gearType: Transmission = .MT) {
        
        SportCar.counter += 1
        
        print("#\(SportCar.counter) sport car is \(model) built in \(year)")
        
        super.init(model: model,
                   year: year,
                   trunkVolume: trunkVolume,
                   maximumSpeed: maximumSpeed,
                   maximumPossibleSpeed: 400)
        
        self.gearType = gearType
        
        switch self.gearType {
            
        case .MT:
            self.currentGear = .N
        case .AT:
            self.currentGear = .P
            
        }
        
    }
    
    //MARK: Functions
    override func switchGear(to gear: Gear) {
        
        if (gear != .N || gear != .P) && engine == .off {
            turnEngine(.on)
        }
        
        switch gear {
            
        case .P, .D:
            if self.gearType == .AT {
                currentGear = gear
                print("Gear switched to \(gear)")
            } else {
                print("You have MT transmission")
            }
            
        case .first, .second, .third, .forth, .fifth, .sixth:
            if self.gearType == .MT {
                currentGear = gear
                print("Gear switched to \(gear)")
            } else {
                print("You have AT transmision")
            }
            
        default:
            currentGear = gear
            print("Gear switched to \(gear)")
            
        }
    }
    
    func fastStart(to speed: Int) {
        
        let topSpeed = speed < maximumSpeed ? speed : maximumSpeed
        let gearStep = maximumSpeed / 6
        let finalGear = topSpeed / gearStep
        let gearArray = [Gear.first, Gear.second, Gear.third, Gear.forth, Gear.fifth, Gear.sixth]
        
        print("Let's get fast & furious!")
        
        if gearType == .AT {
            
            speedUp(to: speed)
            
        } else {
            
            for i in 1...finalGear {
                
                switchGear(to: gearArray[i - 1])
                speedUp(to: gearStep * i)
                
            }
            
            speedUp(to: speed)
            
        }
        
        print()
        
    }
    
    
    
    override func printDescription() {
        
        print("Current sport car is \(model)")
        print("Engine is \(engine) and windows are \(window)")
        print("Current gear is \(currentGear) and current speed is \(currentSpeed)")
        print("Trunk capacity is \(trunkVolume), used \(volumeUsed)\n")
        
    }
}

//MARK: Truck class declaration
final class Truck: Car {
    
    enum CargoTrailerOperation {
        case hook
        case unhook
    }
    
    //MARK: Type property
    static var counter = 0
    static let cargoTrailerMaximum = 1
    
    //MARK: Constants and variables
    private let cargoTrailerVolume = 10000
    
    private var cargoTrailerCount = 0
    
    //MARK: Initializer
    init(model: String, year: Int, trunkVolume: Int, maximumSpeed: Int) {
        
        Truck.counter += 1
        
        print("#\(Truck.counter) truck car is \(model) built in \(year)")
        
        super.init(model: model,
                   year: year,
                   trunkVolume: trunkVolume,
                   maximumSpeed: maximumSpeed,
                   maximumPossibleSpeed: 120)
        
        self.currentGear = .N
        
    }
    
    //MARK: Functions
    override func switchGear(to gear: Gear) {
        
        if (gear != .N || gear != .P) && engine == .off {
            turnEngine(.on)
        }
        
        switch gear {
            
        case .P, .D, .fifth, .sixth:
            print("It is a truck with MT transmission")
            print(("Gear remained unchanged"))
            
        case .N, .R, .first, .second, .third, .forth:
            currentGear = gear
            print("Gear switched to \(gear)")
            
        }
    }
    
    func cargoTrailer(_ operation: CargoTrailerOperation){
        
        switch operation {
            
        case .hook:
            
            if cargoTrailerCount < Truck.cargoTrailerMaximum {
                cargoTrailerCount += 1
                trunkVolume += cargoTrailerVolume
            } else {
                print("You can only use one trailer at a time")
            }
            
        case .unhook:
            
            if cargoTrailerCount == 1 {
                cargoTrailerCount -= 1
                trunkVolume -= cargoTrailerVolume
            } else {
                print("You don't have any trailer hooked")
            }
        }
    }
    
    override func changeTrunkStatus(_ trunk: Trunk) {
        
        switch trunk {
        
        case .load (let volume):
            
            let freeSpace = trunkVolume - volumeUsed
            let potentialFreeSpace = freeSpace + cargoTrailerVolume
            
            print("Loading cargo amount \(volume)")
            
            if volume <= freeSpace {
                
                print("Truck is loaded with \(volume)")
                volumeUsed += volume
                
            } else if volume <= potentialFreeSpace && cargoTrailerCount == 0 {
                
                print("Cargo trailer needs to be added here")
                cargoTrailer(.hook)
                print("\(model) maximum trunk capacity changed to \(trunkVolume)")
                print("Truck is loaded with \(volume)")
                self.volumeUsed += volume
                
            } else if cargoTrailerCount == 0 {
                
                print("Cargo trailer needs to be added here")
                cargoTrailer(.hook)
                print("\(model) maximum trunk capacity changed to \(trunkVolume) but it will be still not enough")
                print("Truck is loaded with \(trunkVolume - volumeUsed)")
                volumeUsed = trunkVolume
                
            } else {
                
                print("\(model) maximum trunk capacity is only \(trunkVolume)")
                print("Truck is loaded with \(trunkVolume - volumeUsed)")
                volumeUsed = trunkVolume
                
            }
        
        case .unload (let volume):
            
            print("Unloading cargo amount \(volume)")
            
            if volume > volumeUsed && cargoTrailerCount == 1 {
                
                print("\(model) trunk was loaded only for \(volumeUsed)")
                print("Car is unloaded with \(volumeUsed)")
                volumeUsed = 0
                
                print("Cargo trailer is not needed anymore")
                cargoTrailer(.unhook)
                print("\(model) maximum trunk capacity changed to \(trunkVolume)")
                
            } else if volume > volumeUsed - cargoTrailerVolume && cargoTrailerCount == 1 {
                
                print("Car is unloaded with \(volume)")
                volumeUsed -= volume
                
                print("Cargo trailer is not needed anymore")
                cargoTrailer(.unhook)
                print("\(model) maximum trunk capacity changed to \(trunkVolume)")
                
            } else if volume > volumeUsed && cargoTrailerCount == 0 {
                
                print("\(model) trunk was loaded only for \(volumeUsed)")
                print("Car is unloaded with \(volumeUsed)")
                volumeUsed = 0
                
            } else {
                
                print("Car is unloaded with \(volume)")
                volumeUsed -= volume
                
            }
        }
        
        print()
    }
    
    override func printDescription() {
        
        print("Current truck is \(model)")
        print("Engine is \(engine) and windows are \(window)")
        print("Current gear is \(currentGear) and current speed is \(currentSpeed)")
        print("Trunk capacity is \(trunkVolume), used \(volumeUsed)\n")
        
    }
}
