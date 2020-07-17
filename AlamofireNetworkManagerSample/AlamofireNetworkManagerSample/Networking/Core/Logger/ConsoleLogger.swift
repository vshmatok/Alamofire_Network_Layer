//
//  ConsoleLogger.swift
//  AlamofireNetworkManagerSample
//
//  Created by Vlad Shmatok on 6/4/20.
//  Copyright © 2020 Vlad Shmatok. All rights reserved.
//

import Foundation
import Alamofire

class APILogger: EventMonitor {

    func requestDidResume(_ request: Request) {
        print("🌎 \(request)")
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        switch response.result {
        case .success:
            print("✅ Success")
            print("\(request)")
            if let metrics = request.metrics {
                print("Request started at: \(metrics.taskInterval.start)")
                print("Request finished at: \(metrics.taskInterval.end)")
                print("Request finished with duration: \(metrics.taskInterval.duration)")
            }
            if let data = response.data, let prettyPrintedString = data.prettyPrintedJSONString {
                print(prettyPrintedString)
            }
        case .failure(let error):
            let error = APIError(data: response.data, error: error)
            print("❌ Failure")
            print("\(request)")
            if let metrics = request.metrics {
                print("Request started at: \(metrics.taskInterval.start)")
                print("Request finished at: \(metrics.taskInterval.end)")
                print("Request finished with duration: \(metrics.taskInterval.duration)")
            }
            print("General error: \(error.error)")
            print("API error: \(error.errorDescription ?? "-")")
        }
    }
}

private extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = String(data: data, encoding: .utf8) else {
                return nil
        }

        return prettyPrintedString
    }
}
