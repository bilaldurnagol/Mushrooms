//
//  PostTableViewCell.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 4.01.2021.
//

import UIKit


protocol PostTableViewCellDelegate {
    func clickedLikeButton()
}

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "PostTableViewCell"
    
    private let postView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 20)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        label.numberOfLines = 1
        return label
    }()
    
    private let publishedLabel: UILabel = {
        let label = UILabel()
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
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        let configure = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 24,
                                                                            weight: .medium))
        button.setImage(UIImage(systemName: "bubble.right", withConfiguration: configure),
                        for: .normal)
        button.tintColor = UIColor(red: 59/255,
                                   green: 59/255,
                                   blue: 59/255,
                                   alpha: 1.0)
        return button
    }()
    
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        return label
    }()
    
    private var postID: Int?
    private var currentUserID: Int?
    private var likeCount = 0
    
    var delegate: PostTableViewCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addObjects()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLike))
        gestureRecognizer.numberOfTapsRequired = 2
        postImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        frameObjects()
    }
    
    //MARK: - Custom Objects
    
    private func addObjects() {
        //Add objects to view
        contentView.addSubview(postView)
        postView.addSubview(profileImageView)
        postView.addSubview(nameLabel)
        postView.addSubview(publishedLabel)
        postView.addSubview(postImageView)
        postView.addSubview(likeButton)
        postView.addSubview(likeCountLabel)
        postView.addSubview(commentButton)
    }
    
    private func frameObjects() {
        //Designing objects in view
        postView.frame = contentView.bounds
        profileImageView.frame = CGRect(x: 20,
                                        y: 15,
                                        width: 50,
                                        height: 50)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        nameLabel.frame = CGRect(x: profileImageView.right + 10,
                                 y: profileImageView.top,
                                 width: contentView.width - profileImageView.width - 30,
                                 height: 25)
        publishedLabel.frame = CGRect(x: nameLabel.left,
                                      y: nameLabel.bottom + 1,
                                      width: contentView.width - profileImageView.width - 30,
                                      height: 15)
        
        postImageView.frame = CGRect(x: 0,
                                     y: profileImageView.bottom + 20,
                                     width: contentView.width,
                                     height: contentView.width)
        likeButton.frame = CGRect(x: 15,
                                  y: postImageView.bottom + 5,
                                  width: 30,
                                  height: 30)
        
        commentButton.frame = CGRect(x: likeButton.right + 10,
                                     y: likeButton.top,
                                     width: 30,
                                     height: 30)
        
        likeCountLabel.frame = CGRect(x: likeButton.left,
                                      y: likeButton.bottom,
                                      width: contentView.width - likeButton.left,
                                      height: 30)
    }
    
    public func configure (post: Post?, user: User?, currentUserID: Int?, isLike: Bool?) {
        
        guard let profileImageURL = URL(string: (user?.image_url)!),
              let name = user?.name,
              let published = post?.created,
              let postImageURL = URL(string: (post?.image_url)!),
              let likeCount = post?.likes_info?.count else {return}
        
        self.postID = post?.id
        self.currentUserID = currentUserID
        self.likeCount = likeCount
        
        profileImageView.loadImage(fromURL: profileImageURL, placeHolderImage: "LoadingImage")
        nameLabel.text = name
        publishedLabel.text = published
        postImageView.loadImage(fromURL: postImageURL, placeHolderImage: "LoadingImage")
        likeCountLabel.text = "\(self.likeCount) likes"
        
        if isLike! {
            let configure = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 24,
                                                                                weight: .medium))
            
            likeButton.setImage(UIImage(systemName: "suit.heart.fill", withConfiguration: configure),
                                for: .normal)
            likeButton.tintColor = UIColor.red
        }else {
            let configure = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 24,
                                                                                weight: .medium))
            
            likeButton.setImage(UIImage(systemName: "suit.heart", withConfiguration: configure),
                                for: .normal)
            likeButton.tintColor = UIColor(red: 59/255,
                                           green: 59/255,
                                           blue: 59/255,
                                           alpha: 1.0)
        }
    }
    
    //MARK:- Objc Funcs
    @objc private func didTapLike() {
        guard let postID = postID, let userID = currentUserID else {return}
        
        DatabaseManager.shared.likePost(postID: postID, userID: userID, completion: {[weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .success(_):
                if let delegate = strongSelf.delegate {
                    delegate.clickedLikeButton()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
