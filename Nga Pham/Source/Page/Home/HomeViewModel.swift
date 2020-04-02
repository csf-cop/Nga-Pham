//
//  HomeViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class HomeViewModel: BaseViewModel {
    private var juices: [JuiceModel] = []
}

// MARK: For UITableView
extension HomeViewModel {
    func numberOfItemsInSection() -> Int {
        return juices.count
    }

    func modelForCell(at: IndexPath) -> JuiceCollectionViewModel {
        guard let juice: JuiceModel = juices[safe: at.row] else { return JuiceCollectionViewModel() }
        return JuiceCollectionViewModel(id: juice.id, description: juice.juiceDescription, image: juice.juiceImage)
    }

    func modelCellDetail(at: IndexPath) -> JuiceDetailViewModel {
        guard let juice: JuiceModel = juices[safe: at.row] else { return JuiceDetailViewModel() }
        return JuiceDetailViewModel(id: juice.id, name: juice.juiceName, description: juice.juiceDescription, image: juice.juiceImage)
    }
}

// MARK: Core Data.
extension HomeViewModel {
    func loadContactsData(completion: @escaping Completed) {
        CoreJuice.all(predicate: nil, success: { result in
            guard let result: [CoreJuice] = result as? [CoreJuice] else {
                return
            }
            self.generateModel(data: result)
            completion(true)
        }) { (err) in
            self.handleErrorMessage?(err)
            completion(false)
        }
    }

    private func generateModel(data: [CoreJuice]) {
        if data.isEmpty { return }
        juices = []
        let imageIds: [String] = data.map { $0.juicePhotoId.unwrapped(or: "") }
        CoreImage.all(predicate: NSPredicate(format: "id in %@", imageIds), success: { photos in
            guard let photos: [CoreImage] = photos as? [CoreImage] else {
                return
            }
            data.forEach { juice in
                let image: CoreImage? = photos.first(where: {$0.id.elementsEqual(juice.juicePhotoId.unwrapped(or: ""))})
                var model: JuiceModel = JuiceModel(core: juice)
                model.juiceImage = image?.imageData
                self.juices.append(model)
            }
        }) { (err) in
            print("Fetch fail cmnr: \(err)")
        }
    }
}

// MARK: Internal method.
extension HomeViewModel {
    
}
