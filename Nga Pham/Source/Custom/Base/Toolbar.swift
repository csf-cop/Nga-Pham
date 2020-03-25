//
//  Toolbar.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

class Toolbar: UIToolbar {

    var doneAction: () -> Void = { }
    var cancelAction: () -> Void = { }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configureUI() {
        tintColor = .white
        barTintColor = .systemPink
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done",
                                                          style: .done,
                                                          target: self,
                                                          action: #selector(handleDoneButton))
        let spaceButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                           target: nil,
                                                           action: nil)
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(handleCancelButton))
        setItems([cancelButton, spaceButton, doneButton], animated: false)
    }

    @objc private func handleDoneButton() {
        doneAction()
    }

    @objc private func handleCancelButton() {
        cancelAction()
    }
}

