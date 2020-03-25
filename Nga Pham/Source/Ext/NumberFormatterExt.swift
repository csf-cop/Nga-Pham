//
//  NumberFormatterExt.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        return formatter
    }()

    static func withFormatter(formatStr: String) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = formatStr
        formatter.numberStyle = .decimal
        return formatter
    }
}

extension Numeric {
    var formattedWithSeparator: String {
        return NumberFormatter.withFormatter(formatStr: ",").string(for: self).unwrapped(or: "")
    }
}
