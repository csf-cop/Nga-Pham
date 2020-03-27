//
//  ContactModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/25/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

final class ContactModel {
    var contact: CoreContact = CoreContact()
    var avatar: CoreImage?

    init() { }

    init(contact: CoreContact, photo: CoreImage?) {
        self.contact = contact
        avatar = photo
    }
}
