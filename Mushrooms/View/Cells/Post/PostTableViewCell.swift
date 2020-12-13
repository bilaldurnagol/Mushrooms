//
//  PostTableViewCell.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 10.12.2020.
//

import UIKit
import AVFoundation

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "PostTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 247/255, green: 83/255, blue: 86/255, alpha: 0.1)
        imageView.image = UIImage(named: "Bilal2")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(postImageView)
        contentView.layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds
        //        playerLayer.frame = contentView.bounds
    }
    
}
