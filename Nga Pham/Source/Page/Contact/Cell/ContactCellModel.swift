//
//  ContactCellModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

final class ContactCellModel {
    var fullName: String
    var avatarData: Data?

    init(model: ContactModel) {
        fullName = model.contact.fullName
        avatarData = model.avatar?.imageData
    }
}
