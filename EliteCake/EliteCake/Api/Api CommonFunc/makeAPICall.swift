//
//  makeAPICall.swift
//  EliteCake
//
//  Created by Apple - 1 on 23/01/23.
//

import Foundation
import UIKit

func makeAPICall(url: URL, method: String, parameters: [String: Any], completion: @escaping (_ data: Data?, _ error: Error?, _ response: HTTPURLResponse?) -> Void) {
    // code to make the API call goes here
    let session = URLSession.shared
    var request = URLRequest(url: url)
    request.httpMethod = method
    
    if method == "POST" || method == "PUT" {
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    }
    let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(nil, error, nil)
        } else if let data = data, let response = response as? HTTPURLResponse {
            completion(data, nil, response)
        }
    }
    task.resume()
}
