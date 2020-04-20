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
    let id: String
    let juiceDescription: String
    let juiceImage: Data?

    init(id: String = "", description: String = "", image: Data? = nil) {
        self.id = id
        self.juiceDescription = description
        self.juiceImage = image
    }
}
