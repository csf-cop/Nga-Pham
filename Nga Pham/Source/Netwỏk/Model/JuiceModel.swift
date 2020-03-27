//
//  JuiceModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/25/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

final class JuiceModel {
    var juice: CoreJuice
    var avatar: CoreImage?
    var morePhotos: [CoreImage]

    init(juice: CoreJuice, photo: CoreImage?, morePhotos: [CoreImage] = []) {
        self.juice = juice
        avatar = photo
        self.morePhotos = morePhotos
    }
}
