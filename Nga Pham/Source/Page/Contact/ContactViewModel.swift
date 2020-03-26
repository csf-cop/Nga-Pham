//
//  ContactViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import UIKit

final class ContactViewModel: BaseViewModel {
    private var contactsModel: [ContactModel] = []
}

extension ContactViewModel {
    func numberOfItemsInSection() -> Int {
        return contactsModel.count
    }

    func modelForCell(at: IndexPath) -> ContactCellModel {
        let contact: ContactModel = contactsModel[safe: at.row].unwrapped(or: ContactModel(contact: CoreContact(), photo: nil))
        return ContactCellModel(model: contact)
    }

    func contactModel(at: IndexPath) -> ContactDetailViewModel {
        return ContactDetailViewModel(model: ContactModel())
//            contacts[safe: at.row].unwrapped(or: CoreContact()))
    }

    func loadContactsData() {
        CoreContact.all(predicate: nil, success: { result in
            guard let result: [CoreContact] = result as? [CoreContact] else {
                return
            }
            self.generateModel(data: result)
            #warning("Customize source code - after.")
//            if self.contacts.isEmpty {
//                self.contacts = result
//            } else {
//                 result.forEach { item in
//                    if self.contacts.first(where: { $0.id.elementsEqual(item.id) }) == nil {
//                        self.contacts.append(item)
//                    }
//                }
//            }
        }) { (err) in
            print("Fetch fail cmnr: \(err)")
        }
    }

    #warning("Customize source code.")
//    func additionalContact(contact: CoreContact) {
//        contacts.append(contact)
//    }
}

extension ContactViewModel {
    private func generateModel(data: [CoreContact]) {
        if data.isEmpty { return }
//        let avatarImages: [CoreImage] = 
    }
}
