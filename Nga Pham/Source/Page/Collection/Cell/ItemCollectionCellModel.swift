//
//  ItemCollectionCellModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

final class ItemCollectionCellModel {
    let imageUrl: Data?
    let description: String

    init(data: CoreJuice) {
        description = data.juiceDescription
        imageUrl = nil
    }
}
