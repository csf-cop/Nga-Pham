//
//  ContactCellModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import UIKit.UIImage

final class ContactCellModel {
    var fullName: String
    var avatarData: Data?

    init(model: ContactModel) {
        let defaultImage: UIImage = #imageLiteral(resourceName: "img_no_image")
        fullName = model.contact.fullName
        avatarData = (model.avatar?.imageData).unwrapped(or: defaultImage.toData())
    }
}
