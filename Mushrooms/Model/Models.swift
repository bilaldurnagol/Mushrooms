//
//  User.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 13.12.2020.
//

import Foundation
import UIKit

//User
struct User: Codable {
    var name: String?
    var gsm: String?
    var email: String?
    var password: String?
    var image_url: String?
}




//Error
struct ErrorInfo: Codable {
    let message: String
}

//Custom icon text button
struct InfoIconTextButton {
    let text: String
    let icon: UIImage?
    let backgroundColor: [CGColor]?
}
//Custom text button
struct InfoTextButton {
    let text: String
    let backgroundColor: [CGColor]?
}
