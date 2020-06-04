//
//  UsersPostRequestModel.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 6/4/20.
//  Copyright © 2020 Vlad Shmatok. All rights reserved.
//

import Foundation

private struct Keys {
    static let userId: String = "userId"
}

struct UsersPostRequestModel {

    // MARK: - Properties

    var userId: Int = 1

    var parameters: [String: Any] {
        return [Keys.userId: userId]
    }
}
