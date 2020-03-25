//
//  JuiceCollectionViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import UIKit.UIImage

final class JuiceCollectionViewModel {
    let juiceDescription: String
    let juiceImage: [CoreImage]

    init(model: CoreJuice) {
        juiceDescription = model.juiceDescription
        juiceImage = (model.re_Image as? [CoreImage]).unwrapped(or: [])
    }
}
