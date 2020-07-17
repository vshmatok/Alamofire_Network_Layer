//
//  RequestInterceptor.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 7/17/20.
//  Copyright © 2020 Vlad Shmatok. All rights reserved.
//

import Alamofire

// This protocol provided only for preview, you can implement yout local storage storage
protocol KeychainService: class {
    func saveToken(_ value: String)
    func getToken() -> String?
    func removeToken()
}

class KeychainServiceImpl: KeychainService {
    func saveToken(_ value: String) {}
    func getToken() -> String? { return ""}
    func removeToken() {}
}

// MARK: - Constants

private struct Constants {
    static let authPrefix: String = "/auth"
}

class RequestInterceptor: Alamofire.RequestInterceptor {

    // MARK: - Properties

    private let keychainService: KeychainService

    // MARK: - Initialization

    init(keychainService: KeychainService = KeychainServiceImpl()) {
        self.keychainService = keychainService
    }
}

// MARK: - RequestAdapter

extension RequestInterceptor {

    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard
            let url = urlRequest.url?.absoluteString,
            let path = urlRequest.url?.path,
            url.hasPrefix(ApplicationConstants.baseURL),
            !path.hasPrefix(Constants.authPrefix) else {
                return completion(.success(urlRequest))
        }

        guard let token = keychainService.getToken() else {
            return completion(.success(urlRequest))
        }

        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(token))

        completion(.success(urlRequest))
    }
}

// MARK: - RequestRetrier

extension RequestInterceptor {
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }

        refreshToken { [weak self] result in
            switch result {
            case .success(let token):
                self?.keychainService.saveToken(token)
                completion(.retry)
            case .failure(let error):
                self?.switchToAuthFlow()
                completion(.doNotRetryWithError(error))
            }
        }
    }

    private func refreshToken(completion: @escaping (Result<String, APIError>) -> Void) {
        // Add here refresh toke request with default session.
    }

    private func switchToAuthFlow() {
        // Clear all storage values and change root view controller to auth flow.
    }
}

