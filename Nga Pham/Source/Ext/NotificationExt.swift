//
//  NotificationExt.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/20/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

let notificationCenter = NotificationCenter.default

extension Notification.Name {
    #if os(iOS)
        static let ReloadContacts: Notification.Name = Notification.Name(rawValue: "ReloadContacts")
        static let RestartApp: Notification.Name = Notification.Name(rawValue: "RestartApp")
    #endif

    #if os(watchOS)
        static let WillEnterForeground: Notification.Name = Notification.Name(rawValue: "WillEnterForeground")
        static let DidEnterBackground: Notification.Name = Notification.Name(rawValue: "DidEnterBackground")
        static let UpdateProfile: Notification.Name = Notification.Name(rawValue: "UpdateProfile")
        static let UpdateGoalValue: Notification.Name = Notification.Name(rawValue: "UpdateGoalValue")
    #endif
}

#if os(iOS)
    enum NotiReloadData: CaseIterable {
        case reloadContact
        case restartApp

        func name() -> Notification.Name {
            switch self {
            case .reloadContact:
                return Notification.Name.ReloadContacts
            case .restartApp:
                return Notification.Name.RestartApp
            }
        }
    }

    struct UserInfoKey {
        static let dateUpdate = "DateUpdate"
    }
#endif

enum NotifiTop: String {
    case topTabPage
    case result
}
