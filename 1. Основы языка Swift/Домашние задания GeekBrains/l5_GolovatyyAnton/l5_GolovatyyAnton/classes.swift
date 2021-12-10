//
//  classes.swift
//  l5_GolovatyyAnton
//
//  Created by Антон Головатый on 04.12.2021.
//

//MARK: - Car class declaration
class Car {
    
    //MARK: - Private properties
    let model: String
    let year: Int
    let maximumSpeed: Int
    
    var trunkVolume: Int
    var currentSpeed = 0 {
        didSet {
            if currentSpeed > maximumSpeed {
                currentSpeed = maximumSpeed
                print("You cannot go faster than \(maximumSpeed) km/h as it is cars maximum speed")
            }
        }
    }
    var gearType: Transmission = .MT
    var currentGear: Gear
    var engine: Engine = .off
    var window: Window = .closed
    var volumeUsed: Int = 0
    
    
    //MARK: - Initializer
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
    
}

//MARK: - SportCar class declaration
final class SportCar: Car {
    
    //MARK: - Type properties
    static var counter = 0
    static let maximumPossibleSpeed = 400
    
    //MARK: - Initializer
    init(model: String, year: Int, trunkVolume: Int = 50, maximumSpeed: Int = 220, gearType: Transmission = .MT) {

        SportCar.counter += 1

        print("#\(SportCar.counter) sport car is \(model) built in \(year)")
        
        super.init(model: model,
                   year: year,
                   trunkVolume: trunkVolume,
                   maximumSpeed: maximumSpeed,
                   maximumPossibleSpeed: SportCar.maximumPossibleSpeed)
        
        self.gearType = gearType

        switch self.gearType {

        case .MT:
            self.currentGear = .N
        case .AT:
            self.currentGear = .P

        }

    }
    
    //MARK: - Methods
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
    
}

//MARK: - Extension implementing CarProtocol
extension SportCar: CarProtocol {
    
    func printDescription() {

        print(description)

    }
}

//MARK: - Extension implementing WindowsProtocol
extension SportCar: WindowsProtocol {}

//MARK: - Extension implementing TrunkProtocol
extension SportCar: TrunkProtocol {}

//MARK: - Extension implementing EngineProtocol
extension SportCar: EngineProtocol {
    
    func turnEngine(_ status: Engine) {
        
        if status == .off && currentSpeed > 0{
            speedUp(to: 0)
        }
        
        engine = status
        print("Engine turned \(status)")
        
    }
}

//MARK: - Extension implementing SpeedProtocol
extension SportCar: SpeedProtocol {
    
    func speedUp(to speed: Int) {
        
        if engine == .off {
            turnEngine(.on)
        }
        
        if speed <= maximumSpeed && currentSpeed != speed {
            currentSpeed = speed
            print("Car speed changed to \(currentSpeed)")
        } else if currentSpeed >= speed {
            currentSpeed = speed
            print("Car speed changed to \(currentSpeed)")
        } else {
            print("You cannot go faster than \(maximumSpeed) km/h as it is cars maximum speed")
        }
        
    }
}

//MARK: - Extension implementing GearProtocol
extension SportCar: GearProtocol {
    
    func switchGear(to gear: Gear) {
        
        switch gear {
            
        case .P, .D:
            if self.gearType == .AT {
                
                speedUp(to: 0)
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
    
}

extension SportCar: CustomStringConvertible {
    
    var description: String {
        return """
        Current sport car is \(model)
        Engine is \(engine) and windows are \(window)
        Current gear is \(currentGear) and current speed is \(currentSpeed)
        Trunk capacity is \(trunkVolume), used \(volumeUsed)\n
        """
    }
}

//MARK: - Truck class declaration
final class Truck: Car {
    
    enum CargoTrailerOperation {
        case hook
        case unhook
    }
    
    //MARK: - Type property
    static var counter = 0
    static let cargoTrailerMaximum = 1
    
    //MARK: - Private properties
    private let cargoTrailerVolume = 10000
    private var cargoTrailerCount = 0
    
    //MARK: - Initializer
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
    
    //MARK: - Methods
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
}

extension Truck: CarProtocol {
    
    func printDescription() {
        
        print(description)
    }
}

//MARK: - Extension implementing WindowsProtocol
extension Truck: WindowsProtocol {}

//MARK: - Extension implementing TrunkProtocol
extension Truck: TrunkProtocol {
    
    func changeTrunkStatus(_ trunk: Trunk) {
        
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
    
}

//MARK: - Extension implementing EngineProtocol
extension Truck: EngineProtocol {
    
    func turnEngine(_ status: Engine) {
        
        if status == .off && currentSpeed > 0{
            speedUp(to: 0)
        }
        
        engine = status
        print("Engine turned \(status)")
        
    }
}

//MARK: - Extension implementing SpeedProtocol
extension Truck: SpeedProtocol {
    
    func speedUp(to speed: Int) {
        
        if engine == .off {
            turnEngine(.on)
        }
        
        if speed <= maximumSpeed && currentSpeed != speed {
            currentSpeed = speed
            print("Car speed changed to \(currentSpeed)")
        } else if currentSpeed >= speed {
            currentSpeed = speed
            print("Car speed changed to \(currentSpeed)")
        } else {
            print("You cannot go faster than \(maximumSpeed) km/h as it is cars maximum speed")
        }
        
    }
}

//MARK: - Extension implementing GearProtocol
extension Truck: GearProtocol {
    
    func switchGear(to gear: Gear) {
        
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
    
}

extension Truck: CustomStringConvertible {
    
    var description: String {
        return """
        Current truck is \(model)
        Engine is \(engine) and windows are \(window)
        Current gear is \(currentGear) and current speed is \(currentSpeed)
        Trunk capacity is \(trunkVolume), used \(volumeUsed)\n
        """
    }
}
