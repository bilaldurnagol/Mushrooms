//
//  RegisterVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit

class RegisterVC: UIViewController {
    
    private let outerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfileImage")
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addButton"), for: .normal)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
        return label
    }()
    
    private let confirmLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm Password"
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
        return label
    }()
    
    private let nameTextfield: UITextField = {
        let textfield = UITextField()
        textfield.keyboardType = .namePhonePad
        textfield.autocapitalizationType = .none
        textfield.returnKeyType = .continue
        textfield.autocorrectionType = .no
        textfield.leftViewMode = .always
        textfield.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        textfield.font = UIFont(name: "Roboto-Regular", size: 24)
        return textfield
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
    
    private let passwordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.keyboardType = .default
        textfield.autocapitalizationType = .none
        textfield.returnKeyType = .continue
        textfield.autocorrectionType = .no
        textfield.leftViewMode = .always
        textfield.isSecureTextEntry = true
        textfield.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        return textfield
    }()
    
    private let confirmTextfield: UITextField = {
        let textfield = UITextField()
        textfield.keyboardType = .default
        textfield.autocapitalizationType = .none
        textfield.returnKeyType = .done
        textfield.autocorrectionType = .no
        textfield.leftViewMode = .always
        textfield.isSecureTextEntry = true
        textfield.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        return textfield
    }()
    
    private let registerButton = IconTextButton(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        let string = "You already have an account? Login"
        let attributedString = NSMutableAttributedString(string: string)
        
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50),
                                      range: NSRange(location: 0, length: 28))
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 226/255, green: 94/255, blue: 49/255, alpha: 1.0),
                                      range: NSRange(location: 29, length: 5))
        attributedString.addAttribute(.font, value: UIFont(name: "Roboto-Regular", size: 17)!, range: NSRange(location: 0, length: 28))
        attributedString.addAttribute(.font, value: UIFont(name: "Roboto-Medium", size: 17)!, range: NSRange(location: 29, length: 5))
        label.attributedText = attributedString
        
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(outerView)
        outerView.addSubview(profileImageView)
        profileImageView.addSubview(logoImageView)
        outerView.addSubview(addButton)
        view.addSubview(nameLabel)
        view.addSubview(nameTextfield)
        view.addSubview(emailLabel)
        view.addSubview(emailTextfield)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextfield)
        view.addSubview(confirmLabel)
        view.addSubview(confirmTextfield)
        view.addSubview(registerButton)
        view.addSubview(registerLabel)
        
        registerButton.configure(with: InfoIconTextButton(text: "Register",
                                                          icon: UIImage(named: "MushroomSmall"),
                                                          backgroundColor: [UIColor(red: 245/255, green: 133/255, blue: 36/255, alpha: 1.0).cgColor,
                                                                            UIColor(red: 249/255, green: 43/255, blue: 127/255, alpha: 1.0).cgColor]))
        
        nameTextfield.delegate = self
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        confirmTextfield.delegate = self
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        let gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureHideKeyboard)
        
        
        

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        outerView.frame = CGRect(x: (view.width - 150)/2,
                                 y: 20,
                                 width: 150,
                                 height: 150)
        
        profileImageView.frame = CGRect(x: (outerView.width - 100)/2,
                                        y: (outerView.height - 100)/2,
                                        width: 100,
                                        height: 100)
        logoImageView.frame = CGRect(x: (profileImageView.width - 50)/2,
                                     y: (profileImageView.height - 50)/2,
                                     width: 50,
                                     height: 50)
        addButton.frame = CGRect(x: (outerView.width - 40)/2,
                                 y: profileImageView.bottom - 20,
                                 width: 40,
                                 height: 40)
        
        nameLabel.frame = CGRect(x: 30,
                                 y: outerView.bottom + 10,
                                 width: view.width - 60,
                                 height: 17)
        nameTextfield.frame = CGRect(x: 30,
                                     y: nameLabel.bottom,
                                     width: view.width - 60,
                                     height: 50)
        nameTextfield.addBottomBorder()
        emailLabel.frame = CGRect(x: 30,
                                  y: nameTextfield.bottom + 20,
                                  width: view.width - 60,
                                  height: 17)
        emailTextfield.frame = CGRect(x: 30,
                                      y: emailLabel.bottom,
                                      width: view.width - 60,
                                      height: 50)
        emailTextfield.addBottomBorder()
        passwordLabel.frame = CGRect(x: 30,
                                     y: emailTextfield.bottom + 20,
                                     width: view.width - 60,
                                     height: 17)
        passwordTextfield.frame = CGRect(x: 30,
                                         y: passwordLabel.bottom,
                                         width: view.width - 60,
                                         height: 50)
        passwordTextfield.addBottomBorder()
        confirmLabel.frame = CGRect(x: 30,
                                    y: passwordTextfield.bottom + 20,
                                    width: view.width - 60,
                                    height: 17)
        confirmTextfield.frame = CGRect(x: 30,
                                        y: confirmLabel.bottom,
                                        width: view.width - 60,
                                        height: 50)
        confirmTextfield.addBottomBorder()
       
        registerLabel.frame = CGRect(x: 0,
                                     y: view.bottom - 30,
                                     width: view.width,
                                     height: 20)
        
        registerButton.frame = CGRect(x: 30,
                                      y: registerLabel.top - 80,
                                      width: view.width - 60,
                                      height: 70)
        
    }
    
    
    //MARK: - objc funcs
    @objc private func didTapRegister() {
        print("Did tap register button")
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextfield {
            emailTextfield.becomeFirstResponder()
        }else if textField == emailTextfield {
            passwordTextfield.becomeFirstResponder()
        }else if textField == passwordTextfield {
            confirmTextfield.becomeFirstResponder()
        }else {
            self.didTapRegister()
        }
        return true
    }
    
}



/*
 
 
 @objc func keyboardWillShow(notification: NSNotification) {
     
     if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
         if self.view.frame.origin.y == 0 {
             self.view.frame.origin.y -= keyboardSize.height
         }
     }
 }

 @objc func keyboardWillHide(notification: NSNotification) {
     if self.view.frame.origin.y != 0 {
         self.view.frame.origin.y = 0
     }
 }et
 
 
 */
