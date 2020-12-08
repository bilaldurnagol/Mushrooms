//
//  ForgotPasswordVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 8.12.2020.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Forgot")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot your password?"
        label.font = UIFont(name: "Roboto-Medium", size: 32)
        label.textAlignment = .center
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        label.numberOfLines = 1
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter the email address associated with your email. We will email you a link to reset your password."
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        label.textAlignment = .center
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
        return label
    }()
    
    private let emailTextfield: UITextField = {
        let textfield = UITextField()
        textfield.keyboardType = .emailAddress
        textfield.autocapitalizationType = .none
        textfield.returnKeyType = .continue
        textfield.autocorrectionType = .no
        textfield.leftViewMode = .always
        textfield.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        textfield.font = UIFont(name: "Roboto-Regular", size: 24)
        return textfield
    }()
    
    //    private let sendButton: UIButton = {
    //       let button = UIButton()
    //        button.setTitle("Send", for: .normal)
    //        button.setTitleColor(.white, for: .normal)
    //        return button
    //    }()
    
    private let sendButton = TextButton(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextfield)
       
        view.addSubview(sendButton)
        
        sendButton.configure(with: InfoTextButton(text: "Send",
                                                  backgroundColor: [UIColor(red: 245/255, green: 133/255, blue: 36/255, alpha: 1.0).cgColor,
                                                                    UIColor(red: 249/255, green: 43/255, blue: 127/255, alpha: 1.0).cgColor]))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 40,
                                 y: view.safeAreaInsets.top + 30,
                                 width: view.width - 80,
                                 height: 200)
        sendButton.frame = CGRect(x: 30,
                                  y: view.bottom - 80,
                                  width: view.width - 60,
                                  height: 70)
        emailTextfield.frame = CGRect(x: 30,
                                      y: sendButton.top - 90,
                                      width: view.width - 60,
                                      height: 50)
        emailTextfield.addBottomBorder()
        emailLabel.frame = CGRect(x: 30,
                                  y: emailTextfield.top - 17,
                                  width: view.width - 60,
                                  height: 17)
        titleLabel.frame = CGRect(x: 0,
                                  y: imageView.bottom + 40,
                                  width: view.width,
                                  height: 40)
        subTitleLabel.frame = CGRect(x: 25,
                                     y: titleLabel.bottom,
                                     width: view.width - 50,
                                     height: 100)
        
    }
    
}
