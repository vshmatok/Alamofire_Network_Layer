//
//  LoginRequestParameters.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 8/22/19.
//  Copyright © 2019 Vlad Shmatok. All rights reserved.
//

import Foundation
import Alamofire

enum DeviceType: String {
    case ios
    case android
}

struct LoginRequestParameters {

    // MARK: - Properties

    var email: String?
    var phoneNumber: String?
    var password: String
    var deviceType: DeviceType?
    var pushToken: String?

    var parameters: Parameters {
        return ["email": email ?? NSNull(),
                "phone_number": phoneNumber ?? NSNull(),
                "password": password,
                "device_type": deviceType?.rawValue ?? NSNull(),
                "push_token": pushToken ?? NSNull()]
    }
}
