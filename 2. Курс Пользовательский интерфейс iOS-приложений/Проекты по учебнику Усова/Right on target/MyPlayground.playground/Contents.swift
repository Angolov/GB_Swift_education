import UIKit

var greeting = "Hello, playground"

struct Color {
    
    var red: UInt8
    var green: UInt8
    var blue: UInt8
    
    init() {
        
        red = 12
        green = 255
        blue = 50
    }
}

let someColor = Color()

print("\(String(someColor.green, radix: 16, uppercase: true))")
