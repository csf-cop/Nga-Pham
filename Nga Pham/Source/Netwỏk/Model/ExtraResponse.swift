//
//  ExtraResponse.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/31/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

struct ExtraResponse: Codable {
    var isNextPage: Bool = false
    var nextToDate: Date?

    init(from decoder: Decoder) throws {
        isNextPage = try decoder.decodeIfPresent("is_next_page").unwrapped(or: false)
        nextToDate = try? decoder.decode("next_to_date", using: Date.fullDateFormatter())
    }
}
