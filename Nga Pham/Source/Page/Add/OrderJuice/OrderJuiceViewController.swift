//
//  OrderJuiceViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

final class OrderJuiceViewController: UIViewController {


    @IBOutlet private weak var juiceTypePickup: PickerViewTextField!
    @IBOutlet private weak var juiceUnitPickup: PickerViewTextField!
    @IBOutlet private weak var juiceTypeLabel: UILabel!
    @IBOutlet private weak var juiceUnitLabel: UILabel!

    var viewModel: OrderJuiceViewModel = OrderJuiceViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Đặt trái cây"
        loadData()
    }

    @IBAction func showMoreImages(_ sender: UIButton) {
    }

    @IBAction func addImagesTouchUpInside(_ sender: UIButton) {
    }

    @IBAction func orderTouchUpInside(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension OrderJuiceViewController {
    private func loadData() {
        juiceTypePickup.delegateTextFieldPicker = self
        juiceTypePickup.delegate = self
        juiceTypePickup.updateData(datas: viewModel.fetchCategoriesType(), selectedDatas: [])
        juiceUnitPickup.delegateTextFieldPicker = self
        juiceUnitPickup.delegate = self
        juiceUnitPickup.updateData(datas: viewModel.fetchCategoriesUnit(), selectedDatas: [])
    }
}

// MARK: - UITextFieldDelegate
extension OrderJuiceViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension OrderJuiceViewController: PickerViewTextFieldDelegate {
    func view(_ view: PickerViewTextField, needsPerformActions action: Action<[String]>) {
        switch action {
        case .send(let values) where view == juiceTypePickup:
            juiceTypeLabel.text = values.first
        case .send(let values) where view == juiceUnitPickup:
            juiceUnitLabel.text = values.first
        default: break
        }
    }
}
