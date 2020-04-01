//
//  JuiceDetailViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

final class JuiceDetailViewModel {
    
    private let id: String
    var juiceName: String
    var juiceDescription: String
    var photo: Data?

    init(id: String = "", name: String = "", description: String = "", image: Data? = nil) {
        self.id = id
        self.juiceName = name
        self.juiceDescription = description
        self.photo = image
    }
}
