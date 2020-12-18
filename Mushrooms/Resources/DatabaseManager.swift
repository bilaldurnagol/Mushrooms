//
//  DatabaseManager.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 17.12.2020.
//

import Foundation


class DatabaseManager {
    static let shared = DatabaseManager()
    
    //Create new user
    public func createNewUser(user: User, completion: @escaping (Result<User?, Error>) -> Void) {
        
        let params = [
            "name": user.name!,
            "gsm": user.gsm as Any,
            "email": user.email!,
            "password": user.password!,
            "image_url": user.image_url!
        ] as [String: Any]
        
        let data = try? JSONSerialization.data(withJSONObject: params, options: .init())
        
        guard let url = URL(string: "http://192.168.1.101:5000/register") else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = data
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                guard let error = try? JSONDecoder().decode(ErrorInfo.self, from: data!) else {return}
                completion(.failure(WebServiceError.failedToRegister(error.message)))
                return
            }
            completion(.success(user))
        }).resume()
    }
}


enum WebServiceError: Error {
    case failedToRegister(String)
}

extension WebServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToRegister(let error):
            return NSLocalizedString("\(error)", comment: "Error")
        }
    }
}











