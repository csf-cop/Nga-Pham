//
//  NumberPickerViewTextField.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

protocol NumberPickerViewTextFieldDelegate: class {
    func view(_ view: NumberPickerViewTextField, needsPerformActions action: Action<Double?>)
}

class NumberPickerViewTextField: TextField {

    private let pickerView = UIPickerView()
    private let toolBar = Toolbar(frame: Config.frameToolBar)
    weak var delegateTextFieldPicker: NumberPickerViewTextFieldDelegate?

    private var min: Double = 0
    private var max: Double = 0
    private var intergers: [Int] = []
    private var fractionDigits: [Int] = Config.fractionDigits
    private var numberFractionDigit: Int = 0
    private var defaultValue: Double = 0
    private var value: Double?

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

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }

    func updateData(min: Double, max: Double, numberFractionDigit: Int, value: Double?, defaultValue: Double) {
        self.min = min
        self.max = max
        self.numberFractionDigit = numberFractionDigit
        self.value = value
        self.defaultValue = defaultValue
        intergers = Array(Int(min)...Int(max))
    }
}

// MARK: - Config View
extension NumberPickerViewTextField {

    private func configView() {
        addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
    }

    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.selectRow(intergerSelectedIndex(),
                             inComponent: Config.firstComponent,
                             animated: false)

        if numberFractionDigit != 0 {
            for i in 1...numberFractionDigit {
                pickerView.selectRow(fractionSelectedIndex(value: value, indexFraction: i),
                                     inComponent: i,
                                     animated: false)
            }
        }
    }

    private func configPickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .black
        toolBar.configureUI()
        toolBar.doneAction = { [weak self] in
            guard let this = self else { return }
            this.value = this.getValueCurrent()
            this.text = String(double: this.value)
            this.delegateTextFieldPicker?.view(this, needsPerformActions: .send(this.value))
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
extension NumberPickerViewTextField {
    func numberOfComponents() -> Int {
        return numberFractionDigit + 1
    }

    func numberOfRowsInComponent(component: Int) -> Int {
        if component == Config.firstComponent {
            return intergers.count
        } else {
            return Config.loopIndex
        }
    }

    func titleForRow(row: Int, component: Int) -> String? {
        if component == Config.firstComponent {
            if let number = intergers[safe: row] {
                return "\(number)"
            }
            return nil
        } else {
            let index = row % fractionDigits.count
            if let number = fractionDigits[safe: index] {
                return component == Config.firstComponentFractionDigits ? ".\(number)" : "\(number)"
            }
            return nil
        }
    }

    func intergerSelectedIndex() -> Int {
        var number: Double = defaultValue
        if let value = self.value {
            number = value
        }
        let intergerNumber = Int(floor(number))
        if let row = intergers.firstIndex(of: intergerNumber) {
            return row
        } else {
            return 0
        }
    }

    func fractionSelectedIndex(value: Double?, indexFraction: Int) -> Int {
        let number: Double = value.unwrapped(or: defaultValue)
        var num: Int = 0
        if (min...max).contains(number) {
            let fractionNumber: Double = (number.truncatingRemainder(dividingBy: 1) * pow(10, Double(numberFractionDigit))).rounded()
            let arrNumStr: [String] = String(Int(fractionNumber)).map { String($0) }
            if let numStr: String = arrNumStr[safe: indexFraction - 1] {
                num = Int(numStr).unwrapped(or: 0)
            } else {
                num = 0
            }
        }
        var rowLoop: Int = Config.loopIndex / 2
        let indexRowLoop: Int = rowLoop % fractionDigits.count
        let numericalDifference: Int = num - indexRowLoop
        rowLoop += numericalDifference
        return rowLoop
    }

    func getValueCurrent() -> Double? {
        var intergerValue: Double?
        var fractionValue: Double = 0
        let rowInterger = pickerView.selectedRow(inComponent: Config.firstComponent)
        if let interger = intergers[safe: rowInterger] {
            intergerValue = Double(interger)
        }

        if numberFractionDigit != 0 {
            for com in 1...numberFractionDigit {
                let rowFraction = pickerView.selectedRow(inComponent: com)
                let index = rowFraction % fractionDigits.count
                if let fraction = fractionDigits[safe: index] {
                    fractionValue += Double(fraction) / pow(10, Double(com))
                }
            }
        }
        if let intergerValue = intergerValue {
            return intergerValue + fractionValue
        } else {
            return value
        }
    }

    func compareFractionDigitAt(index: Int, lhs: Double, rhs: Double) -> Bool {
        let leftValue = lhs * 10 * Double(index)
        let rightValue = rhs * 10 * Double(index)
        return leftValue > rightValue
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension NumberPickerViewTextField: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return Config.heightComponent
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if numberFractionDigit > 1 {
            if component == Config.firstComponent {
                return Config.intergerWidth
            } else {
                return Config.fractionDigitsWidth
            }
        } else {
            return Config.intergerWidth
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents()
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRowsInComponent(component: component)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titleForRow(row: row, component: component)
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = titleForRow(row: row, component: component)
        label.font = Config.labelFont
        if component == Config.firstComponent {
            if numberFractionDigit == 0 {
                label.textAlignment = .center
            } else {
                label.textAlignment = .right
            }
        } else {
            label.textAlignment = .left
        }
        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let firstComponent = Config.firstComponent
        let intergerSeletedRow = pickerView.selectedRow(inComponent: firstComponent)
        let numberOfRows = numberOfRowsInComponent(component: firstComponent) - 1
        if intergerSeletedRow == numberOfRows,
            numberFractionDigit != 0 {
            for com in 1...numberFractionDigit {
                if let valueCurrent = getValueCurrent(),
                    compareFractionDigitAt(index: com, lhs: valueCurrent, rhs: max) {
                    let resetRow = fractionSelectedIndex(value: max, indexFraction: com)
                    pickerView.selectRow(resetRow, inComponent: com, animated: false)
                }
            }
        }
    }
}

// MARK: - Config
extension NumberPickerViewTextField {
    struct Config {
        static let firstComponent: Int = 0
        static let firstComponentFractionDigits: Int = 1
        static let loopIndex: Int = 10_000
        static let fractionDigits: [Int] = Array(0...9)

        static let intergerWidth: CGFloat = 55
        static let fractionDigitsWidth: CGFloat = 22
        static let heightComponent: CGFloat = 40
        static let numberOfComponent: Int = 1
        static let labelFont: UIFont = .systemFont(ofSize: 22, weight: .regular)
        static let frameToolBar: CGRect = CGRect(x: 0.0,
                                                 y: 0.0,
                                                 width: kScreenSize.width,
                                                 height: 44.0)
    }
}
