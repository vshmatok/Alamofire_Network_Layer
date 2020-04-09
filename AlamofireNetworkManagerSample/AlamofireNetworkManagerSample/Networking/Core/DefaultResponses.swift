//
//  VoidResponse.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 8/22/19.
//  Copyright © 2019 Vlad Shmatok. All rights reserved.
//

import Foundation

struct VoidResponse: Codable {
}

struct CustomError: LocalizedError {

    // MARK: - Properties

    var errorMessage: String
    var error: Error

    var errorDescription: String? {
        return errorMessage
    }

    // MARK: - Initiazalion

    init(data: Data?, error: Error) {
        self.error = error
        self.errorMessage = error.localizedDescription

        if let data = data, let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let errors = json["errors"] as? [String] {
            errorMessage.append(contentsOf: errors.joined(separator: "\n"))
        }
    }
}
