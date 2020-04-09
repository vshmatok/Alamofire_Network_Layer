//
//  Router.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 8/22/19.
//  Copyright © 2019 Vlad Shmatok. All rights reserved.
//

import Foundation
import Alamofire

protocol Router: URLRequestConvertible {
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}

extension Router {

    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    var path: String {
        return ""
    }

    var headers: HTTPHeaders {
        return .default
    }

    var parameters: Parameters? {
        return nil
    }

    var method: HTTPMethod {
        return .get
    }

    func asURLRequest() throws -> URLRequest {
        let requestURL = try Application.baseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach({ request.addValue($0.value, forHTTPHeaderField: $0.name) })

        return try encoding.encode(request, with: parameters)
    }
}

