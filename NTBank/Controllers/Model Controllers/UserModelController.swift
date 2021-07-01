//
//  UserModelController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import Foundation

protocol UserModelControllerDelegate: AnyObject {
    func didFetchUser(user: User)
    func didFetchTransactions(transactions: [Transaction])
}

class UserModelController {
    public private(set) var user = UserMockData().user
    public private(set) var transactions = UserMockData().transactions
    
    weak var userDelegate: UserModelControllerDelegate?
    
    init() {
        retrieveUser()
        retrieveTransactions()
    }
    
    func retrieveUser() {
        self.userDelegate?.didFetchUser(user: self.user)
    }
    
    func retrieveTransactions() {
        self.userDelegate?.didFetchTransactions(transactions: self.transactions)
    }
}
