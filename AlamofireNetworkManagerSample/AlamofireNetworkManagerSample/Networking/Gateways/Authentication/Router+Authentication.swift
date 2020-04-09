//
//  Router+Login.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 8/22/19.
//  Copyright © 2019 Vlad Shmatok. All rights reserved.
//

import Foundation
import Alamofire

enum AuthenticationRouter: Router {

    // MARK: - Cases

    case login(parameters: LoginRequestParameters)
    case logout
    case checkMail(email: String)

    // MARK: - Path

    var path: String {
        switch self {
        case .login:
            return "/api/v1/sessions"
        case .logout:
            return "/api/v1/sessions/logout"
        case .checkMail:
            return "/api/v1/sessions/check_email"
        }
    }

    // MARK: - Headers

    var headers: HTTPHeaders {
        switch self {
        case .login, .checkMail:
            return .default
        case .logout:
            return ["Session-Token": ""]
        }
    }

    // MARK: - Method

    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .logout:
            return .delete
        case .checkMail:
            return .get
        }
    }

    // MARK: - Parameters

    var parameters: Parameters? {
        switch self {
        case .login(let parameters):
            return parameters.parameters
        case .logout:
            return nil
        case .checkMail(let email):
            return ["email": email]
        }
    }
}
