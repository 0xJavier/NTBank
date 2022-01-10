//
//  TransactionViewModel.swift
//  NTBank
//
//  Created by Javier Munoz on 12/9/21.
//

import Foundation
import Combine

@MainActor final class TransactionViewModel {
    @Published var transactions = [Transaction]()
    
    private var service: TransactionServiceProtocol
    
    init(_ service: TransactionServiceProtocol = TransactionService()) {
        self.service = service
        listenForTransactionChanges()
    }
    
    private func listenForTransactionChanges() {
        service.streamUserTransactions { result in
            switch result {
            case .success(let transactions):
                self.transactions = transactions
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
