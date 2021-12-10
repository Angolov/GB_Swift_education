// Домашнее задание 3
// Упражнение 1-4

struct SportCar {
    
    enum Engine {
        case on, off
    }
    
    enum Window {
        case opened, closed
    }
    
    enum Trunk {
        case load (with: Int)
        case unload (with: Int)
    }
    
    enum Transmission {
        case AT, MT
    }
    
    enum Gear {
        case P, R, N, D, first, second, third, forth, fifth, sixth
    }
    
    static let maximumPossibleSpeed = 400
    static var counter = 0
       
    let model: String
    let year: Int
    let trunkVolume: Int
    let maximumSpeed: Int
    
    var gearType: Transmission = .MT
    var currentGear: Gear
    var currentSpeed = 0 {
        didSet {
            if currentSpeed > maximumSpeed {
                self.currentSpeed = maximumSpeed
                print("You cannot go faster than \(maximumSpeed) km/h as it is cars maximum speed")
            }
        }
    }
    var engine: Engine = .off
    var window: Window = .closed
    var volumeUsed: Int = 0
    
    init(model: String, year: Int, trunkVolume: Int, maximumSpeed: Int, gearType: Transmission) {
        
        self.model = model
        self.year = year
        self.trunkVolume = trunkVolume
        
        if maximumSpeed > SportCar.maximumPossibleSpeed {
            print("Uncorrect maximum speed")
            self.maximumSpeed = SportCar.maximumPossibleSpeed
        } else {
            self.maximumSpeed = maximumSpeed
        }
        
        self.gearType = gearType
        
        switch self.gearType {
            
        case .MT:
            self.currentGear = .N
        case .AT:
            self.currentGear = .P
            
        }
        
        SportCar.counter += 1
        
        print("#\(SportCar.counter) sport car is \(self.model) built in \(self.year)")
        print("By the way, maximum speed is \(self.maximumSpeed) and gear type is \(self.gearType)")
        
        print("Engine is \(self.engine) and windows are \(self.window)")
        print("Current gear is \(self.currentGear) and current speed is \(self.currentSpeed)")
        print("Trunk capacity is \(self.trunkVolume), used \(self.volumeUsed)")
        
    }
    
    mutating func turnEngine(_ status: Engine) {
        
        self.engine = status
        print("Engine turned \(status)")
        
        if engine == .off {
            currentSpeed = 0
        }
    
    }
    
    mutating func makeWindows(_ status: Window) {
        
        self.window = status
        print("Windows are \(status)")
        
    }
    
    mutating func speedUp(to speed: Int) {
        
        if self.engine == .off {
            turnEngine(.on)
        }
        
        if currentSpeed != maximumSpeed && currentSpeed != speed {
            currentSpeed = speed
            print("Car speed changed to \(currentSpeed)")
        }
        
    }
    
    mutating func switchGear(to gear: Gear) {
        
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
    
    mutating func changeTrunkStatus(_ trunk: Trunk) {
        
        switch trunk {
        
        case .load (let volume):
            if volume > (trunkVolume - volumeUsed) {
                print("\(self.model) trunk capacity is only \(self.trunkVolume)")
                print("Car is loaded with \(trunkVolume - volumeUsed)")
                self.volumeUsed += trunkVolume
            } else {
                print("Car is loaded with \(volume)")
                self.volumeUsed += volume
            }
        
        case .unload (let volume):
            
            if volume > volumeUsed {
                print("\(self.model) trunk was loaded only for \(self.volumeUsed)")
                print("Car is unloaded with \(volumeUsed)")
                self.volumeUsed = 0
            } else {
                print("Car is unloaded with \(volume)")
                self.volumeUsed -= volume
            }
        }
    }
    
    func printDescription() {
        
        print("Current car is \(self.model)")
        print("Engine is \(self.engine) and windows are \(self.window)")
        print("Current gear is \(self.currentGear) and current speed is \(self.currentSpeed)")
        print("Trunk capacity is \(self.trunkVolume), used \(self.volumeUsed)")
        
    }
}

struct Truck {
    
    enum Engine {
        case on, off
    }
    
    enum Window {
        case opened, closed
    }
    
    enum Trunk {
        case load (with: Int)
        case unload (with: Int)
    }
    
    enum Gear {
        case R, N, first, second, third, forth
    }
       
    static let maximumPossibleSpeed = 120
    static var counter = 0
       
    let model: String
    let year: Int
    let trunkVolume: Int
    let maximumSpeed: Int
    
