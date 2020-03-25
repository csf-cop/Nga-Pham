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
    var model: ContactModel

    init(model: ContactModel) {
        self.model = model
    }
}

extension ContactDetailViewModel {
    func deleteContact() {
        model.contact.delete(completed: { err in
            if err == nil {
                print("Delete success")
            } else {
                print("Delete fail: \(err!.localizedDescription)")
            }
        })
    }
}
