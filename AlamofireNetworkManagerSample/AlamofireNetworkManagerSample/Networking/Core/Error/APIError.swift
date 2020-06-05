//
//  APIError.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 6/4/20.
//  Copyright © 2020 Vlad Shmatok. All rights reserved.
//

import Foundation

struct APIError: LocalizedError {

    // MARK: - Properties

    var error: Error
    var apiErrorModel: APIErrorModel?

    var errorDescription: String? {
        return apiErrorModel?.message
    }

    // MARK: - Initiazalion

    init(data: Data?, error: Error) {
        self.error = error

        if let data = data,
            let apiErrorModel = try? JSONDecoder().decode(APIErrorModel.self, from: data) {
            self.apiErrorModel = apiErrorModel
        }
    }
}
