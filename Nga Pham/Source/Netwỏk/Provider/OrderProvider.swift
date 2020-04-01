//
//  OrderProvider.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 4/1/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Alamofire
#if os(iOS)
import OHHTTPStubs
#endif

final class OrderProvider {

    @discardableResult
    func fetchOrders(isUseStub: Bool = false, callback: @escaping (Result<OrderModel>) -> Void) -> DataRequest? {
        #if os(iOS)
        if isUseStub {
            stub(condition: isHost(Environment.host) && isPath(FetchOrderRequest.endpoint.string)) { _ in
                let stubData: Data = "OrderInfo".convertFileToData()
                return OHHTTPStubsResponse(data: stubData, statusCode: 200, headers: nil)
            }
        }
        #endif
        return FetchOrderRequest.request(callback: callback)
    }
}
