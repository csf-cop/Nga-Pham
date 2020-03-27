//
//  ItemCollectionViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import UIKit

final class ItemCollectionViewModel: BaseViewModel {
    private var juicesModel: [JuiceModel] = []
}

extension ItemCollectionViewModel {
    func numberOfRowsInSection() -> Int {
        return juicesModel.count
    }

    func viewModelForItemCollectionCell(at: IndexPath) -> ItemCollectionCellModel {
        let juice: JuiceModel = juicesModel[safe: at.row].unwrapped(or: JuiceModel(juice: CoreJuice(), photo: nil))
        return ItemCollectionCellModel(model: juice)
    }

    func modelCellDetail(at: IndexPath) -> JuiceDetailViewModel {
        return JuiceDetailViewModel(model: juicesModel[safe: at.row].unwrapped(or: JuiceModel(juice: CoreJuice(), photo: nil)))
    }
}
