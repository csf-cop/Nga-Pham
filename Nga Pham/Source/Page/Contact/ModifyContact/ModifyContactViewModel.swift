//
//  ModifyContactViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import TLPhotoPicker
import CoreData

final class ModifyContactViewModel: BaseViewModel {
    let contact: ContactModel
    let mode: App.Mode

    var uploadableImages: [UIImage] = []
    var images: [UIImage] {
        return uploadableImages
    }

    private var changeImage: Bool = false
    init(model: ContactModel = ContactModel(), mode: App.Mode = .add) {
        self.contact = model
        self.mode = mode
    }
}

extension ModifyContactViewModel {
    func getSelectedImage(selectedAssets: [TLPHAsset]) {
        uploadableImages = []
        selectedAssets.forEach { asset in
            if let image: UIImage = asset.fullResolutionImage {
                uploadableImages.append(image)
                changeImage = true
            } else {
                asset.cloudImageDownload(progressBlock: { (progress) in
                    DispatchQueue.main.async {
                        print(progress)
                    }
                }, completionBlock: { (image) in
                    if let image: UIImage = image {
                        // Use image
                        DispatchQueue.main.async {
                            print(image)
                        }
                    }
                })
            }
        }
    }

    func takePhoto(image: UIImage) {
        uploadableImages = [image]
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    func modifyContact(name: String, address: String, phone: String, note: String, completion: @escaping Completed) {
        if mode == .add {
            return addContact(name: name, address: address, phone: phone, note: note, completion: completion)
        } else {
            return updateContact(name: name, address: address, phone: phone, note: note, completion: completion)
        }
    }

    func deleteContact(completion: @escaping Completed) {
        guard let record: CoreContact = fetchContact() else {
            self.handleErrorMessage?(NSError(message: "Không tìm thấy danh bạ số (\(self.contact.id))"))
            completion(false)
            return
        }
        record.delete(completed: { (err) in
            guard let err: Error = err else {
                completion(true)
                return
            }
            self.handleErrorMessage?(err)
            completion(false)
        })
    }

    func addContact(name: String, address: String, phone: String, note: String, completion: @escaping Completed) {
        guard let context: NSManagedObjectContext = self.context else { return }
        let imageId: String = App.getNextImageKey(type: .image)

        if !uploadableImages.isEmpty {
            let avatar: CoreImage = CoreImage(context: context)
            avatar.id = imageId
            let picture: UIImage = uploadableImages[0]
            avatar.imageData = picture.toData()
            avatar.imageFileSize = picture.sizeInMB
            avatar.imageName = Date().string(withFormat: FormatType.fullTimeSecond)
            avatar.imageTypeFor = App.ImageTypeFor.contact.value
            avatar.imageDateCreate = Date()
            avatar.save(success: {
                completion(true)
            }) { (err) in
                self.handleErrorMessage?(err)
                completion(false)
                return
            }
        }

        let newContact: CoreContact = CoreContact(context: context)
        newContact.id =  App.getNextImageKey(type: .contact)
        newContact.avatarId = imageId
        newContact.fullName = name
        newContact.phone = phone
        newContact.addressPrimary = address
        newContact.addressOther = address
        newContact.noteInfo = note
        newContact.mode = 1 // Add new.
        newContact.isDelete = false

        newContact.save(success: {
            completion(true)
        }) { (err) in
            completion(false)
        }
    }

    func updateContact(name: String, address: String, phone: String, note: String, completion: @escaping Completed) {
        guard let context: NSManagedObjectContext = self.context else { return }
        guard let updatedContact: CoreContact = fetchContact() else {
            self.handleErrorMessage?(NSError(message: "Không tìm thấy danh bạ số (\(self.contact.id))"))
            completion(false)
            return
        }
        if !uploadableImages.isEmpty && changeImage {
            let avatar: CoreImage = CoreImage(context: context)
            avatar.id = App.getNextImageKey(type: .image)
            let picture: UIImage = uploadableImages[0]
            avatar.imageData = picture.toData()
            avatar.imageFileSize = picture.sizeInMB
            avatar.imageName = Date().string(withFormat: FormatType.fullTimeSecond)
            avatar.imageTypeFor = App.ImageTypeFor.contact.value
            avatar.imageDateCreate = Date()
            avatar.save(success: {
                updatedContact.avatarId = avatar.id
            }) { (err) in
                self.handleErrorMessage?(err)
                completion(false)
                return
            }
        }
  
        updatedContact.fullName = name
        updatedContact.phone = phone
        updatedContact.addressPrimary = address
        updatedContact.addressOther = address
        updatedContact.noteInfo = note
        updatedContact.mode = 1 // Add new.
        updatedContact.isDelete = false

        updatedContact.save(success: {
            completion(true)
        }) { (err) in
            completion(false)
        }
    }

    private func fetchContact() -> CoreContact? {
        var response: CoreContact? = nil
        CoreContact.all(predicate: NSPredicate(format: "id in %@", [contact.id]), success: { results in
            guard let results: [CoreContact] = results as? [CoreContact] else {
                return
            }
            guard let record: CoreContact = results.first(where: { self.contact.id.elementsEqual($0.id) }) else {
                return
            }
            response = record
        }, fail: { _ in })
        return response
    }
}
