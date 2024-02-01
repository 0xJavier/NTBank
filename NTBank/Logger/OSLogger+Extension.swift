//
//  OSLogger+Extension.swift
//  NTBank
//
//  Created by Javier Munoz on 2/1/24.
//

import Foundation
import OSLog

extension Logger {
    /// Utilizing the app's bundle identifier to create a unique name for our logger
    private static var subsystem = Bundle.main.bundleIdentifier!
}

/// Models / Types
extension Logger {
    static let transactionType = Logger(subsystem: subsystem, category: "TransactionType")
}

/// Service Loggers
extension Logger {
    static let actionService = Logger(subsystem: subsystem, category: "ActionService")
    static let lotteryService = Logger(subsystem: subsystem, category: "LotteryService")
    static let rankingService = Logger(subsystem: subsystem, category: "RankingService")
    static let sendMoneyService = Logger(subsystem: subsystem, category: "SendMoneyService")
    static let settingsService = Logger(subsystem: subsystem, category: "SettingsService")
    static let transactionService = Logger(subsystem: subsystem, category: "TransactionSystem")
    static let userService = Logger(subsystem: subsystem, category: "UserService")
}
