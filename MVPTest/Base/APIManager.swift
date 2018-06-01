//
//  APIManager.swift
//  MVPTest
//
//  Created by Hector Ghinaglia on 5/31/18.
//  Copyright © 2018 HG. All rights reserved.
//

import Foundation

class APIManager {

    static let shared = APIManager()

    enum NetworkingError: Error {
        case invalidStatusCode
        case noData
    }

    func loadUsers(onSuccess successHandler: @escaping (_ users: [User]) -> (),
                   onFailure failureHandler: @escaping (_ error: Error) -> ()) {

        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                if let error = error {
                    failureHandler(error)
                    return
                }

                if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                    failureHandler(NetworkingError.invalidStatusCode)
                    return
                }

                guard let data = data else {
                    failureHandler(NetworkingError.noData)
                    return
                }

                let users = try! JSONDecoder().decode([User].self, from: data)
                successHandler(users)                
            }
        }
        task.resume()
    }

}
