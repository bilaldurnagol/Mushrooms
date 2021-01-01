//
//  DatabaseManager.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 17.12.2020.
//

import Foundation
import Alamofire


class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let host = "http://192.168.1.101:5000"
    
    //MARK:- Auth funcs
    public func createNewUser(user: User, completion: @escaping (Result<User?, Error>) -> Void) {
        //Create new user
        let params = [
            "name": user.name!,
            "gsm": user.gsm as Any,
            "email": user.email!,
            "password": user.password!,
            "image_url": user.image_url!
        ] as [String: Any]
        
        let data = try? JSONSerialization.data(withJSONObject: params, options: .init())
        
        guard let url = URL(string: "\(host)/register") else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = data
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                guard let error = try? JSONDecoder().decode(ErrorInfo.self, from: data!) else {return}
                completion(.failure(DatabaseErrors.failedToRegister(error.message)))
                return
            }
            completion(.success(user))
        }).resume()
    }
    
    public func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {
        //Login user
        let params = [
            "email": email,
            "password": password
        ]
        let data = try? JSONSerialization.data(withJSONObject: params, options: .init())
        guard let url = URL(string: "\(host)/login") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = data
        URLSession.shared.dataTask(with: urlRequest, completionHandler: {data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                guard let error = try? JSONDecoder().decode(ErrorInfo.self, from: data!) else {return}
                completion(.failure(DatabaseErrors.failedToLogin(error.message)))
                return
            }
            let user = try? JSONDecoder().decode(User.self, from: data!)
            completion(.success(user!))
        }).resume()
    }
    
    public func forgotPassword(email: String, newPassword: String, completion: @escaping (Result<String, Error>) -> ()) {
        //Forgot password
        guard let url = URL(string: "\(host)/forgot_password/\(email)/\(newPassword)") else {return}
        AF.request(url).validate().responseJSON(completionHandler: {response in
            if response.response?.statusCode == 200 {
                guard let data = try? JSONDecoder().decode(ErrorInfo.self, from: response.data!) else {return}
                completion(.success(data.message))
                
            }else {
                guard let data = try? JSONDecoder().decode(ErrorInfo.self, from: response.data!) else {return}
                completion(.failure(DatabaseErrors.failedToForgetPassword(data.message)))
            }
        })
    }
    
    //MARK:- POST Funcs
    
    public func sharePost(post: Post?, completion: @escaping (Bool) -> ()) {
        guard let name = post?.name,
              let content = post?.content,
              let imageURL = post?.image_url,
              let lat = post?.lat,
              let long = post?.long,
              let userID = post?.user_id else {return}
        
        let params = [
            "name": name,
            "content": content,
            "image_url": imageURL,
            "lat": lat,
            "long": long,
            "user_id": userID
        ] as [String : Any]
        let data = try? JSONSerialization.data(withJSONObject: params, options: .init())
        
        guard let url = URL(string: "\(host)/share_post") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = data
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        AF.request(urlRequest).responseJSON(completionHandler: {response in
            if response.response?.statusCode == 200 {
                completion(true)
            }else {
                completion(false)
            }
        })
    }
}


enum DatabaseErrors: Error {
    case failedToRegister(String)
    case failedToLogin(String)
    case failedToForgetPassword(String)
}

extension DatabaseErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToRegister(let error):
            return NSLocalizedString("\(error)", comment: "Error")
        case .failedToLogin(let error):
            return NSLocalizedString("\(error)", comment: "Error")
        case .failedToForgetPassword(let error):
            return NSLocalizedString("\(error)", comment: "Error")
        }
    }
}











