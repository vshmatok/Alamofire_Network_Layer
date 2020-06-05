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
    var baseURL: String { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}
