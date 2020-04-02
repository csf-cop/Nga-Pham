//
//  UIImageExt.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/21/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

extension UIImage {

    static let extraSmall = image(fromFile: "extra-small")
    static let small = image(fromFile: "small")
    static let medium = image(fromFile: "medium")
    static let large = image(fromFile: "large")
    static let extraLarge = image(fromFile: "extra-large")

    func toData() -> Data? {
        return pngData()
    }
    
    var sizeInBytes: Int {
        if let data = toData() {
            return data.count
        } else {
            return 0
        }
    }
    
    var sizeInMB: Float {
        return Float(sizeInBytes) / 1_000_000
    }

    private static func image(fromFile name: String) -> UIImage {
        if let path = Bundle.main.path(forResource: name, ofType: "png"),
            let image = UIImage(contentsOfFile: path) {
            return image
        }
        fatalError("Programmer error if image is missing.")
    }
    
    static func fromColor(_ color: UIColor, size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
