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
        return JuiceCollectionViewModel(model: juices[safe: at.row].unwrapped(or: JuiceModel(juice: CoreJuice(), photo: nil)))
    }

    func modelCellDetail(at: IndexPath) -> JuiceDetailViewModel {
        return JuiceDetailViewModel(model: juices[safe: at.row].unwrapped(or: JuiceModel(juice: CoreJuice(), photo: nil)))
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
            data.forEach { contact in
                let model: JuiceModel = JuiceModel(juice: contact, photo: photos.first(where: {$0.id.elementsEqual(contact.juicePhotoId.unwrapped(or: ""))}))
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
