//
//  OrderJuiceViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

final class OrderJuiceViewModel {
    
}

extension OrderJuiceViewModel {
    func fetchCategoriesType() -> [[String]] {
        let juiceType: [String] = ["Cam", "Dưa"]
        return [juiceType]
    }

    func fetchCategoriesUnit() -> [[String]] {
        let juiceUnit: [String] = ["Quả"]
        return [juiceUnit]
    }
}
