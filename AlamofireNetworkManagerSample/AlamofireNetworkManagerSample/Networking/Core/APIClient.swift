//
//  APIClient.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 8/22/19.
//  Copyright © 2019 Vlad Shmatok. All rights reserved.
//

import Foundation
import Alamofire

final class APICient {

    @discardableResult
    func performRequest<T: Decodable>(route: Router, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, CustomError>) -> Void) -> DataRequest {
        return AF.request(route).validate().responseDecodable(decoder: decoder) { (response: DataResponse<T>) in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                let error = CustomError(data: response.data, error: error)
                completion(.failure(error))
            }
        }
    }

    @discardableResult
    func performMultipartRequest<T: Decodable>(route: Router, uploadData: [UploadData], parameters: Parameters, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, CustomError>) -> Void) -> DataRequest {
        return AF.upload(multipartFormData: { (multipart) in
            uploadData.forEach({ multipart.append($0.data, withName: $0.name, fileName: $0.fileName, mimeType: $0.mimeType) })

            for (key, value) in parameters {
                if let data = "\(value)".data(using: .utf8) {
                    multipart.append(data, withName: key)
                }
            }
        }, with: route).validate().responseDecodable(decoder: decoder) { (response: DataResponse<T>) in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                let error = CustomError(data: response.data, error: error)
                completion(.failure(error))
            }
        }
    }

}
