//
//  Action.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

enum ResultData<Value> {
    case success(Value)
    case failure(Error)
}

enum Results {
    case success
    case failure(Error)
}

typealias CompletionData<T> = (ResultData<T>) -> Void
typealias Completion = (Results) -> Void

typealias Completed = ((Bool) -> Void)

enum Action<T> {
    case update
    case next
    case previous
    case finish
    case help
    case cancel
    case collapse
    case send(T)
    case yes
    case no
    case view(T)
}
