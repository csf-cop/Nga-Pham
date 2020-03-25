//
//  CollectionExt.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        if self.indices.contains(index) {
            return self[index]
        }
        return nil
    }
}

extension Collection where Index == Int {

    func group(by size: Int) -> [[Element]] {
        guard size > 0, !isEmpty else { return [] }
        var value: Int = 0
        var slices: [[Element]] = []
        while value < count {
            slices.append(Array(self[Swift.max(value, startIndex)..<Swift.min(value + size, endIndex)]))
            value += size
        }
        return slices
    }
}

extension Array where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
