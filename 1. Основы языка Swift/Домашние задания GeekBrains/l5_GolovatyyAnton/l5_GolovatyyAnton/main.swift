//
//  main.swift
//  l5_GolovatyyAnton
//
//  Created by Антон Головатый on 04.12.2021.
//

var someSportsCar = SportCar(model: "Lada", year: 1999, trunkVolume: 100, maximumSpeed: 175, gearType: .MT)

someSportsCar.printDescription()
someSportsCar.turnEngine(.on)
someSportsCar.makeWindows(.opened)
someSportsCar.changeTrunkStatus(.load(with: 20))

someSportsCar.fastStart(to: 400)

someSportsCar.stop()

someSportsCar.turnEngine(.off)

someSportsCar.changeTrunkStatus(.unload(with: 100))

someSportsCar.printDescription()

// Вторая переменная
print("==============================================\n")
var someTruck = Truck(model: "Kamaz", year: 2000, trunkVolume: 3000, maximumSpeed: 120)

someTruck.turnEngine(.on)
someTruck.makeWindows(.closed)
print()

someTruck.changeTrunkStatus(.load(with: 5000))
someTruck.changeTrunkStatus(.load(with: 30000))
someTruck.changeTrunkStatus(.unload(with: 2000))
someTruck.changeTrunkStatus(.unload(with: 10000))

someTruck.printDescription()
