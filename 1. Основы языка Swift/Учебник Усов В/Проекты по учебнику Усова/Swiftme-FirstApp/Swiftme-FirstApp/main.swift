//
//  main.swift
//  Swiftme-FirstApp
//
//  Created by Антон Головатый on 22.11.2021.
//

let mathOptional = getInputFromUser()
var isUserClosingProgram = mathOptional == nil

if !isUserClosingProgram {
    let numArray = mathOptional!.1
    var result: Double = numArray[0]
            
    for number in 1...numArray.endIndex-1 {
        result = doOperation(mathOptional!.0, with: result, and: numArray[number])
    }
    print("\n=========================================")
    print("The result of math operation is \(result)")
}

print("\nThank you for using our product.")


