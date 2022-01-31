//
//  Color.swift
//  Right on target
//
//  Created by Антон Головатый on 20.12.2021.
//

import UIKit

//MARK: - Color struct declaration
struct Color: Equatable {
    
    //MARK: - Public properties
    var red: UInt8
    var green: UInt8
    var blue: UInt8
    
    //MARK: - Initializers
    init() {
        
        red = 0
        green = 0
        blue = 0
    }
    
    init(color: UIColor) {
        
        red = UInt8(CGFloat(255) * color.cgColor.components![0])
        green = UInt8(CGFloat(255) * color.cgColor.components![1])
        blue = UInt8(CGFloat(255) * color.cgColor.components![2])
    }
    
    //MARK: - Public methods
    func getInHex() -> String {
        
        var redPart = String(red, radix: 16, uppercase: true)
        if red <= 16 {
            redPart = "0\(redPart)"
        }
        var greenPart = String(green, radix: 16, uppercase: true)
        if green <= 16 {
            greenPart = "0\(greenPart)"
        }
        var bluePart = String(blue, radix: 16, uppercase: true)
        if blue <= 16 {
            bluePart = "0\(bluePart)"
        }
        
        return "\(redPart)\(greenPart)\(bluePart)"
    }
    
    func getInUIColor() -> UIColor{
        
        let redFloat: Float = Float(red)/255
        let greenFloat: Float = Float(green)/255
        let blueFloat: Float = Float(blue)/255
        
        return UIColor(red: CGFloat(redFloat),
                       green: CGFloat(greenFloat),
                       blue: CGFloat(blueFloat),
                       alpha: 1)
    }
    
    static func == (left: Color, right: Color) -> Bool {
        
        return left.red == right.red && left.green == right.green && left.blue == right.blue
    }
}
