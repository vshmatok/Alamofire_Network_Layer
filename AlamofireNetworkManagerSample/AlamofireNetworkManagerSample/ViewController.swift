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

    let apiClient = APICient()

    // MARK: - IBActions

    @IBAction func didTappedTestButton(_ sender: UIButton) {
        login()
    }

    // MARK: - Private

    private func login() {
        let loginParameters = LoginRequestParameters(email: "test11@gmail.comqqqqqq", phoneNumber: nil, password: "secretsecret", deviceType: .ios, pushToken: nil)
        apiClient.login(parameters: loginParameters) { (result) in
            switch result {
            case .success(let response):
                print(response.user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
}

