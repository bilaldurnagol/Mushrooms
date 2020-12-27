//
//  ForgotPasswordVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 8.12.2020.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .systemRed
        spinner.style = .large
        return spinner
    }()
    
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
    
    private let forgotAlertLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private let sendButton = TextButton(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    private var keyboardHeight = CGFloat()
    private var isValidPassword: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(spinner)
        scrollView.addSubview(imageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(subTitleLabel)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextfield)
        scrollView.addSubview(sendButton)
        scrollView.addSubview(forgotAlertLabel)
        
        emailTextfield.delegate = self
        
        sendButton.configure(with: InfoTextButton(text: "Send",
                                                  backgroundColor: [UIColor(red: 245/255, green: 133/255, blue: 36/255, alpha: 1.0).cgColor,
                                                                    UIColor(red: 249/255, green: 43/255, blue: 127/255, alpha: 1.0).cgColor]))
        let gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureHideKeyboard)
        
        //Keyboard height
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        imageView.frame = CGRect(x: 40,
                                 y: scrollView.safeAreaInsets.top + 30,
                                 width: scrollView.width - 80,
                                 height: 200)
        sendButton.frame = CGRect(x: 30,
                                  y: scrollView.bottom - 80,
                                  width: scrollView.width - 60,
                                  height: 70)
        emailTextfield.frame = CGRect(x: 30,
                                      y: sendButton.top - 90,
                                      width: scrollView.width - 60,
                                      height: 50)
        emailTextfield.addBottomBorder()
        emailLabel.frame = CGRect(x: 30,
                                  y: emailTextfield.top - 17,
                                  width: scrollView.width - 60,
                                  height: 17)
        titleLabel.frame = CGRect(x: 0,
                                  y: imageView.bottom + 40,
                                  width: scrollView.width,
                                  height: 40)
        subTitleLabel.frame = CGRect(x: 25,
                                     y: titleLabel.bottom,
                                     width: scrollView.width - 50,
                                     height: 100)
        forgotAlertLabel.frame = CGRect(x: 0, y: scrollView.bottom - 70, width: scrollView.width, height: 70)
        
        spinner.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        spinner.center = view.center
    }
    
    private func forgotAlertShow(message: String) {
        //Forgot error
        forgotAlertLabel.isHidden = false
        forgotAlertLabel.text = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {[weak self] in
            self?.forgotAlertLabel.isHidden = true
        })
    }
    
    private func passwordGenerator() -> String {
        //Create new password
        let passwordCharacters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
        let len = 8
        var password = ""
        while true {
            if validatePassword(candidate: password) {
                break
            }else {
                password = ""
                for _ in 0..<len {
                    // generate a random index based on your array of characters count
                    let rand = arc4random_uniform(UInt32(passwordCharacters.count))
                    // append the random character to your string
                    password.append(passwordCharacters[Int(rand)])
                }
            }
        }
        return password
    }
    
    private func validatePassword(candidate: String) -> Bool {
        let passwordRegex = "(?=[^a-z]*[a-z])(?=[^0-9]*[0-9])[a-zA-Z0-9!@#$%^&*]{8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: candidate)
    }
    
    
    //MARK: - objc funcs
    
    @objc private func hideKeyboard() {
        //hide keyboard
        view.endEditing(true)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        //Keyboard height
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
            print(keyboardHeight)
        }
        if view.frame.minY == 0.0 {
            self.view.frame.origin.y -= keyboardHeight
        }else {
            self.view.frame.origin.y = 0.0
        }
    }
    
    
    @objc func didTapSendButton() {
        //send new password
        view.endEditing(true)
        self.view.frame.origin.y = 0
        spinner.startAnimating()
        let newPassword = passwordGenerator()
        guard let email = emailTextfield.text else {return}
        DatabaseManager.shared.forgotPassword(email: email, newPassword: newPassword, completion: { [weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    strongSelf.spinner.stopAnimating()
                }
                strongSelf.forgotAlertShow(message: error.localizedDescription)
                print(error.localizedDescription)
            case .success(let message):
                DispatchQueue.main.async {
                    strongSelf.spinner.stopAnimating()
                    let vc = LoginVC()
                    vc.modalPresentationStyle = .fullScreen
                    strongSelf.present(vc, animated: true, completion: {
                        vc.loginErrorShow(message: message)
                    })
                }
            }
        })
    }
}

extension ForgotPasswordVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
