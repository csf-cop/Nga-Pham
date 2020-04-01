//
//  OrderModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 4/1/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

struct OrderModel: Codable {
    var id: String = ""
    var juiceName: String = ""

    init() { }

    init(from decoder: Decoder) throws {
        id = try decoder.decodeIfPresent("id").unwrapped(or: "")
        juiceName = try decoder.decodeIfPresent("name").unwrapped(or: "")
    }
}
