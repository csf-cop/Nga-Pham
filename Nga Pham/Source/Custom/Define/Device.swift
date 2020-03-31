//
//  Device.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/31/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

struct Device {
    static var uuid: String {
        let uuidInUserDefault = SecurePreference.shared.string(forKey: SaveKeys.uuid)
        let uuidInKeyChain = SecurePreference.shared.stringInSecure(forKey: SaveKeys.uuid2)

        if uuidInUserDefault.isEmpty && uuidInKeyChain.isEmpty {
            let newUUID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
            SecurePreference.shared.setToSecure(newUUID, forKey: SaveKeys.uuid2)
            SecurePreference.shared.set(newUUID, forKey: SaveKeys.uuid)
        } else if !uuidInUserDefault.isEmpty && uuidInUserDefault != uuidInKeyChain {
            SecurePreference.shared.setToSecure(uuidInUserDefault, forKey: SaveKeys.uuid2)
        }

        return SecurePreference.shared.stringInSecure(forKey: SaveKeys.uuid2)
    }

    static var phoneOS: String {
        let os = ProcessInfo().operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }

    static var modelName: String {
        return UIDevice.modelName
    }

    static var OS: String {
        return "ios"
    }
}
