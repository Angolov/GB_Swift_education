//
//  User.swift
//  l7_GolovatyyAnton
//
//  Created by Антон Головатый on 08.12.2021.
//

//MARK: - UserProtocol declaration
private protocol UserProtocol {
    
    var name: String { get }
    var surname: String { get }
    var age: UInt { get set }
}

//MARK: - UserActionProtocol declaration
protocol UserActionsProtocol {
    
    func printDescription()
    func openBankAccountOn(_ atm: ATM)
    func closeBankAccountOn(_ atm: ATM)
    func makeTransaction(_ transaction: BankTransaction, on atm: ATM)
}

//MARK: - User class declaration
final class User: UserProtocol {
    
    //MARK: - Private properties
    fileprivate let name: String
    fileprivate let surname: String
    fileprivate var age: UInt
    
    //MARK: - Internal properties
    var bankAccount: BankAccount?
    var pinCode: UInt16?
    
    //MARK: - Computed property
    var getFullName: String {
        return name + " " + surname
    }
    
    //MARK: - Initializers
    init(name: String, surname: String, age: UInt, bankAccount: BankAccount? = nil) {
        
        self.name = name
        self.surname = surname
        self.age = age
        self.bankAccount = bankAccount
        pinCode = nil
    }
    
    convenience init() {
        
        let names = ["Alex", "Leo", "Zoe", "Barry", "John", "Frank", "Marry", "Nicole", "Kate", "Jane", "Violet"]
        let surnames = ["Black", "Simone", "Smit", "Jones", "Simons", "Toffin", "Turner", "Willis"]
        
        self.init(name: names.randomElement() ?? "Max",
                  surname: surnames.randomElement() ?? "York",
                  age: UInt.random(in: 18...50),
                  bankAccount: nil)
    }
}

//MARK: - Extension for UserActionProtocol
extension User: UserActionsProtocol {
    
    //MARK: - Public methods
    func printDescription() {
        
        print("""
            My name is \(name) \(surname).
            I am \(age) old.
            I have \(bankAccount == nil ? "no" : "a") bank account.
            """)
    }
    
    func openBankAccountOn(_ atm: ATM) {
        bankAccount = atm.openBankAccountFor(self)
    }
    
    func closeBankAccountOn(_ atm: ATM) {
        atm.closeBankAccountOf(self)
    }
    
    func makeTransaction(_ transaction: BankTransaction, on atm: ATM) {
        atm.makeTransaction(transaction, for: self)
    }
    
}
