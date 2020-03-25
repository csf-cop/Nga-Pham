//
//  PickerViewTextField.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

protocol PickerViewTextFieldDelegate: class {
    func view(_ view: PickerViewTextField, needsPerformActions action: Action<[String]>)
}

final class PickerViewTextField: NoActionTextField {

    private let pickerView: UIPickerView = UIPickerView()
    private let toolBar = Toolbar(frame: NumberPickerViewTextField.Config.frameToolBar)
    private var datas: [[String]] = []
    private var selectedDatas: [String] = []
    weak var delegateTextFieldPicker: PickerViewTextFieldDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        configPickerView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configView()
        configPickerView()
    }

    func updateData(datas: [[String]], selectedDatas: [String] = []) {
        self.datas = datas
        self.selectedDatas = selectedDatas
    }
}

// MARK: - Config View
extension PickerViewTextField {

    private func configView() {
        addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
    }

    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        for component in 0..<numberOfComponents() {
            if let row = selectedRow(forComponent: component) {
                pickerView.selectRow(row, inComponent: component, animated: false)
            }
        }
    }

    private func configPickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .blue
        toolBar.configureUI()
        toolBar.doneAction = { [weak self] in
            guard let this = self else { return }
            for component in 0..<this.numberOfComponents() {
                let row = this.pickerView.selectedRow(inComponent: component)
                this.didSelectRow(forComponent: component, row: row)
            }
            this.text = this.getTextDisplay()
            this.delegateTextFieldPicker?.view(this, needsPerformActions: .send(this.selectedDatas))
            this.endEditing(true)
        }
        toolBar.cancelAction = { [weak self] in
            guard let this = self else { return }
            this.delegateTextFieldPicker?.view(this, needsPerformActions: .cancel)
            this.endEditing(true)
        }
        inputView = pickerView
        inputAccessoryView = toolBar
    }
}

// MARK: - Config Data
extension PickerViewTextField {

    func numberOfComponents() -> Int {
        return datas.count
    }

    func numberOfRowsInComponent(forComponent component: Int) -> Int {
        return (datas[safe: component]?.count).unwrapped(or: 0)
    }

    func titleForRow(forComponent component: Int, row: Int) -> String? {
        let items = datas[safe: component]
        let item = items?[safe: row]
        return item
    }

    func selectedRow(forComponent component: Int) -> Int? {
        guard let items = datas[safe: component],
            let selectedItem = selectedDatas[safe: component] else { return nil }
        return items.firstIndex(of: selectedItem)
    }

    func didSelectRow(forComponent component: Int, row: Int) {
        if let items = datas[safe: component], let item = items[safe: row] {
            if selectedDatas[safe: component] == nil {
                selectedDatas.append(item)
            } else {
                selectedDatas[component] = item
            }
        }
    }

    func getTextDisplay() -> String? {
        return selectedDatas.joined(separator: " ")
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension PickerViewTextField: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents()
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRowsInComponent(forComponent: component)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titleForRow(forComponent: component, row: row)
    }
}

