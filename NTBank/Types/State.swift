//
//  State.swift
//  NTBank
//
//  Created by Javier Munoz on 1/8/22.
//

import Foundation

enum State {
    case loading
    case loaded
    case error(Error)
    case success
}

enum LoginState {
    case loaded
    case loginSuccessfull
    case forgotPasswordSuccessfull
    case failed(Error)
}
