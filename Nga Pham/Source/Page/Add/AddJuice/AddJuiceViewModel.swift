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

    func addJuice(name: String, description: String, unit: String) {
        guard let context: NSManagedObjectContext = self.context else { return }

        var avatar: CoreImage = CoreImage(context: context)
        avatar.id = App.getNextImageKey(type: .image)
        avatar.imageData = juiceImage[0].toData()
        avatar.imageFileSize = Float(juiceImage[0].sizeInMB)
        avatar.imageTypeFor = 1
        avatar.isDelete = false
        avatar.save(success: {
            print("Create user success")
        }) { (err) in
            print("Create user fail: \(err.localizedDescription)")
            return
        }

        var juice: CoreJuice = CoreJuice(context: context)
        juice.id = App.getNextImageKey(type: .juice)
        juice.juiceName = name
        juice.juiceDescription = description
        juice.isDelete = false
        juice.juicePhotoId = avatar.id
//        juice.re_Image = uploadableImages
    }

    func takePhoto(image: UIImage) {
        juiceImage = [image]
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
