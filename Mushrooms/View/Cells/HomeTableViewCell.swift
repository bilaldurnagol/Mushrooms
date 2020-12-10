//
//  HomeTableViewCell.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 10.12.2020.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    static let identifier = "HomeTableViewCell"
    
    private let profilePhotoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Bilal")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Bilal Durnagöl"
        label.font = UIFont(name: "Roboto-Medium", size: 20)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        label.numberOfLines = 1
        return label
    }()
    
    private let notificationContentLabel: UILabel = {
       let label = UILabel()
        label.text = "Like your photo"
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        label.numberOfLines = 1
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 247/255, green: 83/255, blue: 86/255, alpha: 0.1)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
         button.setImage(UIImage(systemName: "heart"), for: .normal)
         button.tintColor = .label
         return button
     }()
}
