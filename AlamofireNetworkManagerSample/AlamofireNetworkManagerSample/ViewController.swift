//
//  ViewController.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 8/22/19.
//  Copyright © 2019 Vlad Shmatok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    let sampleGateway: SampleGatewayProtocol = SampleGateway()

    // MARK: - IBActions

    @IBAction func didTappedTestButton(_ sender: UIButton) {
        updatePost()
    }

    // MARK: - Private

    private func getAllPosts() {
        sampleGateway.getAllPosts { (result) in
            switch result {
            case .success(let posts):
                print(posts.posts)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getSpecificPost() {
        sampleGateway.getPostWith(identifier: 101) { (result) in
            switch result {
            case .success(let post):
                print(post)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getUsersPost() {
        let parameters = UsersPostRequestModel()
        sampleGateway.getUsersPosts(parameters: parameters) { (result) in
            switch result {
            case .success(let post):
                print(post)
            case .failure(let error):
                print(error)
            }

        }
    }

    private func createPost() {
        let parameters = CreatePostRequestModel()
        sampleGateway.createPost(parameters: parameters) { (result) in
            switch result {
            case .success:
                print(result)
            case .failure(let error):
                print(error)
            }

        }
    }

    private func updatePost() {
        let parameters = UpdatePostRequestModel()
        sampleGateway.updatePost(postId: 1, parameters: parameters) { (result) in
            switch result {
            case .success(let post):
                print(post)
            case .failure(let error):
                print(error)
            }

        }
    }

    private func deletePost() {
        sampleGateway.deletePost(postId: 1) { (result) in
            switch result {
            case .success:
                print(result)
            case .failure(let error):
                print(error)
            }

        }
    }

}

