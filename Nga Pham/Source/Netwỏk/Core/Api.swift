//
//  Api.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/31/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Alamofire

#if os(iOS)
    typealias Network = NetworkReachabilityManager

// MARK: - Network
    extension Network {
        static let shared: Network = {
            guard let manager = Network() else {
                fatalError("Cannot alloc network reachability manager!")
            }
            return manager
        }()
    }
#endif

final class Api {
    static let baseUrl: String = Environment.baseUrl
    static let otherBaseUrl: String = Environment.baseUrl

    enum Endpoint {
        case base
        case userProfile
        case basePathUrl

        var string: String {
            switch self {
                // Base
            case .base:
                return "/api_base/api_auth_user"
            case .userProfile:
                return "/user/me"
            case .basePathUrl:
                return "/user/me"
            }
        }
    }

    static func generateUrl(endpoint: Endpoint) -> String {
        return "\(Api.baseUrl)\(endpoint.string)"
    }

    static func generateUrlWithParam(endpoint: Endpoint, params: [String]) -> String {
        var path: String = ""
        for param in params {
            path += "/\(param)"
        }
        return "\(Api.otherBaseUrl)\(endpoint.string)\(path)"
    }
}

enum Result<T> {
    case success(T)
    case error(ApiError)

    var error: ApiError? {
        switch self {
        case .error(let e):
            return e
        default:
            return nil
        }
    }

    var value: T? {
        switch self {
        case .success(let a):
            return a
        default:
            return nil
        }
    }
}

struct EmptyData: Codable { }
