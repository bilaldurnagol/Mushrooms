//
//  StorageManager.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 17.12.2020.
//

import Foundation
import Alamofire



class StorageManager {
    static let shared = StorageManager()
    
    static func safeFileName(emailAdress: String) -> String {
        let safeFileName = emailAdress.replacingOccurrences(of: "@", with: "_")
        return safeFileName
    }
    
    //MARK:- Update to user profile image in Google Cloud Platform
    
    public func uploadProfileImage(with imageData: Data, fileName: String, completion: @escaping (Result<String, Error>) -> ()) {
        let endpointUrl: String = "http://192.168.1.45:5000/upload_user_photo"
        let safeFileName = StorageManager.safeFileName(emailAdress: fileName)
        AF.upload(
            multipartFormData: { formData in
                formData.append(imageData, withName: "file", fileName: "profile_image/\(safeFileName)", mimeType: "image/jpg")
            },
            to: endpointUrl
        )
        .response(completionHandler: { response in
            guard let data = try? JSONDecoder().decode(User.self, from: response.data!) else {return}
            let imageUrl = data.image_url
            completion(.success(imageUrl!))
        })
        
    }
    
    
    
}


