//
//  Bank transaction.swift
//  l7_GolovatyyAnton
//
//  Created by Антон Головатый on 09.12.2021.
//

//MARK: - BankTransaction structure declaration
struct BankTransaction {
    
    //MARK: - Transactions enum
    enum TransactionType {
        case moneyTransfer
        case payment
        case cashWithdrawal
        case cashInput
        case checkAccount
    }
    
    //MARK: - Internal properties
    let amount: UInt
    let type: TransactionType
    
    //MARK: - Initializer
    init(amount: UInt = 0, type: TransactionType) {
        
        self.amount = amount
        self.type = type
    }
}
