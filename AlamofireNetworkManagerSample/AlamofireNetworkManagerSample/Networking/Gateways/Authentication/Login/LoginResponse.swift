//
//  LoginResponse.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 8/22/19.
//  Copyright © 2019 Vlad Shmatok. All rights reserved.
//

import Foundation

struct LoginUserResponse: Codable {

    // MARK: - CodingKey

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case fullName = "full_name"
        case token = "jwt"
    }

    // MARK: - Properties

    var id: Int
    var email: String
    var fullName: String
    var token: String

    var user: User {
        return .init(id: id, email: email, fullName: fullName, token: token)
    }
}

struct User {

    // MARK: - Properties

    var id: Int
    var email: String
    var fullName: String
    var token: String
}
