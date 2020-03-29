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
}

extension OrderJuiceViewModel {
    func fetchCategoriesType() -> [[String]] {
        let juiceType: [String] = ["Cam", "Dưa"]
        return [juiceType]
    }

    func fetchCategoriesUnit() -> [[String]] {
        let juiceUnit: [String] = ["Quả"]
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
}

// MARK: Internal method.
extension OrderJuiceViewModel {
    
}
