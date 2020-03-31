//
//  Base.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/31/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

struct Base: Codable {
    var token: String
    var appVersion: String?

    enum CodingKeys: String, CodingKey {
        case appVersion = "require_app_version"
    }

    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        token = try decoder.decode("token")
        let verCodable = try container?.superDecoder(forKey: .appVersion)
        appVersion = try verCodable?.decodeIfPresent("ios")
    }
}
