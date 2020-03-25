//
//  ApiError.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/20/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case notReachable
    case notFound
    case missingData
    case emptyData(Error)
    case lostNetwork
    case noResponse(Error?)
    case serverError(Error)

    #if os(watchOS)
    var title: String {
        switch self {
        case .lostNetwork:
            return App.Strings.noInternetConnectionTitle
        default:
            return ""
        }
    }
    #endif

    var message: String {
        switch self {
        case .notReachable:
            return "Not Reachable"
        case .notFound:
            return "Not Found"
        case .lostNetwork:
            #if os(watchOS)
                return App.Strings.noInternetConnectionMsg
            #else
                return "Lost Network"
            #endif
        case .emptyData:
            return getMessageError()
        case .noResponse:
            return getMessageError()
        case .missingData:
            return "Missing Data"
        case .serverError:
            return getMessageError()
        }
    }

    var nsError: NSError? {
        switch self {
        case .emptyData(let e):
            return (e as NSError?)
        case .noResponse(let e):
            return (e as NSError?)
        case .serverError(let e):
            return (e as NSError?)
        default:
            return nil
        }
    }

    var httpStatus: HTTPStatus? {
        switch self {
        case .emptyData(let e):
            return makeHTTPStatus(from: e)
        case .noResponse(let e):
            return makeHTTPStatus(from: e)
        case .serverError(let e):
            return makeHTTPStatus(from: e)
        default:
            return nil
        }
    }

    private func getMessageError() -> String {
        if let httpMessage = httpStatus?.description, !httpMessage.isEmpty {
            return httpMessage
        }
        return (nsError?.localizedDescription ?? "")
    }

    private func makeHTTPStatus(from e: Error?) -> HTTPStatus? {
        let nsError = (e as NSError?)
        return nsError?.httpStatus()
    }
}

extension NSError {
    public convenience init(domain: String? = nil, status: HTTPStatus, message: String? = nil) {
        let domain = domain ?? Bundle.main.bundleIdentifier ?? ""
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: message ?? status.description]
        self.init(domain: domain, code: status.code, userInfo: userInfo)
    }

    public convenience init(domain: String? = nil, code: Int = -999, message: String) {
        let domain = domain ?? Bundle.main.bundleIdentifier ?? ""
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: message]

        self.init(domain: domain, code: code, userInfo: userInfo)
    }

    func httpStatus() -> HTTPStatus? {
        return HTTPStatus(rawValue: code)
    }
}
