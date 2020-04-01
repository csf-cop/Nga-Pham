//
//  SplashViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 4/1/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

final class SplashViewModel: BaseViewModel {
    let provider: OrderProvider = OrderProvider()
    private var syncOrder: [OrderModel] = []
}

// MARK: Call API
extension SplashViewModel {
    func fetchOders(completion: @escaping Completed) {
        provider.fetchOrders(isUseStub: true) { [weak self] result in
            guard let this = self else {
                completion(false)
                return
            }
            switch result {
            case .success(let value):
                this.syncOrder = [value]
                print("Response: \(this.syncOrder)")
                completion(true)
            case .error(let e):
                switch e.nsError?.code {
                case Constants.doesNotExistCode:
                    this.handleErrorMessage?(Constants.doesNotExistFailedError)
                    
                default:
                    this.handleErrorMessage?(e)
                }
                completion(false)
            }
        }
    }
}

extension SplashViewModel {
    struct Constants {
        static let doesNotExistCode: Int = 400
        static let doesNotExistFailedError: NSError = NSError(message: "Không tìm thấy đơn hàng.")
    }
}
