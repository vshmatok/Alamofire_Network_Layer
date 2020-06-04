//
//  SamleGateway.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 6/4/20.
//  Copyright © 2020 Vlad Shmatok. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Protocols

protocol SampleGatewayProtocol: class {
    func getAllPosts(completion: @escaping (Result<PostsResponse, APIError>) -> Void)
    func cancelGetAllPostsRequest()
    func getPostWith(identifier: Int, completion: @escaping (Result<PostResponse, APIError>) -> Void)
    func getUsersPosts(parameters: UsersPostRequestModel,
                       completion: @escaping (Result<PostsResponse, APIError>) -> Void)
    func createPost(parameters: CreatePostRequestModel,
                    completion: @escaping (Result<VoidResponse, APIError>) -> Void)
    func updatePost(postId: Int,
                    parameters: UpdatePostRequestModel,
                    completion: @escaping (Result<PostResponse, APIError>) -> Void)
    func deletePost(postId: Int,
                    completion: @escaping (Result<VoidResponse, APIError>) -> Void)
}

class SampleGateway: SampleGatewayProtocol {

    // MARK: - Properties

    private var apiClient: APIClientProtocol

    private var getAllPostsDataRequest: DataRequest?

    // MARK: - Initializaion

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    // MARK: - Internal

    func getAllPosts(completion: @escaping (Result<PostsResponse, APIError>) -> Void) {
        let route = SampleRouter.getPosts
         getAllPostsDataRequest = apiClient.performRequest(route: route, completion: completion)
    }

    func cancelGetAllPostsRequest() {
        getAllPostsDataRequest?.cancel()
    }

    func getPostWith(identifier: Int, completion: @escaping (Result<PostResponse, APIError>) -> Void) {
        let route = SampleRouter.getPost(identifier: identifier)
        apiClient.performRequest(route: route, completion: completion)
    }

    func getUsersPosts(parameters: UsersPostRequestModel,
                       completion: @escaping (Result<PostsResponse, APIError>) -> Void) {
        let route = SampleRouter.getUserPosts(parameters: parameters)
        apiClient.performRequest(route: route) { (result: Result<PostsResponse, APIError>) in

            // You could make manipulations with reponse before sending further

            switch result {
            case .success(let posts):
                completion(.success(posts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func createPost(parameters: CreatePostRequestModel,
                    completion: @escaping (Result<VoidResponse, APIError>) -> Void) {
        let route = SampleRouter.createPost(parameters: parameters)
        apiClient.performRequest(route: route, completion: completion)
    }

    func updatePost(postId: Int,
                    parameters: UpdatePostRequestModel,
                    completion: @escaping (Result<PostResponse, APIError>) -> Void) {
        let route = SampleRouter.updatePost(postId: postId, parameters: parameters)
        apiClient.performRequest(route: route, completion: completion)
    }

    func deletePost(postId: Int,
                    completion: @escaping (Result<VoidResponse, APIError>) -> Void) {
        let route = SampleRouter.deletePost(postId: postId)
        apiClient.performRequest(route: route, completion: completion)
    }

}
