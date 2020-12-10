//
//  LoginVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit

class LoginVC: UIViewController {
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MushroomLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    private let forgotLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password?"
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textAlignment = .right
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
    
    private let passwordTextfield: UITextField = {
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
    
    private let loginButton = IconTextButton(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    private let facebookButton = IconTextButton(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        let string = "You don't have any account? Register"
        let attributedString = NSMutableAttributedString(string: string)
        
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50),
                                      range: NSRange(location: 0, length: 28))
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 226/255, green: 94/255, blue: 49/255, alpha: 1.0),
                                      range: NSRange(location: 28, length: 8))
        attributedString.addAttribute(.font, value: UIFont(name: "Roboto-Regular", size: 17)!, range: NSRange(location: 0, length: 28))
        attributedString.addAttribute(.font, value: UIFont(name: "Roboto-Medium", size: 17)!, range: NSRange(location: 28, length: 8))
        label.attributedText = attributedString
        label.textAlignment = .center
        return label
    }()
    
    private var keyboardHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextfield)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextfield)
        scrollView.addSubview(forgotLabel)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(facebookButton)
        scrollView.addSubview(registerLabel)

        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        loginButton.configure(with: InfoIconTextButton(text: "Login",
                                                       icon: UIImage(named: "MushroomSmall"),
                                                       backgroundColor: [UIColor(red: 245/255, green: 133/255, blue: 36/255, alpha: 1.0).cgColor,
                                                                         UIColor(red: 249/255, green: 43/255, blue: 127/255, alpha: 1.0).cgColor]))
        facebookButton.configure(with: InfoIconTextButton(text: "Login With Facebook",
                                                          icon: UIImage(named: "FacebookIcon"),
                                                          backgroundColor: [UIColor(red: 60/255, green: 90/255, blue: 152/255, alpha: 1.0).cgColor,
                                                                            UIColor(red: 60/255, green: 90/255, blue: 152/255, alpha: 1.0).cgColor]))
        
        
        let gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureHideKeyboard)
        
        //Keyboard height
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        
        scrollView.frame = view.bounds
        
        let logoSize: CGFloat = 150
        let widthSize: CGFloat = (scrollView.width - 60)
        let sizeX: CGFloat = 30
        
        logoImageView.frame = CGRect(x: sizeX * 2,
                                     y: 60,
                                     width: widthSize - sizeX * 2,
                                     height: logoSize)
        emailLabel.frame = CGRect(x: sizeX,
                                  y: logoImageView.bottom + 10,
                                  width: widthSize,
                                  height: 17)
        emailTextfield.frame = CGRect(x: sizeX,
                                      y: emailLabel.bottom,
                                      width: widthSize,
                                      height: 50)
        emailTextfield.addBottomBorder()
        passwordLabel.frame = CGRect(x: sizeX,
                                     y: emailTextfield.bottom + 30,
                                     width: widthSize,
                                     height: 17)
        passwordTextfield.frame = CGRect(x: sizeX,
                                         y: passwordLabel.bottom,
                                         width: widthSize,
                                         height: 50)
        passwordTextfield.addBottomBorder()
        forgotLabel.frame = CGRect(x: sizeX,
                                   y: passwordTextfield.bottom + 10,
                                   width: widthSize,
                                   height: 20)
     
        registerLabel.frame = CGRect(x: 0,
                                     y: scrollView.bottom - 30,
                                     width: scrollView.width,
                                     height: 20)
        facebookButton.frame = CGRect(x: sizeX,
                                      y: registerLabel.top - 80,
                                      width: widthSize,
                                      height: 70)
        loginButton.frame = CGRect(x: sizeX,
                                   y: facebookButton.top - 80,
                                   width: widthSize,
                                   height: 70)
    }
    
    
    //MARK: - objc funcs
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func didTapLoginButton() {
        print("Did Tap login")
    }
    ///Keyboard height
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
        }
    }
}


extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextfield {
            passwordTextfield.becomeFirstResponder()
        }else if textField == passwordTextfield {
            self.didTapLoginButton()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField != emailTextfield {
            self.view.frame.origin.y -= keyboardHeight
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.frame.origin.y = 0
    }
}

/*
 family: Roboto
 font: Roboto-Regular
 font: Roboto-Italic
 font: Roboto-Thin
 font: Roboto-ThinItalic
 font: Roboto-Light
 font: Roboto-LightItalic
 font: Roboto-Medium
 font: Roboto-MediumItalic
 font: Roboto-Bold
 font: Roboto-BoldItalic
 font: Roboto-Black
 font: Roboto-BlackItalic
 */
