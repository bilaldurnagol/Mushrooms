//
//  User.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 13.12.2020.
//

import Foundation
import UIKit


struct User: Codable {
    //User
    let id: Int?
    let name: String?
    let gsm: String?
    let email: String?
    let password: String?
    let image_url: String?
}


struct Posts: Codable {
    let post: [Post]?
}

struct Post: Codable {
    //Post
    let id: Int?
    let name: String?
    let content: String?
    let image_url: String?
    let lat: Float?
    let long: Float?
    let user_id: Int?
    let created: String?
    let comments_info: CommentInfo?
    let likes_info: LikeInfo?
}

struct CommentInfo: Codable {
    //Comment info
    let count: Int?
    let comments: [Comments]?
}

struct Comments: Codable {
    //Comments content and user
    let content: String?
    let user_id: Int?
}


struct LikeInfo : Codable{
    let count: Int?
    let likes: [Likes]?
}

struct Likes: Codable {
    let user_id: Int?
}


struct NotificationModel: Codable {
    let message: String?
    let post_id: Int?
    let user_id: Int?
}

//Database messages
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
