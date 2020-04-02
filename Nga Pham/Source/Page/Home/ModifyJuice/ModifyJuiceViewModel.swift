//
//  ModifyJuiceViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import TLPhotoPicker
//import Photos
import CoreData

final class ModifyJuiceViewModel: BaseViewModel {
    let juice: JuiceModel
    let mode: App.Mode

    var juiceImage: [UIImage] = []
    var uploadableImages: [UIImage] = []
    
    private var changeImage: Bool = false
    private var changeMorePhotos: Bool = false
    init(model: JuiceModel = JuiceModel(), mode: App.Mode = .add) {
        self.juice = model
        self.mode = mode
    }
}

extension ModifyJuiceViewModel {
    func getSelectedImage(isJuiceImage: Bool = true, selectedAssets: [TLPHAsset]) {
        uploadableImages = []
        selectedAssets.forEach { asset in
            if let image: UIImage = asset.fullResolutionImage {
                if isJuiceImage {
                    juiceImage.append(image)
                    changeImage = true
                } else {
                    uploadableImages.append(image)
                    changeMorePhotos = true
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

    func modifyJuice(name: String, description: String, unit: String, completion: @escaping Completed) {
        if mode == .add {
            return addJuice(name: name, description: description, unit: unit, completion: completion)
        } else {
            return updateJuice(name: name, description: description, unit: unit, completion: completion)
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
        juice.mode = 1 // Add new.
        juice.isDelete = false
        if nextPhotoId.isEmpty == false {
            juice.juicePhotoId = nextPhotoId
        }
        if changeMorePhotos {
            juice.juiceMorePhotos = !photosId.isEmpty ? photosId.joined(separator: ",") : nil
        }
        juice.save(success: {
            completion(true)
        }) { (err) in
            self.handleErrorMessage?(err)
            completion(false)
            return
        }
    }

    func updateJuice(name: String, description: String, unit: String, completion: @escaping Completed) {
        guard let context: NSManagedObjectContext = self.context else { return }
        guard let updatedJuice: CoreJuice = fetchJuice() else {
            self.handleErrorMessage?(NSError(message: "Không tìm thấy hoa quả số (\(self.juice.id))"))
            completion(false)
            return
        }

        if juiceImage.isEmpty == false && changeImage {
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
                updatedJuice.juicePhotoId = avatar.id
            }) { (err) in
                self.handleErrorMessage?(err)
                completion(false)
                return
            }
        }

        var photosId: [String] = []
        if changeMorePhotos {
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
        }

        updatedJuice.juiceName = name
        updatedJuice.juiceDescription = description
        updatedJuice.mode = 1 // Add new.
        updatedJuice.isDelete = false
        if !photosId.isEmpty {
            updatedJuice.juiceMorePhotos = photosId.joined(separator: ",")
        }
        updatedJuice.save(success: {
            completion(true)
        }) { (err) in
            self.handleErrorMessage?(err)
            completion(false)
            return
        }
    }

    func deleteJuice(completion: @escaping Completed) {
        guard let record: CoreJuice = fetchJuice() else {
            self.handleErrorMessage?(NSError(message: "Không tìm thấy danh bạ số (\(self.juice.id))"))
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

    func takePhoto(image: UIImage) {
        juiceImage = [image]
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    private func fetchJuice() -> CoreJuice? {
        var response: CoreJuice? = nil
        CoreJuice.all(predicate: NSPredicate(format: "id in %@", [juice.id]), success: { results in
            guard let results: [CoreJuice] = results as? [CoreJuice] else {
                return
            }
            guard let record: CoreJuice = results.first(where: { self.juice.id.elementsEqual($0.id) }) else {
                return
            }
            response = record
        }, fail: { _ in })
        return response
    }
}
