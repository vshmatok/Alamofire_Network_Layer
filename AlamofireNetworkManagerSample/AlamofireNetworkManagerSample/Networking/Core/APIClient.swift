//
//  APIClient.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 8/22/19.
//  Copyright © 2019 Vlad Shmatok. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Protocol

protocol APIClientProtocol: class {
    @discardableResult
    func performRequest<T: Decodable>(route: Router,
                                      completion: @escaping (Result<T, APIError>) -> Void) -> DataRequest
    @discardableResult
    func performMultipartRequest<T: Decodable>(route: Router,
                                               uploadData: [UploadData],
                                               parameters: Parameters,
                                               uploadProgressHandler: (Request.ProgressHandler)?,
                                               completion: @escaping (Result<T, APIError>) -> Void) -> DataRequest
}

final class APIClient: APIClientProtocol {

    // MARK: - Properties

    private let consoleLogger: ConsoleLoggerProtocol

    // MARK: - Initialization

    init(consoleLogger: ConsoleLoggerProtocol = ConsoleLogger()) {
        self.consoleLogger = consoleLogger
    }

    // MARK: - Public

    @discardableResult
    func performRequest<T: Decodable>(route: Router,
                                      completion: @escaping (Result<T, APIError>) -> Void) -> DataRequest {
        consoleLogger.requestStart(router: route)
        return AF.request(route).validate().responseDecodable { [weak self] (response: DataResponse<T>) in
            self?.consoleLogger.requestFinished(response: response)
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                let error = APIError(data: response.data, error: error)
                completion(.failure(error))
            }
        }
    }

    @discardableResult
    func performMultipartRequest<T: Decodable>(route: Router,
                                               uploadData: [UploadData],
                                               parameters: Parameters,
                                               uploadProgressHandler: (Request.ProgressHandler)?,
                                               completion: @escaping (Result<T, APIError>) -> Void) -> DataRequest {
        consoleLogger.requestStart(router: route)
        return AF.upload(multipartFormData: { (multipart) in
            uploadData.forEach({ multipart.append($0.data,
                                                  withName: $0.name,
                                                  fileName: $0.fileName,
                                                  mimeType: $0.mimeType) })
            for (key, value) in parameters {
                if let data = "\(value)".data(using: .utf8) {
                    multipart.append(data, withName: key)
                }
            }
        }, with: route)
            .uploadProgress(closure: { (progress) in
                uploadProgressHandler?(progress)
            })
            .validate()
            .responseDecodable { [weak self] (response: DataResponse<T>) in
                self?.consoleLogger.requestFinished(response: response)
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    let error = APIError(data: response.data, error: error)
                    completion(.failure(error))
                }
        }
    }

}
