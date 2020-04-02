//
//  OrderJuiceViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import TLPhotoPicker
import CoreData

final class OrderJuiceViewModel: BaseViewModel {
    var uploadableImages: [UIImage] = []
    private var juiceTypes: [[String]] = []
    var juicesName: [[String]] {
        return juiceTypes
    }
    private var orderJuice: OrderModel
    var mode: App.Mode

    init(order: OrderModel = OrderModel(), mode: App.Mode = .detail) {
        self.orderJuice = order
        self.mode = mode
    }
}

extension OrderJuiceViewModel {
    func fetchCategoriesType(completion: @escaping Completed) {
        CoreJuice.all(predicate: nil, success: { result in
            guard let result: [CoreJuice] = result as? [CoreJuice] else {
                return
            }
            self.juiceTypes = [result.filter({ $0.juiceName.isEmpty == false }).map { $0.juiceName }.removeDuplicates()]
            completion(true)
        }) { (err) in
            self.handleErrorMessage?(err)
            completion(false)
        }
    }

    func fetchCategoriesUnit() -> [[String]] {
        let juiceUnit: [String] = ["Quả", "Kg", "Ly", "Cốc", "Thùng"]
        return [juiceUnit]
    }

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

    func addOrderJuice(name: String, unit: String, withName: String?, phone: String, address: String, note: String?, isSave: Bool, completion: @escaping Completed) {
        if mode == .add {
            guard let context: NSManagedObjectContext = self.context else { return }
            let order: CoreOrder = CoreOrder(context: context)
            order.id = App.getNextImageKey(type: .order)
            order.juiceName = name
            order.juiceType = unit
            order.contactName = withName
            order.phone = phone
            order.contactAddress = address
            order.orderNote = note
            order.mode = 1 // Add new.
            order.isDelete = false

            order.save(success: {
                completion(true)
            }) { (err) in
                self.handleErrorMessage?(err)
                completion(false)
                return
            }
        } else if mode == .edit {
            // MARK: Edit information.
        }

        // MARK: Call to API.
    }
}

// MARK: Internal method.
extension OrderJuiceViewModel {
    
}
