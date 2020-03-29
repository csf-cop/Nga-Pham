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
    private var orderModel: [CoreOrder] = []
}

extension ItemCollectionViewModel {
    func numberOfRowsInSection() -> Int {
        return orderModel.count
    }

    func viewModelForItemCollectionCell(at: IndexPath) -> ItemCollectionCellModel {
        let order: CoreOrder = orderModel[safe: at.row].unwrapped(or: CoreOrder())
        return ItemCollectionCellModel(model: order)
    }

    func modelCellDetail(at: IndexPath) -> OrderJuiceViewModel {
        let order: CoreOrder = orderModel[safe: at.row].unwrapped(or: CoreOrder())
        return OrderJuiceViewModel(order: order)
    }

    func loadOrdersData(completion: @escaping Completed) {
        CoreOrder.all(predicate: nil, success: { result in
            guard let result: [CoreOrder] = result as? [CoreOrder] else {
                return
            }
            self.orderModel = result
            completion(true)
        }) { (err) in
            self.handleErrorMessage?(err)
            completion(false)
        }
    }
}
