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
        static let mode: String = "GP_MODE"
        static let appVersion: String = "GP_APP_VERSION"
        static let googleMapKey: String = "GG_MAP_KEY"
        static let ctyBaseURL: String = "GP_CITY_BASE_URL"
        static let kenpoBaseURL: String = "GP_KENPO_BASE_URL"
        static let amazonawsBaseURL: String = "GP_AMAZONAWS_BASE_URL"
        static let reProToken: String = "GP_REPRO_TOKEN"
        static let appsFlyerDevKey: String = "GP_APPSFLYER_DEV_KEY"

        static let watchAppName = "GP_WATCH_APP_NAME"
        static let watchAppS3 = "GP_WATCH_APP_S3"
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

    static let cityHost: String = {
        guard let host: String = Environment.infoDictionary[Keys.ctyBaseURL] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
        return host
    }()

    static let kenpoHost: String = {
        guard let host: String = Environment.infoDictionary[Keys.kenpoBaseURL] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
        return host
    }()

    static let amazonAWSHost: String = {
        guard let host: String = Environment.infoDictionary[Keys.amazonawsBaseURL] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
        return host
    }()

    #if os(watchOS)
        static let watchAppS3: String = {
            guard let host: String = Environment.infoDictionary[Keys.watchAppS3] as? String else {
                fatalError("Base URL not set in plist for this environment")
            }
            return host
        }()
    #endif

    // MARK: - Plist values
    static let baseUrl: String = {
        return "https://\(Environment.host)"
    }()

    static let baseUrlWebView: String = {
        return "https://\(Environment.amazonAWSHost)"
    }()

    static let cityBaseUrl: String = {
        return "https://\(Environment.cityHost)"
    }()

    static let kenpoBaseUrl: String = {
        return "https://\(Environment.kenpoHost)"
    }()

    static let amazonBaseUrl: String = {
        return "https://\(Environment.amazonAWSHost)"
    }()

    #if os(watchOS)
        static let exerciseVideoUrl: String = {
            return "https://\(Environment.watchAppS3)/pro/res/applewatch/exercise/"
        }()
    #endif

    static let mode: String = {
        guard let mode: String = Environment.infoDictionary[Keys.mode] as? String else {
            fatalError("Mode Key not set in plist for this environment")
        }
        return mode
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
