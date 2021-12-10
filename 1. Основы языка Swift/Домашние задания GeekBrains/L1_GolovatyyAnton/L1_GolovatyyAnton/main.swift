//
//  main.swift
//  L1_GolovatyyAnton
//
//  Created by Антон Головатый on 13.11.2021.
//

import Foundation

// Домашнее задание
// Упражнение 1. Решить  квадратное  уравнение.
// ax2+bx+c=0, значения коэффициентов можно подставлять любые.

print("Excercise #1")

let coefficientA: Double = 1
let coefficientB: Double = 3
let coefficientC: Double = 2

if coefficientA != 0 {
    let determinant = coefficientB * coefficientB - 4 * coefficientA * coefficientC
    if determinant == 0 {
        let singleRoot = -coefficientB / 2 * coefficientA
        print("Quadratic equation determinant is equal zero.")
        print("The single root is \(singleRoot).")
    } else if determinant > 0 {
        let firstRoot = (-coefficientB + determinant.squareRoot()) / 2 * coefficientA
        let secondRoot = (-coefficientB - determinant.squareRoot()) / 2 * coefficientA
        print("Quadratic equation determinant is above zero.")
        print("First root is \(firstRoot)")
        print("Second root is \(secondRoot).")
    } else {
        print("Quadratic equation determinant is negative. No roots are available.")
    }
} else {
    let singleRoot = -coefficientC / coefficientB
    print("It is not a quadratic equation.")
    print("The single root of this equation is \(singleRoot)")
}
print()

// Упражнение 2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

print("Excercise #2")

let legALength: Double = 3
let legBLength: Double = 4

let hypotenuseLength = (legALength * legALength + legBLength * legBLength).squareRoot()
let rightTrianglePerimeter = legALength + legBLength + hypotenuseLength
let rightTriangleArea = legALength * legBLength / 2

print("Rigth triangle legs are \(legALength) and \(legBLength).\nHypotenuse is \(hypotenuseLength)")
print("The perimeter of the triangle is equal to \(rightTrianglePerimeter)")
print("The area of the triangle is equal to \(rightTriangleArea)")
print()

// Упражнение 3*. Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5  лет.

print("Excercise #3")

var clientAccountMoneyAmount: Double = 0
var bankInterestRate: Double = 0
let availableYears = 5
var isInputIncorrect = true

while isInputIncorrect {
    isInputIncorrect = false
    print("Please insert the initial ammount of money on your bank account:")
    if let userInput = readLine(){
        if let correctInput = Double(userInput){
            clientAccountMoneyAmount = correctInput
        } else {
            print("It is not a number.")
            isInputIncorrect = true
            continue
        }
    } else {
        print("There was no input.")
        isInputIncorrect = true
        continue
    }
    print("Please specify your bank's interest rate:")
    if let userInput = readLine(){
        if let correctInput = Double(userInput){
            bankInterestRate = correctInput
        } else {
            print("It is not a number.")
            isInputIncorrect = true
            continue
        }
    } else {
        print("There was no input.")
        isInputIncorrect = true
        continue
    }
}

print()

for _ in 1...availableYears {
    clientAccountMoneyAmount *= (1.0 + bankInterestRate / 100.0)
    clientAccountMoneyAmount.round(.down)

}

print("The amount of money on client account after 5 years including interest rate of \(bankInterestRate)% is:")
print("\(Int(clientAccountMoneyAmount))")

