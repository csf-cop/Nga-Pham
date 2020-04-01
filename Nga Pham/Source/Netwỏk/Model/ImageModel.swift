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
    var imageData: String = ""
    var imageDateCreate: Date?
    var imageFileSize: Float = 0
    var imageIndex: Int = 0
    var imageName: String = ""
    var imageTypeFor: Int = 0
    var isDelete: Bool = false

    init(from decoder: Decoder) throws {
        id = try decoder.decodeIfPresent("id").unwrapped(or: "")
        externalId = try decoder.decodeIfPresent("external_id").unwrapped(or: "")
        imageData = try decoder.decodeIfPresent("full_name").unwrapped(or: "")
        imageDateCreate = try? decoder.decodeIfPresent("avatar_id")
        imageFileSize = try decoder.decodeIfPresent("image_file_size").unwrapped(or: 0)
        imageIndex = try decoder.decodeIfPresent("image_index").unwrapped(or: 0)
        imageName = try decoder.decodeIfPresent("image_name").unwrapped(or: "")
        imageTypeFor = try decoder.decodeIfPresent("image_type_for").unwrapped(or: 0)
        isDelete = try decoder.decodeIfPresent("is_delete").unwrapped(or: false)
    }
}
