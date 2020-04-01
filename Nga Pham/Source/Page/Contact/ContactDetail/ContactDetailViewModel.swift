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
    private var id: String
    var avatar: Data?
    var fullName: String
    var phone: String

    init(id: String? = nil, avatar: Data? = nil, fullName: String? = nil, phone: String? = nil) {
        self.id = id.unwrapped(or: "")
        self.avatar = avatar
        self.fullName = fullName.unwrapped(or: "")
        self.phone = phone.unwrapped(or: "")
    }
}

extension ContactDetailViewModel {
    func deleteContact(completion: @escaping Completed) {
        completion(true)
//        contactDetail.contact.delete(completed: { (err) in
//            if err == nil {
//                completion(true)
//            } else {
//                completion(false)
//            }
//        })
    }
}
