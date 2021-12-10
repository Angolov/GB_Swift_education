//
//  gameFunc.swift
//  Unknown Number
//
//  Created by Антон Головатый on 22.11.2021.
//

func selectNumber (in range: ClosedRange<Int>) -> Int {
    Int.random(in: range)
}

func startTheGame () -> Void {
    
    var isGoingForAnotherRound = false
    
    // Начинаем игру
mainloop: repeat {
    
    // Компьютер выбирает число
    let computerNumber = selectNumber(in: 1...300)
    var isNumberGuessed = false
        repeat {
            // Пользователь вводит число
            let message = "Try to guess my number. Input your below or type \"exit\" to close the program:"
            if let userNumber = getUserNumber(with: message) {
                if userNumber == computerNumber {
                    isNumberGuessed = true
                    print("Congratulations! You've guessed right!")
                } else if userNumber > computerNumber {
                    print("Your number is greater than mine.")
                } else {
                    print("Yout number is lower than mine.")
                }
            } else {
                break mainloop
            }
        } while !isNumberGuessed
        print("Play again? (Y/N)")
        if let userInput = readLine() {
            switch userInput {
            case "Y", "y":
                isGoingForAnotherRound = true
                isNumberGuessed = false
            case "N", "n":
                isGoingForAnotherRound = false
            default:
                break mainloop
            }
        } else {
            break mainloop
        }
    } while isGoingForAnotherRound
}
