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
    private var orderModel: [OrderModel] = []
}

extension ItemCollectionViewModel {
    func numberOfRowsInSection() -> Int {
        return orderModel.count
    }

    func viewModelForItemCollectionCell(at: IndexPath) -> ItemCollectionCellModel {
        let order: OrderModel = orderModel[safe: at.row].unwrapped(or: OrderModel())
        return ItemCollectionCellModel(description: order.contactAddress)
    }

    func modelCellDetail(at: IndexPath) -> OrderJuiceViewModel {
        let model: OrderModel = orderModel[safe: at.row].unwrapped(or: OrderModel())
        return OrderJuiceViewModel(order: model, mode: .detail)
    }

    func loadOrdersData(completion: @escaping Completed) {
        CoreOrder.all(predicate: nil, success: { result in
            guard let result: [CoreOrder] = result as? [CoreOrder] else {
                return
            }
            result.forEach { order in
                self.orderModel.append(OrderModel(core: order))
            }
            completion(true)
        }) { (err) in
            self.handleErrorMessage?(err)
            completion(false)
        }
    }
}
