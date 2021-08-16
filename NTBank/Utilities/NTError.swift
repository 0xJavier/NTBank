//
//  NTError.swift
//  NTBank
//
//  Created by Javier Munoz on 8/13/21.
//

import Foundation

enum NTError: Error {
    case couldNotGetUserID
    case documentDataError
}

extension NTError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .couldNotGetUserID:
            return "Could not get current user`s ID."
        case .documentDataError:
            return "Could not get the data from the document."
        }
    }
}
