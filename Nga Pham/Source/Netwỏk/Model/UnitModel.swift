//
//  UnitModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 4/1/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

struct UnitModel: Codable {
    var id: String = ""
    var externalId: String = ""
    var isDelete: Bool = false

    init(from decoder: Decoder) throws {
        id = try decoder.decodeIfPresent("id").unwrapped(or: "")
        externalId = try decoder.decodeIfPresent("external_id").unwrapped(or: "")
        isDelete = try decoder.decodeIfPresent("is_delete").unwrapped(or: false)
    }
}
