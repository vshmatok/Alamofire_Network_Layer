//
//  CheckEmailResponse.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 8/22/19.
//  Copyright © 2019 Vlad Shmatok. All rights reserved.
//

import Foundation

struct CheckEmailResponse: Codable {

    // MARK: - Coding Keys

    enum CodingKeys: String, CodingKey {
        case alreadyRegistered = "email_present"
    }

    // MARK: - Properties
    
    var alreadyRegistered: Bool
}
