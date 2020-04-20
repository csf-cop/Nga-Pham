//
//  OrderModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 4/1/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

struct OrderModel: Codable {
    var id: String = ""
    var externalId: String = ""
    var contactAddress: String = ""
    var contactName: String = ""
    var juiceName: String = ""
    var juiceType: String = ""
    var orderNote: String = ""
    var phone: String = ""

    init() { }

    init(core: CoreOrder) {
        id = core.id
        externalId = core.externalId.unwrapped(or: "")
        contactAddress = core.contactAddress.unwrapped(or: "")
        contactName = core.contactName.unwrapped(or: "")
        juiceName = core.juiceName
        juiceType = core.juiceType.unwrapped(or: "")
        orderNote = core.orderNote.unwrapped(or: "")
        phone = core.phone.unwrapped(or: "")
    }

    init(from decoder: Decoder) throws {
        id = try decoder.decodeIfPresent("id").unwrapped(or: "")
        externalId = try decoder.decodeIfPresent("ext_id").unwrapped(or: "")
        contactAddress = try decoder.decodeIfPresent("contact_address").unwrapped(or: "")
        contactName = try decoder.decodeIfPresent("contact_name").unwrapped(or: "")
        juiceName = try decoder.decodeIfPresent("juice_name").unwrapped(or: "")
        juiceType = try decoder.decodeIfPresent("juice_type").unwrapped(or: "")
        orderNote = try decoder.decodeIfPresent("order_note").unwrapped(or: "")
        phone = try decoder.decodeIfPresent("phone").unwrapped(or: "")
    }
}
