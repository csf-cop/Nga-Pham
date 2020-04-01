//
//  OrderRequest.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 4/1/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Alamofire

struct FetchOrderRequest: APIRequestRepresentableOriginal {
    typealias CodableType = [OrderModel]
    static var method: Alamofire.HTTPMethod = .post
    static var endpoint: Api.Endpoint = .getOrders
    static var isEnableLog: Bool = true
}
