//
//  ActionsTableViewCell.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 10.12.2020.
//

import UIKit

class PostActionsTableViewCell: UITableViewCell {
    
    static let identifier = "ActionsTableViewCell"
    
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(likeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        likeButton.frame = CGRect(x: 15,
                                  y: 20,
                                  width: contentView.height - 40,
                                  height: contentView.height - 40)
    }
    
}
