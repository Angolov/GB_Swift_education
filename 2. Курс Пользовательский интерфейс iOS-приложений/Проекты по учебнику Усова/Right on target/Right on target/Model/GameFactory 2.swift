//
//  GameFactory.swift
//  Right on target
//
//  Created by Антон Головатый on 20.12.2021.
//

//MARK: - GameFactory class declaration
final class GameFactory {
    
    static func getNumericGame() -> some GameProtocol {
        
        let numSecretValue = NumericSecretValue(value: 0) { _ in
            return Array(1...50).randomElement()!
        }
        
        return Game<NumericSecretValue>(secretValue: numSecretValue, rounds: 5) { secretValue, userValue in
            
            var compareResult: Int = 0
            if secretValue.value == userValue.value {
                compareResult = 50
            } else if secretValue.value > userValue.value {
                compareResult = 50 - (secretValue.value - userValue.value)
            } else if secretValue.value < userValue.value {
                compareResult = 50 - (userValue.value - secretValue.value)
            }
            print(secretValue.value, userValue.value, compareResult)
            return compareResult
        }
    }
        
    static func getColorGame() -> some GameProtocol {

        let colorSecretValue = ColorSecretValue(value: Color()) { color in
            var newColor = color
            newColor.red = Array(0...255).randomElement()!
            newColor.green = Array(0...255).randomElement()!
            newColor.blue = Array(0...255).randomElement()!
            return newColor
        }

        return Game<ColorSecretValue>(secretValue: colorSecretValue, rounds: 5) { secretValue, userValue in
            
            return secretValue.value == userValue.value ? 1 : 0
        }
    }
}
