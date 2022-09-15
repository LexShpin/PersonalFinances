//
//  Constants.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 11.09.2022.
//

import Foundation
import UIKit

struct K {
    
    static let registrationSegue = "RegisterToBudget"
    static let loginSegue = "LoginToBudget"
    static let tableViewCell = "ReusableCell"
    static let cellNibName = "TransactionCell"
    static let transactionsToAddTransaction = "transactionsToAddTransaction"
    static let addTransactionSegue = "addTransactionToTransactions"
    static let editTransactionSegue = "editTransaction"
    static let transactionsToEditTransaction = "transactionsToEditTransaction"
    
    static let recentTransactions = 4
    
    struct BrandColors {
        static let lightPurple = "BrandLightPurple"
    }
    
    struct FireStore {
        static let transactionsCollection = "transactions"
        static let transactionDescription = "description"
        static let transactionAmount = "amount"
        static let dateField = "date"
        static let id = "id"
        static let user = "user"
        
        static let balanceCollection = "balances"
        static let balanceField = "balance"
    }
}
