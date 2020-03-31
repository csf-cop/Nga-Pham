//
//  GPRespose.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/31/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

struct GPResponse<Model>: Codable where Model: Codable {
    var error: String?
    var type: String?
    var message: String?
    var data: Model?
}

struct GPResponseExtra<Model, Extra>: Codable where Model: Codable, Extra: Codable {
    var error: String?
    var type: String?
    var message: String?
    var data: Model?
    var extra: Extra?
}
