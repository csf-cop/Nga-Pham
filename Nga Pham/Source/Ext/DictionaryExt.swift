//
//  DictionaryExt.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/31/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

extension Dictionary {

    public var allKeys: [Key] {
        return Array(keys)
    }

    public var allValues: [Value] {
        return Array(values)
    }

    mutating func updateValues(_ info: [Key: Value]?) {
        guard let info = info else { return }
        for (key, value) in info {
            self[key] = value
        }
    }
}
