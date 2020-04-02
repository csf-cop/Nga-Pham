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
        guard let contact: ContactModel = contactsModel[safe: at.row] else { return ContactCellModel() }
        return ContactCellModel(id: contact.avatarId, name: contact.fullName, image: contact.image)
    }

    func contactModel(at: IndexPath) -> ContactDetailViewModel {
        guard let model: ContactModel = contactsModel[safe: at.row] else { return ContactDetailViewModel() }
        return ContactDetailViewModel(id: model.id, avatar: model.image, fullName: model.fullName, phone: model.phone)
    }

    func loadContactsData(completion: @escaping Completed) {
        CoreContact.all(predicate: nil, success: { result in
            guard let result: [CoreContact] = result as? [CoreContact] else {
                return
            }
            self.generateModel(data: result)
            completion(true)
        }) { (err) in
            self.handleErrorMessage?(err)
            completion(false)
        }
    }
}

extension ContactViewModel {
    private func generateModel(data: [CoreContact]) {
        if data.isEmpty { return }
        contactsModel = []
        let imageIds: [String] = data.map { $0.avatarId.unwrapped(or: "") }.removeDuplicates().filter({ $0.isEmpty == false })
        CoreImage.all(predicate: NSPredicate(format: "id in %@", imageIds), success: { photos in
            guard let photos: [CoreImage] = photos as? [CoreImage] else {
                return
            }
            data.forEach { contact in
                let avatar: CoreImage? = photos.first(where: {$0.id.elementsEqual(contact.avatarId.unwrapped(or: ""))})
                var model: ContactModel = ContactModel(core: contact)
                model.image = avatar?.imageData
                self.contactsModel.append(model)
            }
        }) { (err) in
            print("Fetch fail cmnr: \(err)")
        }
    }
}
