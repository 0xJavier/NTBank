//
//  UserMockData.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import Foundation

class UserMockData {
    public private(set) var user = User(id: "12345", userInfo: ["name": "Javier", "email": "a@b.com", "color": "blue", "balance": 1500])
    
    public private(set) var transactions = [Transaction(amount: 200, action: "Collected GO", createdAt: 1),
                                            Transaction(amount: -120, action: "Paid Molly", createdAt: 2),
                                            Transaction(amount: 400, action: "Won the lottery", createdAt: 3)]
    
    public private(set) var players: [User] = [
        User(id: "23456", userInfo: ["name": "Player", "email": "d@b.com", "color": "blue", "balance": 219]),
        User(id: "34567", userInfo: ["name": "Molly", "email": "b@c.com", "color": "red", "balance": 743]),
        User(id: "45678", userInfo: ["name": "Javier", "email": "a@b.com", "color": "orange", "balance": 1500])
    ]
}
