//
//  ItemCollectionCellModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

final class ItemCollectionCellModel {
    let description: String
    let avatarData: Data?

    init(model: JuiceModel) {
        description = model.juice.juiceDescription.unwrapped(or: "")
        avatarData = model.avatar?.imageData
    }
}
