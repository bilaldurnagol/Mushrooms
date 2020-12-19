//
//  PostHeaderTableViewCell.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 10.12.2020.
//

import UIKit

class PostHeaderTableViewCell: UITableViewCell {
    
    static let identifier = "PostHeaderTableViewCell"
    
    private let cellView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Bilal")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
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
    
    private let postDateLabel: UILabel = {
        let label = UILabel()
        label.text = "5:30 PM"
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellView)
        cellView.addSubview(profilePhotoImageView)
        cellView.addSubview(nameLabel)
        cellView.addSubview(postDateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellView.frame = CGRect(x: 0, y: 2.5, width: contentView.width, height: contentView.height - 2.5)
        profilePhotoImageView.frame = CGRect(x: 20,
                                             y: cellView.top + 15,
                                             width: cellView.height - 30,
                                             height: cellView.height - 30)
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height/2
        nameLabel.frame = CGRect(x: profilePhotoImageView.right + 10,
                                 y: profilePhotoImageView.top,
                                 width: cellView.width - profilePhotoImageView.width - 5,
                                 height: 25)
        postDateLabel.frame = CGRect(x: nameLabel.left,
                                     y: nameLabel.bottom + 1,
                                     width: cellView.width - profilePhotoImageView.width - 5,
                                     height: 20)
        
    }
    
    
    
    
}
