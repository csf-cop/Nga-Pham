//
//  AddContactViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import TLPhotoPicker
import CoreData

final class AddContactViewModel: BaseViewModel {
    var uploadableImages: [UIImage] = []

    var images: [UIImage] {
        return uploadableImages
    }
}

extension AddContactViewModel {
    func getSelectedImage(selectedAssets: [TLPHAsset]) {
        uploadableImages = []
        selectedAssets.forEach { asset in
            if let image: UIImage = asset.fullResolutionImage {
                uploadableImages.append(image)
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

        let contact: CoreContact = CoreContact(context: context)
        contact.id =  App.getNextImageKey(type: .contact)
        contact.avatarId = imageId
        contact.fullName = name
        contact.phone = phone
        contact.addressPrimary = address
        contact.addressOther = address
        contact.noteInfo = note
        contact.isDelete = false

        contact.save(success: {
            completion(true)
        }) { (err) in
            completion(false)
        }
    }
}
