//
//  NotificationTableViewCell.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 9.12.2020.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationTableViewCell"
    
    private let cellView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    private let profilePhotoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Bilal")
        imageView.contentMode = .scaleAspectFill
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
        label.font = UIFont(name: "Roboto-Regular", size: 15)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        label.numberOfLines = 1
        return label
    }()
    
    private let notificationDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Yesterday"
        label.font = UIFont(name: "Roboto-Regular", size: 10)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.5)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellView)
        cellView.addSubview(profilePhotoImageView)
        cellView.addSubview(nameLabel)
        cellView.addSubview(notificationContentLabel)
        cellView.addSubview(notificationDateLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let customWidth: CGFloat = (contentView.width - profilePhotoImageView.width - notificationDateLabel.width - 10 - 10 - 10)
        
        cellView.frame = CGRect(x: 0, y: 2.5, width: contentView.width, height: contentView.height - 5)
        profilePhotoImageView.frame = CGRect(x: 20, y: 20, width: cellView.height - 40, height: cellView.height - 40)
        self.profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height/2
        notificationDateLabel.frame = CGRect(x: contentView.right - 70, y: contentView.height/3, width: 50, height: 20)
        nameLabel.frame = CGRect(x: profilePhotoImageView.right + 20, y: profilePhotoImageView.top, width: customWidth, height: 25)
        notificationContentLabel.frame = CGRect(x: profilePhotoImageView.right + 20, y: nameLabel.bottom + 5, width: customWidth, height: 18)
        
    }
    
    

}
