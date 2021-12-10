//
//  main.swift
//  l7_GolovatyyAnton
//
//  Created by Антон Головатый on 08.12.2021.
//

let orangeBankATM = ATM()
let someUser: UserActionsProtocol = User()

someUser.printDescription()
print()

someUser.openBankAccountOn(orangeBankATM)
print()

someUser.makeTransaction(BankTransaction(amount: 200, type: .cashInput), on: orangeBankATM)
someUser.makeTransaction(BankTransaction(type: .checkAccount), on: orangeBankATM)
someUser.makeTransaction(BankTransaction(amount: 200, type: .payment), on: orangeBankATM)
someUser.makeTransaction(BankTransaction(amount: 200, type: .cashWithdrawal), on: orangeBankATM)
print()

someUser.closeBankAccountOn(orangeBankATM)
print()
