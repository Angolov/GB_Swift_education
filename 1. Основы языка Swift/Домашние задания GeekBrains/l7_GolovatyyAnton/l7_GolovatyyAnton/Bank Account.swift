//
//  Bank Account.swift
//  l7_GolovatyyAnton
//
//  Created by Антон Головатый on 08.12.2021.
//

//MARK: - AccountActionsProtocol declaration
protocol AccountActionsProtocol {
    
    func returnMoneyAmount() -> String
    func reduceAmountOfMoneyOn(_ amount: UInt) throws
    func increaseAmountOfMoneyOn(_ amount: UInt) throws
    func makeTransaction(_ transaction: BankTransaction) throws
}

//MARK: - BankAccount class declaration
final class BankAccount {
    
    //MARK: - Private properties
    private let userFullName: String
    private var pinCode: UInt16
    private var moneyAmount: UInt
    
    //MARK: - Computed properties
    var getPin: UInt16 {
        
        return pinCode
    }
    
    var getAmount: UInt {
        
        return moneyAmount
    }
    
    
    //MARK: - Initializer
    init(userFullName: String, moneyAmount: UInt = 0) {

        self.userFullName = userFullName
        self.moneyAmount = moneyAmount
        pinCode = UInt16.random(in: 1000...9999)
    }
    
    deinit {
        
        print("Bank account of \(userFullName) is closed.")
    }
    
    //MARK: - Public methods
    func changePinCode() {
        
        pinCode = UInt16.random(in: 1000...9999)
    }
    
}

//MARK: - Extension for AccountActionsProtocol
extension BankAccount: AccountActionsProtocol {
    
    func returnMoneyAmount() -> String {
        
        return "\(moneyAmount)"
    }
    
    func reduceAmountOfMoneyOn(_ amount: UInt) throws {
        
        guard amount <= moneyAmount else { throw BankAccountError.insufficientFunds }
        guard amount > 0 else { throw BankAccountError.zeroTransactionAmount }
        moneyAmount -= amount
    }
    
    func increaseAmountOfMoneyOn(_ amount: UInt) throws {
        
        guard amount > 0 else { throw BankAccountError.zeroTransactionAmount }
        moneyAmount += amount
    }
    
    func makeTransaction(_ transaction: BankTransaction) throws {
        
        guard transaction.amount <= moneyAmount else { throw BankAccountError.insufficientFunds }
        guard transaction.amount > 0 else { throw BankAccountError.zeroTransactionAmount }
        moneyAmount -= transaction.amount
    }
    
}
