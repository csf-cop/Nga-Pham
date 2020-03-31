//
//  App.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

let kScreenSize = UIScreen.main.bounds.size
let kScreenBounds = UIScreen.main.bounds

struct App {
    enum Mode: String {
        case release
        case debug
        case staging
    }

    static let gregorianCalendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 1
        calendar.locale = enUSLocale
        return calendar
    }()

    static var name: String {
        guard let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String else { return "" }
        return appName
    }

    static var bundleID: String {
        guard let bundleID = Bundle.main.bundleIdentifier else { return "" }
        return bundleID
    }

    static var token: String {
        get {
            return SecurePreference.shared.string(forKey: SaveKeys.token)
        }
        set {
            SecurePreference.shared.set(newValue, forKey: SaveKeys.token)
        }
    }

    static let enUSLocale = Locale(identifier: "en_US_POSIX")
}

extension App {
    static func openSetting() {
        guard let settingsUrl: URL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}
