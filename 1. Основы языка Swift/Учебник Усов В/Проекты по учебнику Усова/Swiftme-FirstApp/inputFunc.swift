//
//  inputFunc.swift
//  Swiftme-FirstApp
//
//  Created by Антон Головатый on 22.11.2021.
//

import Foundation

func getNumOptionalFromUser() -> Int? {
    
    var isInputOk = false
    
    repeat {
        guard let userInput = readLine() else { return nil }
        guard userInput.lowercased() != "exit" else { return nil }
        if let correctInput = Int(userInput) {
            isInputOk = true
            return correctInput
        } else {
            print("It is not a number, try again.")
        }
    } while !isInputOk
}

func getOperationOptionalFromUser() -> String? {
    
    var isInputOk = false
    
    repeat {
        guard let userInput = readLine() else { return nil }
        guard userInput.lowercased() != "exit" else { return nil }
        
        switch userInput {
        case "+", "*", "-", "/", "^":
            isInputOk = true
            return userInput
        default:
            print("It is not a math operation, try again.")
        }
    } while !isInputOk
}


func getInputFromUser () -> (((Double, Double) -> Double), [Double])? {
    
    let mathClosure: (Double, Double) -> Double
    
    // Getting math operation
    print("Input math operation or type \"exit\" to close the program:")
    let operationOptional = getOperationOptionalFromUser()
    guard operationOptional != nil else { return nil }
    let mathOperation = operationOptional!
    
    switch mathOperation {
    case "+":
        mathClosure = { $0 + $1 }
    case "-":
        mathClosure = { $0 - $1 }
    case "*":
        mathClosure = { $0 * $1 }
    case "/":
        mathClosure = { $0 / $1 }
    case "^":
        mathClosure = { pow($0, $1) }
    default:
        return nil
    }
    
    // Getting numbers
    var numsArray = [Double]()
    let arrayCount: Int
    
    if mathOperation == "^" {
        arrayCount = 2
        print("Your type of operation can be used only for 2 numbers.")
    } else {
        // Getting number of numbers
        print("Input amount of numbers or type \"exit\" to close the program:")
        let numOptional = getNumOptionalFromUser()
        guard numOptional != nil else { return nil }
        arrayCount = numOptional!
    }
    
    // Filling the array
    for i in 0...arrayCount-1 {
        print("Input number #\(i+1) or type \"exit\" to close the program:")
        let numOptional = getNumOptionalFromUser()
        guard numOptional != nil else { return nil }
        numsArray.append(Double(numOptional!))
    }
    
    return (mathClosure, numsArray)
}
