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
    private var contacts: [CoreContact] = []
}

extension ContactViewModel {
    func numberOfItemsInSection() -> Int {
        return contacts.count
    }

    func modelForCell(at: IndexPath) -> ContactCellModel {
        return ContactCellModel(model: contacts[safe: at.row].unwrapped(or: CoreContact()))
    }

    func contactModel(at: IndexPath) -> ContactDetailViewModel {
        return ContactDetailViewModel(model: contacts[safe: at.row].unwrapped(or: CoreContact()))
    }

    func loadContactsData() {
        CoreContact.all(predicate: nil, success: { result in
            guard let result: [CoreContact] = result as? [CoreContact] else {
                return
            }
            self.contacts = result
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

    func additionalContact(contact: CoreContact) {
        contacts.append(contact)
    }
}

extension ContactViewModel {

}
