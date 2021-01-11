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
    
    public func userInfo(userID: Int, completion: @escaping (Result<User, Error>) -> ()) {
        //Get user info
        guard let url = URL(string: "\(host)/get_user_info/\(userID)") else {return}
        AF.request(url).validate().responseJSON(completionHandler: {response in
            if response.response?.statusCode == 200 {
                guard let data = try? JSONDecoder().decode(User.self, from: response.data!) else {return}
                completion(.success(data))
            }else {
                completion(.failure(DatabaseErrors.failedToGetUserInfo))
            }
        })
    }
    
    //MARK:- POST Funcs
    
    public func sharePost(post: Post?, completion: @escaping (Bool) -> ()) {
        //Share post
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
    
    public func fetchMushrooms(completion: @escaping (Result<Posts, Error>) -> ()) {
        //fetch mushrooms for show maps
        guard let url = URL(string: "\(host)/fetch_mushrooms") else {return}
        
        AF.request(url).validate().responseJSON(completionHandler: {response in
            if response.response?.statusCode == 200 {
                guard let data = try? JSONDecoder().decode(Posts.self, from: response.data!) else {return}
                completion(.success(data))
            } else {
                completion(.failure(DatabaseErrors.failedToFetchMushrooms))
            }
        })
    }
    
    public func fetchPosts(completion: @escaping (Result<Posts, Error>) -> ()) {
        //fetch posts for home page
        guard let url = URL(string: "\(host)/posts") else {return}
        
        AF.request(url).validate().responseJSON(completionHandler: {response in
            if response.response?.statusCode == 200 {
                guard let data = try? JSONDecoder().decode(Posts.self, from: response.data!) else {return}
                completion(.success(data))
            } else {
                completion(.failure(DatabaseErrors.failedToFetchPosts))
            }
        })
    }
    
    public func fetchPostsCurrentUser(currentUserID: Int,completion: @escaping (Result<Posts, Error>) -> ()) {
        //fetch posts for profile page
        guard let url = URL(string: "\(host)/posts/\(currentUserID)") else {return}
        
        AF.request(url).validate().responseJSON(completionHandler: {response in
            if response.response?.statusCode == 200 {
                guard let data = try? JSONDecoder().decode(Posts.self, from: response.data!) else {return}
                completion(.success(data))
            } else {
                completion(.failure(DatabaseErrors.failedToFetchPostsCurrentUser))
            }
        })
    }
    
    public func likePost(postID: Int, userID: Int, completion: @escaping (Bool) -> ()) {
        //like post
        guard let url = URL(string: "\(host)/like/\(postID)/\(userID)") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        AF.request(urlRequest).response(completionHandler: {response in
            if response.response?.statusCode == 200 {
                completion(true)
            }else {
                completion(false)
            }
        })
    }
    
    public func dislikePost(postID: Int, userID: Int, completion: @escaping (Bool) -> ()) {
        //like post
        guard let url = URL(string: "\(host)/dislike/\(postID)/\(userID)") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        AF.request(urlRequest).response(completionHandler: {response in
            if response.response?.statusCode == 200 {
                completion(true)
            }else {
                completion(false)
            }
        })
    }
    
    public func fetchNotifications(userID: Int, completion: @escaping (Result<Notifications, Error>) -> ()) {
        guard let url = URL(string: "\(host)/notifications/\(userID)") else {return}
        
        AF.request(url).validate().responseJSON(completionHandler: {response in
            if response.response?.statusCode == 200 {
                let data = try? JSONDecoder().decode(Notifications.self, from: response.data!)
                completion(.success(data!))
            }else {
                completion(.failure(DatabaseErrors.failedToFetchNotifications))
            }
        })
    }
}

enum DatabaseErrors: Error {
    case failedToRegister(String)
    case failedToLogin(String)
    case failedToForgetPassword(String)
    case failedToGetUserInfo
    case failedToFetchMushrooms
    case failedToFetchPosts
    case failedToFetchPostsCurrentUser
    case failedToLike
    case failedToDislike
    case failedToFetchNotifications
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
        case .failedToFetchMushrooms:
            return NSLocalizedString("Failed to get mushrooms for use maps show", comment: "Error")
        case .failedToFetchPosts:
            return NSLocalizedString("Failed to get posts for home page", comment: "Error")
        case .failedToGetUserInfo:
            return NSLocalizedString("Failed to get user info", comment: "Error")
        case .failedToLike:
            return NSLocalizedString("Failed to like in post", comment: "Error")
        case .failedToDislike:
            return NSLocalizedString("Failed to dislike in post", comment: "Error")
        case .failedToFetchNotifications:
            return NSLocalizedString("Failed to fetch notification", comment: "Error")
        case .failedToFetchPostsCurrentUser:
            return NSLocalizedString("Failed to get posts for profile page", comment: "Error")
        }
    }
}
