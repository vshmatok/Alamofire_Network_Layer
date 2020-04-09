//
//  APIClient+Authentication.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 8/22/19.
//  Copyright © 2019 Vlad Shmatok. All rights reserved.
//

import Foundation
import Alamofire

extension APICient {

    func login(parameters: LoginRequestParameters, completion: @escaping (Result<LoginUserResponse, CustomError>) -> Void) {
        let request = AuthenticationRouter.login(parameters: parameters)
        performRequest(route: request, completion: completion)
    }

    func logout(completion: @escaping (Result<VoidResponse, CustomError>) -> Void) {
        let request = AuthenticationRouter.logout
        performRequest(route: request, completion: completion)
    }

    func checkMail(email: String, completion: @escaping (Result<CheckEmailResponse, CustomError>) -> Void) {
        let request = AuthenticationRouter.checkMail(email: email)
        performRequest(route: request, completion: completion)
    }
}