    var currentGear: Gear
    var currentSpeed = 0 {
        didSet {
            if currentSpeed > maximumSpeed {
                self.currentSpeed = maximumSpeed
                print("You cannot go faster than \(maximumSpeed) km/h as it is cars maximum speed")
            }
        }
    }
    var engine: Engine = .off
    var window: Window = .closed
    var volumeUsed: Int = 0
    
    init(model: String, year: Int, trunkVolume: Int, maximumSpeed: Int) {
        
        self.model = model
        self.year = year
        self.trunkVolume = trunkVolume
        self.currentGear = .N
        
        if maximumSpeed > Truck.maximumPossibleSpeed {
            print("Uncorrect maximum speed")
            self.maximumSpeed = Truck.maximumPossibleSpeed
        } else {
            self.maximumSpeed = maximumSpeed
        }
        
        Truck.counter += 1
        
        print("#\(Truck.counter) truck car is \(self.model) built in \(self.year)")
        print("By the way, maximum speed is \(self.maximumSpeed)")
        
        print("Engine is \(self.engine) and windows are \(self.window)")
        print("Current gear is \(self.currentGear) and current speed is \(self.currentSpeed)")
        print("Trunk capacity is \(self.trunkVolume), used \(self.volumeUsed)")
        
    }
    
    mutating func turnEngine(_ status: Engine) {
        
        self.engine = status
        print("Engine turned \(status)")
        
        if engine == .off {
            currentSpeed = 0
        }
    
    }
    
    mutating func makeWindows(_ status: Window) {
        
        self.window = status
        print("Windows are \(status)")
        
    }
    
    mutating func speedUp(to speed: Int) {
        
        if self.engine == .off {
            turnEngine(.on)
        }
        
        if currentSpeed != maximumSpeed && currentSpeed != speed {
            currentSpeed = speed
            print("Car speed changed to \(currentSpeed)")
        }
        
    }
    
    mutating func switchGear(to gear: Gear) {
        
        currentGear = gear
        print("Gear switched to \(gear)")
        
    }
    
    mutating func changeTrunkStatus(_ trunk: Trunk) {
        
        switch trunk {
        
        case .load (let volume):
            if volume > (trunkVolume - volumeUsed) {
                print("\(self.model) trunk capacity is only \(self.trunkVolume)")
                print("Car is loaded with \(trunkVolume - volumeUsed)")
                self.volumeUsed += trunkVolume
            } else {
                print("Car is loaded with \(volume)")
                self.volumeUsed += volume
            }
        
        case .unload (let volume):
            
            if volume > volumeUsed {
                print("\(self.model) trunk was loaded only for \(self.volumeUsed)")
                print("Car is unloaded with \(volumeUsed)")
                self.volumeUsed = 0
            } else {
                print("Car is unloaded with \(volume)")
                self.volumeUsed -= volume
            }
            
        }
    }
    
    func printDescription() {
        
        print("Current car is \(self.model)")
        print("Engine is \(self.engine) and windows are \(self.window)")
        print("Current gear is \(self.currentGear) and current speed is \(self.currentSpeed)")
        print("Trunk capacity is \(self.trunkVolume), used \(self.volumeUsed)")
        
    }
}

// Упражнение 5-6
// Первая переменная
var someSportsCar = SportCar(model: "Lada", year: 1999, trunkVolume: 100, maximumSpeed: 120, gearType: .MT)

print()

someSportsCar.turnEngine(.on)
someSportsCar.makeWindows(.opened)
someSportsCar.changeTrunkStatus(.load(with: 20))

someSportsCar.switchGear(to: .first)
someSportsCar.speedUp(to: 40)

someSportsCar.switchGear(to: .second)
someSportsCar.speedUp(to: 70)

someSportsCar.switchGear(to: .fifth)
someSportsCar.speedUp(to: 120)

someSportsCar.switchGear(to: .sixth)
someSportsCar.speedUp(to: 140)

someSportsCar.turnEngine(.off)
someSportsCar.switchGear(to: .first)
someSportsCar.changeTrunkStatus(.unload(with: 100))

print()
someSportsCar.printDescription()
print()

// Вторая переменная
var someTruck = Truck(model: "Kamaz", year: 2000, trunkVolume: 3000, maximumSpeed: 120)


someTruck.turnEngine(.on)
someTruck.makeWindows(.closed)


someTruck.changeTrunkStatus(.load(with: 30000))
someTruck.changeTrunkStatus(.unload(with: 2000))

print()
someTruck.printDescription()
print()
