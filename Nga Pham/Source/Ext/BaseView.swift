//
//  BaseView.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

class BaseView: UIView {

    var isViewLoadNib = false

    override func awakeFromNib() {
        super.awakeFromNib()
        loadNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func loadNib() {

        let bundle = Bundle.main
        var xib: String?
        let name = String(describing: type(of: self))
        if bundle.path(forResource: name, ofType: "nib") != nil {
            xib = name
        }
        if let xib = xib, let view = bundle.loadNibNamed(xib, owner: self)?.first as? UIView {
            view.frame = bounds
            addSubview(view)
            constrainToEdges(view)
        }
        isViewLoadNib = true
    }
}

extension Bundle {
    func hasNib(name: String) -> Bool {
        return path(forResource: name, ofType: "nib") != nil
    }
}
