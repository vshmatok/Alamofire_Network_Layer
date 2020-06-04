//
//  UpdatePostRequestModel.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 6/4/20.
//  Copyright © 2020 Vlad Shmatok. All rights reserved.
//

import Foundation

private struct Keys {
    static let id: String = "id"
    static let title: String = "title"
    static let body: String = "body"
    static let userId: String = "userId"
}

struct UpdatePostRequestModel {

    // MARK: - Properties

    var id: Int = 1
    var title: String = "foo"
    var body: String = "bar"
    var userId: Int = 1

    var parameters: [String: Any] {
        return [Keys.title: title,
                Keys.body: body,
                Keys.userId: userId,
                Keys.id: id]
    }
}
