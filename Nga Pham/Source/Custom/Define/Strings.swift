//
//  Strings.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/20/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

extension App {
    struct Strings {
        static var cancel: String { return "Cancel" }
        static var favorite: String { return "favorite" }
        static var setting: String { return "setting" }
        static var complete: String { return "complete" }
        static var date: String { return "date" }
        static var camera: String { return "Camera" }
        static var library: String { return "Library" }
    }

    static func getNextImageKey(type: TypeCoreType) -> String {
        return "\(Date().string(withFormat: FormatType.fullTimeSecond))\(type.key)"
    }

    enum TypeCoreType {
        case image
        case juice
        case contact
        case order

        var key: String {
            switch self {
            case .image:
                return "1"
            case .juice:
                return "1"
            case .contact:
                return "1"
            case .order:
                return "1"
            }
        }
    }
}

extension App.Strings {
    struct Camera { }
}

extension App.Strings.Camera {
    static var selfies: String { return "selfies" }
    static var cameraRoll: String { return "camera roll" }
    static var myPhotoStream: String { return "my Photo Stream" }
    static var cameraAlertTitle: String { return "camera Alert Title" }
    static var cameraAlertMessage: String { return "camera Alert Message" }
    static var tapHereToChange: String { return "tap Here To Change" }
    static var libraryPhotoAlertTitle: String { return "library Photo Alert Title" }
    static var libraryPhotoMessage: String { return "library Photo Message" }
    static var descriptionPhotoAlertTitle: String { return "Description Photo Alert Title" }
    static var descriptionPhotoMessage: String { return "Description Photo Message" }
}
