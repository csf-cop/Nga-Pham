//
//  ItemCollectionViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import UIKit

final class ItemCollectionViewModel {
    private var juicesCollection: [CoreJuice] = []
}

extension ItemCollectionViewModel {
    func numberOfRowsInSection() -> Int {
        return 10
    }

    func viewModelForItemCollectionCell(at: IndexPath) -> ItemCollectionCellModel {
        return ItemCollectionCellModel(data: juicesCollection[safe: at.row].unwrapped(or: CoreJuice()))
    }

    func modelCellDetail(at: IndexPath) -> JuiceDetailViewModel {
        return JuiceDetailViewModel(data: juicesCollection[safe: at.row].unwrapped(or: CoreJuice()))
    }
}
