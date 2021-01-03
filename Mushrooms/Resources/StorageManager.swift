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
    private let host = "http://192.168.1.101:5000"
    
    static func safeFileName(emailAdress: String) -> String {
        let safeFileName = emailAdress.replacingOccurrences(of: "@", with: "_")
        return safeFileName
    }
    
    //MARK:- Update to user profile image in Google Cloud Platform
    
    public func uploadImage(with imageData: Data, fileName: String, completion: @escaping (Result<String, Error>) -> ()) {
        let endpointUrl: String = "\(host)/upload_image"
        let safeFileName = StorageManager.safeFileName(emailAdress: fileName)
        AF.upload(
            multipartFormData: { formData in
                formData.append(imageData, withName: "file", fileName: "\(safeFileName)", mimeType: "image/jpg")
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


