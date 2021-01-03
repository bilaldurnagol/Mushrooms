//
//  LoginVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit

class LoginVC: UIViewController {
    
    private let validationErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.isHidden = true
        label.textAlignment = .center
        label.backgroundColor = .white
        label.numberOfLines = 0
        return label
    }()
    private let loginErrorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .systemRed
        spinner.style = .large
        return spinner
    }()
    
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
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private var keyboardHeight = CGFloat()
    private var isValidEmail: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(spinner)
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
        scrollView.addSubview(loginErrorLabel)
        scrollView.addSubview(validationErrorLabel)
        
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
        
        let registerLabelGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRegisterLabel))
        registerLabel.addGestureRecognizer(registerLabelGesture)
        
        //hide keyboard tapped view
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
        loginErrorLabel.frame = CGRect(x: 0, y: scrollView.bottom - 70, width: scrollView.width, height: 70)
        
        
        spinner.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        spinner.center = view.center
    }
    
    
    //MARK: - objc funcs
    
    ///hide keyboard
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    /// login func
    @objc private func didTapLoginButton() {
        spinner.startAnimating()
        view.endEditing(true)
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {return}
        if isValidEmail{
            DatabaseManager.shared.login(email: email, password: password, completion: {[weak self] result in
                switch result {
                case .success(let user):
                    guard let email = user.email, let name = user.name, let imageURL = user.image_url, let userID = user.id else {return}
                    UserDefaults.standard.setValue(userID, forKeyPath: "userID")
                    UserDefaults.standard.setValue(email, forKey: "currentUser")
                    UserDefaults.standard.setValue(name, forKeyPath: "userName")
                    UserDefaults.standard.setValue(imageURL, forKeyPath: "imageURL")
                    DispatchQueue.main.async {
                        self?.spinner.stopAnimating()
                        self?.dismiss(animated: true, completion: nil)
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.spinner.stopAnimating()
                        self?.loginErrorShow(message: "There was a problem signing in. Check your email and password or create an account.")
                    }
                    
                }
            })
        }
    }
    //register page
    @objc private func didTapRegisterLabel() {
        let vc = RegisterVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        //Keyboard height
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
            print(keyboardHeight)
        }
    }
    
    //MARK:- Validations Funcs
    private func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    //MARK:- Error Funcs
    
    /// show login user error
    public func loginErrorShow(message: String) {
        loginErrorLabel.isHidden = false
        loginErrorLabel.text = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {[weak self] in
            self?.loginErrorLabel.isHidden = true
        })
    }
    
    ///show textfields validation error
    private func validationErrorShow(text: String, texfield: UITextField, height: CGFloat) {
        validationErrorLabel.frame = CGRect(x: 0, y: texfield.bottom + 2, width: scrollView.width, height: height)
        validationErrorLabel.isHidden = false
        validationErrorLabel.text = text
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.validationErrorLabel.isHidden = true
            
        })
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
        if textField == emailTextfield {
            if !textField.text!.isEmpty {
                if !validateEmail(candidate: textField.text!){
                    validationErrorShow(text: "The email entered is not valid.", texfield: textField, height: 20.0)
                    textField.textColor = .systemRed
                    isValidEmail = false
                }else {
                    textField.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
                    isValidEmail = true
                }
            }
        }
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
