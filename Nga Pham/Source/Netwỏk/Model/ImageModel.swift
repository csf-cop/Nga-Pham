//
//  ImageModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 4/1/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

struct ImageModel: Codable {
    var id: String = ""
    var externalId: String = ""
    var imageUrl: String = ""
    var imageData: Data?
    var imageDateCreate: Date?
    var imageFileSize: Float = 0
    var imageIndex: Int = 0
    var imageName: String = ""
    var imageTypeFor: Int = 0
    var isDelete: Bool = false

    init() { }

    init(core: CoreImage) {
        self.id = core.id
        self.externalId = core.externalId.unwrapped(or: "")
        self.imageData = core.imageData
        self.imageDateCreate = core.imageDateCreate
        self.imageFileSize = core.imageFileSize
        self.imageIndex = Int(core.imageIndex)
        self.imageName = core.imageName.unwrapped(or: "")
        self.imageTypeFor = Int(core.imageTypeFor)
        self.isDelete = core.isDelete
    }
    
    init(from decoder: Decoder) throws {
        id = try decoder.decodeIfPresent("id").unwrapped(or: "")
        externalId = try decoder.decodeIfPresent("external_id").unwrapped(or: "")
        imageUrl = try decoder.decodeIfPresent("image_url").unwrapped(or: "")
        imageDateCreate = try? decoder.decodeIfPresent("date_create")
        imageFileSize = try decoder.decodeIfPresent("file_size").unwrapped(or: 0)
        imageIndex = try decoder.decodeIfPresent("image_index").unwrapped(or: 0)
        imageName = try decoder.decodeIfPresent("image_name").unwrapped(or: "")
        imageTypeFor = try decoder.decodeIfPresent("image_type_for").unwrapped(or: 0)
        isDelete = try decoder.decodeIfPresent("is_delete").unwrapped(or: false)
    }
}
