//
//  PostsResponse.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 6/4/20.
//  Copyright © 2020 Vlad Shmatok. All rights reserved.
//

import Foundation

struct PostsResponse: Codable {

    // MARK: - Properties

    var posts: [PostResponse]

    // MARK: - Initialization

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        posts = try container.decode([PostResponse].self)
    }
}
