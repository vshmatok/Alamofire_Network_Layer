//
//  Router + Base.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 6/5/20.
//  Copyright © 2020 Vlad Shmatok. All rights reserved.
//

import Foundation
import Alamofire

extension Router {

    var baseURL: String {
        return "https://jsonplaceholder.typicode.com"
    }

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
        let requestURL = try baseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach({ request.addValue($0.value, forHTTPHeaderField: $0.name) })

        return try encoding.encode(request, with: parameters)
    }
}

