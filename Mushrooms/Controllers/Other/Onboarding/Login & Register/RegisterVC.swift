//
//  RegisterVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit

class RegisterVC: UIViewController {
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        return scrollView
    }()
    
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
    
    private var keyboardHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(outerView)
        outerView.addSubview(profileImageView)
        profileImageView.addSubview(logoImageView)
        outerView.addSubview(addButton)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameTextfield)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextfield)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextfield)
        scrollView.addSubview(confirmLabel)
        scrollView.addSubview(confirmTextfield)
        scrollView.addSubview(registerButton)
        scrollView.addSubview(registerLabel)
  
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
        
        //Keyboard height
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let newWidth: CGFloat = scrollView.width - 60
        let textfieldHeight: CGFloat = 50.0
        let labelHeight: CGFloat = 17.0
    
        
        outerView.frame = CGRect(x: (scrollView.width - 150)/2,
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
                                 width: newWidth,
                                 height: labelHeight)
        nameTextfield.frame = CGRect(x: 30,
                                     y: nameLabel.bottom,
                                     width: newWidth,
                                     height: textfieldHeight)
        nameTextfield.addBottomBorder()
        emailLabel.frame = CGRect(x: 30,
                                  y: nameTextfield.bottom + 20,
                                  width: newWidth,
                                  height: labelHeight)
        emailTextfield.frame = CGRect(x: 30,
                                      y: emailLabel.bottom,
                                      width: newWidth,
                                      height: textfieldHeight)
        emailTextfield.addBottomBorder()
        passwordLabel.frame = CGRect(x: 30,
                                     y: emailTextfield.bottom + 20,
                                     width: newWidth,
                                     height: labelHeight)
        passwordTextfield.frame = CGRect(x: 30,
                                         y: passwordLabel.bottom,
                                         width: newWidth,
                                         height: textfieldHeight)
        passwordTextfield.addBottomBorder()
        confirmLabel.frame = CGRect(x: 30,
                                    y: passwordTextfield.bottom + 20,
                                    width: newWidth,
                                    height: labelHeight)
        confirmTextfield.frame = CGRect(x: 30,
                                        y: confirmLabel.bottom,
                                        width: newWidth,
                                        height: textfieldHeight)
        confirmTextfield.addBottomBorder()
        
        registerLabel.frame = CGRect(x: 0,
                                     y: scrollView.bottom - 30,
                                     width: scrollView.width,
                                     height: 20)
        
        registerButton.frame = CGRect(x: 30,
                                      y: registerLabel.top - 80,
                                      width: newWidth,
                                      height: 70)
    }
    
    //MARK: - objc funcs
    @objc private func didTapRegister() {
        print("Did tap register button")
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    ///Keyboard height
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
        }
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
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField != nameTextfield {
            self.view.frame.origin.y -= keyboardHeight
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.frame.origin.y = 0
        
    }
    
}
