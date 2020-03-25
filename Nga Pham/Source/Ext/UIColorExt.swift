//
//  UIColorExt.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

extension UIColor {
    var hexString: String {
        if let components: [CGFloat] = self.cgColor.components, components.count > 2 {
            let red: CGFloat = components[0]
            let green: CGFloat = components[1]
            let blue: CGFloat = components[2]
            return String(format: "%02X%02X%02X", (Int)(red * 255), (Int)(green * 255), (Int)(blue * 255))
        }
        return "000000"
    }
}
