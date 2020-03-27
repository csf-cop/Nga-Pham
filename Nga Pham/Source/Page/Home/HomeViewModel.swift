//
//  HomeViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import UIKit

final class HomeViewModel {
    private var juices: [JuiceModel] = []
}

// MARK: For UITableView
extension HomeViewModel {
    func numberOfItemsInSection() -> Int {
        return juices.count
    }

    func modelForCell(at: IndexPath) -> JuiceCollectionViewModel {
//        JuiceCollectionViewModel
//        return JuiceCollectionViewModel(model: JuiceModel(juice: juices[safe: at.row].unwrapped(or: CoreJuice())), photo: nil, morePhotos: [])
        return JuiceCollectionViewModel(model: JuiceModel(juice: CoreJuice(), photo: nil))
    }

    func modelCellDetail(at: IndexPath) -> JuiceDetailViewModel {
        return JuiceDetailViewModel(model: juices[safe: at.row].unwrapped(or: JuiceModel(juice: CoreJuice(), photo: nil)))
    }
}
