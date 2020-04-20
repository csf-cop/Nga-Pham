//
//  JuiceModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/25/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

struct JuiceModel: Codable {
    var id: String = ""
    var externalId: String = ""
    var juiceDescription: String = ""
    var juiceName: String = ""
    var juicePhotoId: String = ""
    var juiceImage: Data?
    var juiceMorePhotos: String = ""
    var juicePhotos: [Data?] = []
    var lastUpdate: Date?
    var dateCreate: Date?
    var unitId: String?
    var isDelete: Bool = false

    init() { }

    init(core: CoreJuice) {
        id = core.id
        externalId = core.externalId.unwrapped(or: "")
        juiceDescription = core.juiceDescription.unwrapped(or: "")
        juiceMorePhotos = core.juiceMorePhotos.unwrapped(or: "")
        juiceName = core.juiceName
        juicePhotoId = core.juicePhotoId.unwrapped(or: "")
        lastUpdate = core.lastUpdate
        dateCreate = core.dateCreate
        unitId = core.unitId
        isDelete = core.isDelete
    }

    init(from decoder: Decoder) throws {
        id = try decoder.decodeIfPresent("id").unwrapped(or: "")
        externalId = try decoder.decodeIfPresent("external_id").unwrapped(or: "")
        juiceDescription = try decoder.decodeIfPresent("juice_description").unwrapped(or: "")
        juiceMorePhotos = try decoder.decodeIfPresent("juice_more_photos").unwrapped(or: "")
        juiceName = try decoder.decodeIfPresent("juice_name").unwrapped(or: "")
        juicePhotoId = try decoder.decodeIfPresent("juice_photo_id").unwrapped(or: "")
        lastUpdate = try? decoder.decodeIfPresent("last_update")
        dateCreate = try? decoder.decodeIfPresent("date_create")
        unitId = try? decoder.decodeIfPresent("unit_id")
        isDelete = try decoder.decodeIfPresent("is_delete").unwrapped(or: false)
    }
}
