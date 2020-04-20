//
//  ContactModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/25/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

struct ContactModel: Codable {
    var id: String = ""
    var externalId: String = ""
    var fullName: String = ""
    var avatarId: String = ""
    var image: Data?
    var addressMap: String = ""
    var address: String = ""
    var phone: String = ""
    var noteInfo: String = ""
    var isDelete: Bool = false

    init() { }

    init(core: CoreContact) {
        id = core.id
        externalId = core.externalId.unwrapped(or: "")
        fullName = core.fullName
        avatarId = core.avatarId.unwrapped(or: "")
        addressMap = core.addressMap.unwrapped(or: "")
        address = core.addressPrimary.unwrapped(or: "")
        phone = core.phone.unwrapped(or: "")
        noteInfo = core.noteInfo.unwrapped(or: "")
        isDelete = core.isDelete
    }

    init(from decoder: Decoder) throws {
        id = try decoder.decodeIfPresent("id").unwrapped(or: "")
        externalId = try decoder.decodeIfPresent("external_id").unwrapped(or: "")
        fullName = try decoder.decodeIfPresent("full_name").unwrapped(or: "")
        avatarId = try decoder.decodeIfPresent("avatar_id").unwrapped(or: "")
        addressMap = try decoder.decodeIfPresent("address_map").unwrapped(or: "")
        address = try decoder.decodeIfPresent("address").unwrapped(or: "")
        phone = try decoder.decodeIfPresent("phone").unwrapped(or: "")
        noteInfo = try decoder.decodeIfPresent("note_info").unwrapped(or: "")
        isDelete = try decoder.decodeIfPresent("is_delete").unwrapped(or: false)
    }
}
