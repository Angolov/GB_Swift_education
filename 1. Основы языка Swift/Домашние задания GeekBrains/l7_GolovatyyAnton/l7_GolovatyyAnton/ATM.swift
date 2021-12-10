//
//  ATM.swift
//  l7_GolovatyyAnton
//
//  Created by Антон Головатый on 08.12.2021.
//

//MARK: - AtmOperationsProtocol declaration
protocol AtmOperationsProtocol {
    
    func openBankAccountFor(_ user: User) -> BankAccount?
    func closeBankAccountOf(_ user: User)
    func makeTransaction(_ transaction: BankTransaction, for user: User)
}

//MARK: - ATM structure declaration
struct ATM {
    
    //MARK: - Enums
    enum atmState {
        case on
        case off
        case error
    }
    
    //MARK: - Private properties
    private var currentState: atmState
    
    //MARK: - Initializer
    init() {
        
        currentState = .on
    }
}

//MARK: - Extension for AtmOperationsProtocol
extension ATM: AtmOperationsProtocol {
    
    //MARK: - Public methods
    mutating func changeAtmStateFor(_ state: atmState) {
        
        currentState = state
    }
    
    func openBankAccountFor(_ user: User) -> BankAccount? {
        
        do {
            guard self.currentState == .on else { throw AtmError.atmIsNotWorking }
            guard user.bankAccount == nil else { throw UserError.accountAlreadyOpened }
            guard user.pinCode == user.bankAccount?.getPin else { throw BankAccountError.incorrectPinCode }
            
            let newAccount = BankAccount(userFullName: user.getFullName)
            user.pinCode = newAccount.getPin
            print("Congratulations \(user.getFullName)!\nYou have opened an account in our Orange Bank!")
            return newAccount
            
        } catch UserError.accountAlreadyOpened {
            print("Bank account already exists.")
            return user.bankAccount
            
        } catch AtmError.atmIsNotWorking {
            print("ATM is not working.")
          
        } catch let error {
            print(error)
        }
        
        return nil
        
    }
    
    func closeBankAccountOf(_ user: User) {
        
        do {
            guard self.currentState == .on else { throw AtmError.atmIsNotWorking }
            guard let amount = user.bankAccount?.getAmount else { throw UserError.accountNotExist }
            guard user.pinCode == user.bankAccount?.getPin else { throw BankAccountError.incorrectPinCode }
            
            print("We're sorry that you've deceided to close your account.\nWe will miss you.")
            if amount > 0 {
                makeTransaction(BankTransaction(amount: amount, type: .cashWithdrawal), for: user)
            }
            user.bankAccount = nil
            
        } catch UserError.accountNotExist {
            print("Bank account for \(user.getFullName) doesn't exist.")
            
        } catch BankAccountError.incorrectPinCode {
            print("Incorrect PIN code.")
            
        } catch AtmError.atmIsNotWorking {
            print("ATM is not working.")
          
        } catch let error {
            print(error)
        }
    }
    
    func makeTransaction(_ transaction: BankTransaction, for user: User) {
        
        do {
            guard self.currentState == .on else { throw AtmError.atmIsNotWorking }
            guard let account = user.bankAccount else { throw UserError.accountNotExist }
            guard user.pinCode == user.bankAccount?.getPin else { throw BankAccountError.incorrectPinCode }
            
            switch transaction.type {
                
            case .cashWithdrawal:
                try account.reduceAmountOfMoneyOn(transaction.amount)
                print("You have succesfully withdrawed \(transaction.amount) from your bank account.")
                
            case .cashInput:
                try account.increaseAmountOfMoneyOn(transaction.amount)
                print("Thank you!\nYou have succesfully put \(transaction.amount) on your bank account.")
                
            case .checkAccount:
                print("Your account balance is \(account.returnMoneyAmount()).")
                
            case .moneyTransfer, .payment:
                print("Your \(transaction.type) transaction for \(transaction.amount) is about to be executed.")
                try account.reduceAmountOfMoneyOn(transaction.amount)
                print("Your transaction is done.\nHave a nice day!")
            }
            
        } catch UserError.accountNotExist {
            print("Bank account for \(user.getFullName) doesn't exist.")
            
        } catch BankAccountError.incorrectPinCode {
            print("Incorrect PIN code.")
            
        } catch BankAccountError.insufficientFunds {
            print("We're sorry, but your transaction can't be executed.\nInsufficient funds.")
            
        } catch BankAccountError.zeroTransactionAmount {
            print("We're sorry, but your transaction can't be executed.\nYou have not input the transaction amount.")
          
        } catch AtmError.atmIsNotWorking {
            print("ATM is not working.")
          
        } catch let error {
            print(error)
        }
    }
}
