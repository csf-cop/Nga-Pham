//
//  AddJuiceViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import TLPhotoPicker
//import Photos
import CoreData

final class AddJuiceViewModel: BaseViewModel {
    var juiceImage: [UIImage] = []
    var uploadableImages: [UIImage] = []
}

extension AddJuiceViewModel {
    func getSelectedImage(isJuiceImage: Bool = true, selectedAssets: [TLPHAsset]) {
        uploadableImages = []
        selectedAssets.forEach { asset in
            if let image: UIImage = asset.fullResolutionImage {
                if isJuiceImage {
                    juiceImage.append(image)
                } else {
                    uploadableImages.append(image)
                }
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

    func addJuice(name: String, description: String, unit: String, completion: @escaping Completed) {
        guard let context: NSManagedObjectContext = self.context else { return }

        var nextPhotoId: String = ""
        if juiceImage.isEmpty == false {
            let avatar: CoreImage = CoreImage(context: context)
            avatar.id = App.getNextImageKey(type: .image)
            if juiceImage.isEmpty == false {
                avatar.imageData = juiceImage[0].toData()
            }
            avatar.imageFileSize = Float(juiceImage[0].sizeInMB)
            avatar.imageTypeFor = 1
            avatar.imageIndex = 0
            avatar.isDelete = false
            avatar.save(success: {
                nextPhotoId = avatar.id
            }) { (err) in
                self.handleErrorMessage?(err)
                completion(false)
                return
            }
        }

        var photosId: [String] = []
        for index in 0..<uploadableImages.count {
            let image: CoreImage = CoreImage(context: context)
            image.id = App.getNextImageKey(type: .image)
            image.imageData = uploadableImages[index].toData()
            image.imageFileSize = Float(uploadableImages[index].sizeInMB)
            image.imageTypeFor = 1
            image.imageIndex = Int16(index)
            image.isDelete = false
            image.save(success: {
                photosId.append(image.id)
            }) { (err) in
                self.handleErrorMessage?(err)
                completion(false)
                return
            }
        }

        let juice: CoreJuice = CoreJuice(context: context)
        juice.id = App.getNextImageKey(type: .juice)
        juice.juiceName = name
        juice.juiceDescription = description
        juice.isDelete = false
        if nextPhotoId.isEmpty == false {
            juice.juicePhotoId = nextPhotoId
        }
        if !photosId.isEmpty {
            juice.juiceMorePhotos = try? JSONSerialization.data(withJSONObject: photosId, options: [])
        }
        juice.save(success: {
            completion(true)
        }) { (err) in
            self.handleErrorMessage?(err)
            completion(false)
            return
        }
    }

    func takePhoto(image: UIImage) {
        juiceImage = [image]
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
