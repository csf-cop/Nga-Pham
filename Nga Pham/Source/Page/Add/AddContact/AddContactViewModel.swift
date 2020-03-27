//
//  AddContactViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import TLPhotoPicker
import CoreData

final class AddContactViewModel: BaseViewModel {
    private var uploadableImages: [UIImage] = []

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
                print("Can't get image at local storage, try download image")
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
        let avatar: CoreImage = CoreImage(context: context)
        let contact: CoreContact = CoreContact(context: context)
        
        if !uploadableImages.isEmpty {
            avatar.setValue(imageId, forKey: "id")
            let picture: UIImage = uploadableImages[0]
            avatar.setValue(picture.toData(), forKey: "imageData")
            avatar.setValue(picture.sizeInMB, forKey: "imageFileSize")
            avatar.setValue(Date().string(withFormat: FormatType.fullTimeSecond), forKey: "imageName")
            avatar.setValue(1, forKey: "imageTypeFor")
            avatar.setValue(Date(), forKey: "imageDateCreate")

            avatar.save(success: {
                contact.setValue(App.getNextImageKey(type: .contact), forKey: "id")
                contact.setValue(name, forKey: "fullName")
                contact.setValue(phone, forKey: "phone")
                contact.setValue(address, forKey: "addressPrimary")
                contact.setValue(address, forKey: "addressOther")
                contact.setValue(note, forKey: "noteInfo")
                contact.avatarId = imageId

                contact.save(success: {
                    completion(true)
                }) { (err) in
                    completion(false)
                }
            }) { (err) in
                self.handleErrorMessage?(err)
                completion(false)
            }
        }
    }
}
