//
//  ContactCellModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

final class ContactCellModel {
    let id: String
    var fullName: String
    var avatar: Data?

    init(id: String = "", name: String = "", image: Data? = nil) {
        self.id = id
        fullName = name
        avatar = image
    }
}
