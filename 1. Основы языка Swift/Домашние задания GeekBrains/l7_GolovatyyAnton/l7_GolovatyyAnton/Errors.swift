//
//  Errors.swift
//  l7_GolovatyyAnton
//
//  Created by Антон Головатый on 08.12.2021.
//

//MARK: - UserError enum declaration
enum UserError: Error {
    case accountAlreadyOpened
    case accountNotExist
}

enum AtmError: Error {
    case atmIsNotWorking
}

enum BankAccountError: Error {
    case incorrectPinCode
    case insufficientFunds
    case zeroTransactionAmount
}
