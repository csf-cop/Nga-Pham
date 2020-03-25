//
//  TextField.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

class TextField: UITextField {

    var textChanged: (String) -> Void = { _ in }
    private var _maxLengths: [UITextField: Int] = [UITextField: Int]()

    func bind(callback: @escaping (String) -> Void) {

        textChanged = callback
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        textChanged(textField.text.unwrapped(or: ""))
    }

    @IBInspectable var placeHolderColor: UIColor? {
        didSet {
            self.attributedPlaceholder = NSAttributedString(
            string: self.placeholder.unwrapped(or: ""),
            attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor.unwrapped(or: .gray)])
        }
    }

    @IBInspectable var maxLength: Int {
        get {
            guard let length: Int = _maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return length
        }
        set {
            _maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }

    @objc func fix(textField: UITextField) {
        if let text: String = textField.text {
            textField.text = String(text.prefix(maxLength))
        }
    }
}
