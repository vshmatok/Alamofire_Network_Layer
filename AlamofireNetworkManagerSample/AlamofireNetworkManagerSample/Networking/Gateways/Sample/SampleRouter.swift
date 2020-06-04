//
//  SampleRouter.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 6/4/20.
//  Copyright © 2020 Vlad Shmatok. All rights reserved.
//

import Foundation
import Alamofire

enum SampleRouter: Router {

    // MARK: - Cases

    case getPosts
    case getPost(identifier: Int)
    case getUserPosts(parameters: UsersPostRequestModel)
    case createPost(parameters: CreatePostRequestModel)
    case updatePost(postId: Int, parameters: UpdatePostRequestModel)
    case deletePost(postId: Int)

    // MARK: - Path

    var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        case .getPost(let identifier):
            return "/posts/\(identifier)"
        case .getUserPosts:
            return "/posts"
        case .createPost:
            return "/posts"
        case .updatePost(let postId):
            return "/posts/\(postId)"
        case .deletePost(let postId):
            return "/posts/\(postId)"
        }
    }

    // MARK: - Headers

    var headers: HTTPHeaders {
        switch self {
        case .createPost:
            return HTTPHeaders(arrayLiteral: HTTPHeader.contentType("application/json; charset=UTF-8"))
        default:
            return .default
        }
    }

    // MARK: - Method

    var method: HTTPMethod {
        switch self {
        case .getPosts:
            return .get
        case .getPost:
            return .get
        case .getUserPosts:
            return .get
        case .createPost:
            return .post
        case .updatePost:
            return .put
        case .deletePost:
            return .delete
        }
    }

    // MARK: - Parameters

    var parameters: Parameters? {
        switch self {
        case .getUserPosts(let parameters):
            return parameters.parameters
        case .createPost(let parameters):
            return parameters.parameters
        case .updatePost(_, let parameters):
            return parameters.parameters
        default:
            return nil
        }
    }
}
