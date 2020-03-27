//
//  ContactDetailViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import UIKit.UIImage
import CoreData

final class ContactDetailViewModel: BaseViewModel {
    var contactDetail: ContactModel
    var isHaveImage: Bool {
        return contactDetail.contact.avatarId != nil && contactDetail.contact.avatarId?.isEmpty == false
    }

    init(model: ContactModel) {
        self.contactDetail = model
    }
}

extension ContactDetailViewModel {
    func deleteContact(completion: @escaping Completed) {
        contactDetail.contact.delete(completed: { (err) in
            if err == nil {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
}
