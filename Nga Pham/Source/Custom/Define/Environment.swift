//
//  Environment.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/31/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

enum Environment {
    enum Keys {
        static let baseURL: String = "GP_BASE_URL"
        static let appVersion: String = "GP_APP_VERSION"
        static let googleMapKey: String = "GG_MAP_KEY"
        static let reProToken: String = "GP_REPRO_TOKEN"
        static let appsFlyerDevKey: String = "GP_APPSFLYER_DEV_KEY"
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict: [String: Any] = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    static let host: String = {
        guard let host: String = Environment.infoDictionary[Keys.baseURL] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
        return host
    }()

    // MARK: - Plist values
    static let baseUrl: String = {
        return "http://\(Environment.host)"
    }()

    static let appVersion: String = {
        guard let version: String = Environment.infoDictionary[Keys.appVersion] as? String else {
            fatalError("Mode Key not set in plist for this environment")
        }
        return version
    }()

    static let googleMapKey: String = {
        guard let key: String = Environment.infoDictionary[Keys.googleMapKey] as? String else {
            fatalError("Mode Key not set in plist for this environment")
        }
        return key
    }()

    static let reProToken: String = {
        guard let key: String = Environment.infoDictionary[Keys.reProToken] as? String else {
            fatalError("Mode Key not set in plist for this environment")
        }
        return key
    }()

    static let appsFlyerDevKey: String = {
        guard let key: String = Environment.infoDictionary[Keys.appsFlyerDevKey] as? String else {
            fatalError("Mode Key not set in plist for this environment")
        }
        return key
    }()
}
