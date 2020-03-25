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
    static let gregorianCalendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 1
        calendar.locale = enUSLocale
        return calendar
    }()

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
