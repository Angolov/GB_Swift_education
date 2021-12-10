//
//  inputFunc.swift
//  Unknown Number
//
//  Created by Антон Головатый on 22.11.2021.
//

func getUserNumber (with message: String) -> Int? {
    
    repeat {
        print(message)
        if let userInput = readLine() {
            if let correctInput = Int(userInput) {
                return correctInput
            } else {
                if userInput.lowercased() == "exit" {
                    return nil
                } else {
                    print("It is not a number, try again.")
                }
            }
        } else {
            print("Your input is not correct.")
        }
    } while true
}
