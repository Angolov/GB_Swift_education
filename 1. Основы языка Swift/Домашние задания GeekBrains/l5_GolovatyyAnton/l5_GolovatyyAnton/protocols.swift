//
//  protocols.swift
//  l5_GolovatyyAnton
//
//  Created by Антон Головатый on 04.12.2021.
//

//MARK: - WindowProtocol
protocol WindowsProtocol {
    
    var window: Window { get set }
    mutating func makeWindows(_ status: Window)
    
}

extension WindowsProtocol {
    
    mutating func makeWindows(_ status: Window) {
        
        window = status
        print("Windows are \(status)")
        
    }
    
}

//MARK: - EngineProtocol
protocol EngineProtocol {
    
    var engine: Engine { get set }
    mutating func turnEngine(_ status: Engine)
    
}

extension EngineProtocol {
    
    mutating func turnEngine(_ status: Engine) {
        
        engine = status
        print("Engine turned \(status)")
    
    }
    
}

//MARK: - GearProtocol
protocol GearProtocol {
    
    var gearType: Transmission { get }
    var currentGear: Gear { get set }
    
    func switchGear(to gear: Gear)
    
}

extension GearProtocol {
    
    mutating func switchGear(to gear: Gear) {
        
        switch gear {
            
        case .P, .D:
            if gearType == .AT {
                currentGear = gear
                print("Gear switched to \(gear)")
            } else {
                print("You have MT transmission")
            }
            
        case .first, .second, .third, .forth, .fifth, .sixth:
            if gearType == .MT {
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

//MARK: - SpeedProtocol
protocol SpeedProtocol {
    
    var maximumSpeed: Int { get }
    var currentSpeed: Int { get set }
    
    mutating func speedUp(to speed: Int)
    mutating func stop()
    
}

extension SpeedProtocol {
    
    mutating func speedUp(to speed: Int) {
        
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
    
    mutating func stop() {
        
        print("Emergency stop activated!")
        
        speedUp(to: 0)
        
        print()
        
    }
    
}

//MARK: - TrunkProtocol
protocol TrunkProtocol {
    
    var trunkVolume: Int { get set }
    var volumeUsed: Int { get set }
    
    mutating func changeTrunkStatus(_ trunk: Trunk)
    
}

extension TrunkProtocol {
    
    mutating func changeTrunkStatus(_ trunk: Trunk) {
        
        switch trunk {
        
        case .load (let volume):
            
            print("Loading cargo amount \(volume)")
            
            if volume > (trunkVolume - volumeUsed) {
                
                print("Trunk capacity is only \(trunkVolume)")
                print("Car is loaded with \(trunkVolume - volumeUsed)")
                self.volumeUsed += trunkVolume
                
            } else {
                
                print("Car is loaded with \(volume)")
                self.volumeUsed += volume
                
            }
        
        case .unload (let volume):
            
            print("Unloading cargo amount \(volume)")
            
            if volume > volumeUsed {
                
                print("Trunk was loaded only for \(volumeUsed)")
                print("Car is unloaded with \(volumeUsed)")
                self.volumeUsed = 0
                
            } else {
                
                print("Car is unloaded with \(volume)")
                self.volumeUsed -= volume
                
            }
        }
        
        print()
    }
    
}

//MARK: - CarProtocol
protocol CarProtocol {
    
    var model: String { get }
    var year: Int { get }
    
    func printDescription()
    
}
