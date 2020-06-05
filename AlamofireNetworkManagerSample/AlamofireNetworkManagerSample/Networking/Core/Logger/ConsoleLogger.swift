//
//  ConsoleLogger.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 6/4/20.
//  Copyright © 2020 Vlad Shmatok. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Protocol

protocol ConsoleLoggerProtocol: class {
    func requestStart(router: Router)
    func requestFinished<T: Decodable>(response: DataResponse<T>)
}

class ConsoleLogger: ConsoleLoggerProtocol {

    // MARK: - Public

    func requestStart(router: Router) {
        guard let request = try? router.asURLRequest() else { return }

        logDivider()

        debugPrint("\(request.method?.rawValue ?? "GET") '\(request.url?.absoluteString ?? "")':")
    }

        func requestFinished<T: Decodable>(response: DataResponse<T>) {
        guard let metrics = response.metrics,
            let request = response.request,
            let httpMethod = request.httpMethod,
            let requestURL = request.url
            else {
                return
        }

        let elapsedTime = metrics.taskInterval.duration

        if let error = response.error {
            logDivider()

            debugPrint("[Error] \(httpMethod) '\(requestURL.absoluteString)' [\(String(format: "%.04f", elapsedTime)) s]:")
            debugPrint(error)
        } else {
            guard let httpResponse = response.response else {
                return
            }

            logDivider()

            debugPrint("\(String(httpResponse.statusCode)) '\(requestURL.absoluteString)' [\(String(format: "%.04f", elapsedTime)) s]:")

            logHeaders(headers: httpResponse.allHeaderFields)

            guard let data = response.data else { return }

            debugPrint("Body:")

            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                let prettyJson = try JSONSerialization.jsonObject(with: prettyData, options: [])
                debugPrint(prettyJson)
            } catch {
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    debugPrint(string)
                }
            }
        }
    }

    // MARK: - Private

    private func logDivider() {
        print("---------------------")
    }

    private func logHeaders(headers: [AnyHashable : Any]) {
        print("Headers: [")
        for (key, value) in headers {
            print("  \(key): \(value)")
        }
        print("]")
    }

}

