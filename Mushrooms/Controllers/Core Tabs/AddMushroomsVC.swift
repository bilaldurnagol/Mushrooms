//
//  AddMushroomsVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit

class AddMushroomsVC: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Bilal")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 25.0
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
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 247/255, green: 83/255, blue: 86/255, alpha: 0.1)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let addPostButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "PostLogo"), for: .normal)
        return button
    }()
    
    
    private let uploadLabel: UILabel = {
        let label = UILabel()
        label.text = "Click to upload mushrooms"
        label.textColor = UIColor(red: 226/255, green: 94/255, blue: 49/255, alpha: 1.0)
        label.font = UIFont(name: "Roboto-Regular", size: 15)
        label.textAlignment = .center
        return label
    }()
    
    private let contentPostTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Write something here..."
        textView.textColor = UIColor.lightGray
        textView.font = UIFont(name: "Roboto-Regular", size: 15)
        return textView
    }()
    
    
    
    private let shareButton = TextButton(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    
    private var keyboardHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavBar()
        view.addSubview(scrollView)
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(postImageView)
        postImageView.addSubview(uploadLabel)
        postImageView.addSubview(addPostButton)
        scrollView.addSubview(contentPostTextView)
        scrollView.addSubview(shareButton)
        
        
        shareButton.configure(with: InfoTextButton(text: "Share",
                                                   backgroundColor: [UIColor(red: 245/255, green: 133/255, blue: 36/255, alpha: 1.0).cgColor,
                                                                     UIColor(red: 249/255, green: 43/255, blue: 127/255, alpha: 1.0).cgColor]))
        
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        addPostButton.addTarget(self, action: #selector(didTapAddPostButton), for: .touchUpInside)
        
        contentPostTextView.delegate = self
        
        //Keyboard height
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
        
        let gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(didTapHideKeyboard))
        view.addGestureRecognizer(gestureHideKeyboard)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tabBarHeight = UITabBarController().tabBar.height
        let navBarHeight = UINavigationController().navigationBar.height
    
        scrollView.frame = view.bounds
        
        profileImageView.frame = CGRect(x: 20,
                                        y: 15,
                                        width: 50,
                                        height: 50)
        nameLabel.frame = CGRect(x: profileImageView.right + 15,
                                 y: 27.5,
                                 width: scrollView.width - profileImageView.width - 20 - 15,
                                 height: 25)
        postImageView.frame = CGRect(x: 0,
                                     y: profileImageView.bottom + 25,
                                     width: scrollView.width,
                                     height: scrollView.height/3)
        uploadLabel.frame = CGRect(x: 0,
                                   y: 20,
                                   width: postImageView.width,
                                   height: 20)
        addPostButton.frame = CGRect(x: postImageView.width/2 - 40,
                                     y: postImageView.height/2 - 40,
                                     width: 80,
                                     height: 80)
        
        contentPostTextView.frame = CGRect(x: 20,
                                           y: postImageView.bottom + 5,
                                           width: scrollView.width - 40,
                                           height: scrollView.height - postImageView.bottom - navBarHeight - tabBarHeight - 85)
        shareButton.frame = CGRect(x: 30,
                                   y: contentPostTextView.bottom + 10,
                                   width: scrollView.width - 60,
                                   height: 70)
    }
    
    
    
    private func customNavBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium",size: 24)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancelButton))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 20)!],
                                                                  for: UIControl.State.normal)
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.5)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    
    //MARK: -objc funcs
    
    @objc private func didTapCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapShareButton() {
        print("Did tap share button...")
    }
    
    @objc private func didTapAddPostButton() {
        postImageView.image = UIImage(named: "Bilal2")
        postImageView.backgroundColor = .clear
        uploadLabel.isHidden = true
        addPostButton.isHidden = true
    }
    
    ///Keyboard height
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
        }
    }
    
    @objc private func didTapHideKeyboard() {
        view.endEditing(true)
    }
}

extension AddMushroomsVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        }
        self.view.frame.origin.y -= keyboardHeight
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = "Write something here..."
            textView.textColor = UIColor.lightGray
        }
        self.view.frame.origin.y = 0
    }
    
    
}

