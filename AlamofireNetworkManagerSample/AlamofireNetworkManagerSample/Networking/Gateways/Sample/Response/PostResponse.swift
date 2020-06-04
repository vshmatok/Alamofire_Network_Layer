//
//  PostResponse.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 6/4/20.
//  Copyright © 2020 Vlad Shmatok. All rights reserved.
//

import Foundation

struct PostResponse: Codable {

    // MARK: - Properties

    var userId: Int
    var id: Int
    var title: String
    var body: String
}
