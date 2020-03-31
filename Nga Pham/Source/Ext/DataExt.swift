//
//  DataExt.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/31/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

extension Data {
    func toJson() -> [String: Any]? {
        if let decoded = try? JSONSerialization.jsonObject(with: self, options: []),
            let dict = decoded as? [String: Any] {
            return dict
        }
        return nil
    }

    private static let mimeTypeSignatures: [UInt8: String] = [
        0x89: "image/png"
    ]

    var mimeType: String {
        var c: UInt8 = 0
        copyBytes(to: &c, count: 1)
        return Data.mimeTypeSignatures[c] ?? "image/jpeg"
    }
}
