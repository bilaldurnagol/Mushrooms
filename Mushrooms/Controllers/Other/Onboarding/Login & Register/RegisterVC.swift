//
//  RegisterVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit

class RegisterVC: UIViewController {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .systemRed
        spinner.style = .large
        return spinner
    }()
    
    private let validationErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.isHidden = true
        label.textAlignment = .center
        label.backgroundColor = .white
        label.numberOfLines = 0
        return label
    }()
    private let registerErrorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        label.text = "There was a problem signing in. Check your email and password or create an account."
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
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
        imageView.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfileImage")
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let addPhotoButton: UIButton = {
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
    
    
    
    private let loginLabel: UILabel = {
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
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private var keyboardHeight = CGFloat()
    
    private var isValidEmail: Bool = false
    private var isValidPassword: Bool = false
    private var isValidConfirmPassword: Bool = false
    
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        view.addSubview(validationErrorLabel)
        scrollView.addSubview(outerView)
        outerView.addSubview(profileImageView)
        outerView.addSubview(logoImageView)
        outerView.addSubview(addPhotoButton)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameTextfield)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextfield)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextfield)
        scrollView.addSubview(confirmLabel)
        scrollView.addSubview(confirmTextfield)
        scrollView.addSubview(registerButton)
        scrollView.addSubview(loginLabel)
        scrollView.addSubview(spinner)
        scrollView.addSubview(registerErrorLabel)
        
        registerButton.configure(with: InfoIconTextButton(text: "Register",
                                                          icon: UIImage(named: "MushroomSmall"),
                                                          backgroundColor: [UIColor(red: 245/255, green: 133/255, blue: 36/255, alpha: 1.0).cgColor,
                                                                            UIColor(red: 249/255, green: 43/255, blue: 127/255, alpha: 1.0).cgColor]))
        
        nameTextfield.delegate = self
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        confirmTextfield.delegate = self
        
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        addPhotoButton.addTarget(self, action: #selector(didTabAddPhotoButton), for: .touchUpInside)
        
        let loginLabelGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLoginLabel))
        loginLabel.addGestureRecognizer(loginLabelGesture)
        
        let gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureHideKeyboard)
        
        //Keyboard height
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let newWidth: CGFloat = scrollView.width - 60
        let textfieldHeight: CGFloat = 50.0
        let labelHeight: CGFloat = 17.0
        
        let outerViewSize = view.height/4
        let outerViewX = (view.width - outerViewSize)/2
        
        
        outerView.frame = CGRect(x: outerViewX,
                                 y: view.safeAreaInsets.top + 20,
                                 width: outerViewSize,
                                 height: outerViewSize)
        
        profileImageView.frame = CGRect(x: 10,
                                        y: 0,
                                        width: outerViewSize - 20,
                                        height: outerViewSize - 20)
        
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        logoImageView.frame = CGRect(x: profileImageView.left + 10,
                                     y: profileImageView.top + 10,
                                     width: profileImageView.height - 20,
                                     height: profileImageView.height - 20)
        
        addPhotoButton.frame = CGRect(x: (outerViewSize - 40)/2,
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
        
        loginLabel.frame = CGRect(x: 0,
                                  y: scrollView.bottom - 50,
                                  width: scrollView.width,
                                  height: 20)
        
        registerButton.frame = CGRect(x: 30,
                                      y: loginLabel.top - 80,
                                      width: newWidth,
                                      height: 70)
        registerErrorLabel.frame = CGRect(x: 0, y: scrollView.bottom - 70, width: scrollView.width, height: 70)
        spinner.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        spinner.center = scrollView.center
        
    }
    //MARK:- Error Funcs
    ///show textfields validation error
    private func validationErrorShow(text: String, texfield: UITextField, height: CGFloat) {
        validationErrorLabel.frame = CGRect(x: 0, y: texfield.bottom + 2, width: scrollView.width, height: height)
        validationErrorLabel.isHidden = false
        validationErrorLabel.text = text
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.validationErrorLabel.isHidden = true
            
        })
    }
    /// show login user error
    private func RegisterErrorShow(text: String) {
        registerErrorLabel.isHidden = false
        registerErrorLabel.text = text
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {[weak self] in
            self?.registerErrorLabel.isHidden = true
        })
    }
    
    //MARK:- Validations Funcs
    private func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    private func validatePassword(candidate: String) -> Bool {
        let passwordRegex = "(?=[^a-z]*[a-z])(?=[^0-9]*[0-9])[a-zA-Z0-9!@#$%^&*]{8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: candidate)
    }
    
    //MARK:- objc funcs
    @objc private func didTapRegister() {
        view.endEditing(true)
        guard let name = nameTextfield.text,
              let email = emailTextfield.text,
              let password = passwordTextfield.text,
              let imageData = profileImageView.image?.jpegData(compressionQuality: 0.75) ?? UIImage(named: "MushroomLogo")?.jpegData(compressionQuality: 0.75)
        else {return}
        
        if isValidEmail && isValidPassword && isValidConfirmPassword && !nameTextfield.text!.isEmpty {
            spinner.startAnimating()
            StorageManager.shared.uploadProfileImage(with: imageData, fileName: "\(email)", completion: { [weak self] result in
                switch result {
                case.success(let imageUrl):
                    DatabaseManager.shared.createNewUser(user: User(name: name, gsm: nil, email: email, password: password, image_url: imageUrl), completion: { [weak self] result in
                        switch result {
                        case .success(let user):
                            self?.user = user
                            UserDefaults.standard.setValue(user?.email, forKey: "currentUser")
                            UserDefaults.standard.setValue(user?.name, forKeyPath: "userName")
                            UserDefaults.standard.setValue(user?.image_url, forKeyPath: "imageURL")
                            DispatchQueue.main.async {
                                self?.spinner.stopAnimating()
                                self?.dismiss(animated: true, completion: nil)
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self?.spinner.stopAnimating()
                                self?.RegisterErrorShow(text: error.localizedDescription)
                                self?.emailLabel.textColor = .red
                            }
                        }
                    })
                case .failure(_):
                    print("Failed to upload profile image")
                }
            })
        }else {
            if nameTextfield.text!.isEmpty {
                nameLabel.textColor = .systemRed
            }else {
                nameLabel.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
            }
            if emailTextfield.text!.isEmpty {
                emailLabel.textColor = .systemRed
            }else {
                emailLabel.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
            }
            if passwordTextfield.text!.isEmpty {
                passwordLabel.textColor = .systemRed
            }else {
                passwordLabel.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
            }
            if confirmTextfield.text!.isEmpty {
                confirmLabel.textColor = .systemRed
            }else {
                confirmLabel.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
            }
            RegisterErrorShow(text: "Please check your information!")
        }
    }
    @objc private func didTapLoginLabel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTabAddPhotoButton() {
        let photoAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        photoAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {_ in
            self.takePhotoWithCamera()
        }))
        
        photoAlert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {_ in
            self.choosePhotoFromLibrary()
        }))
        photoAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(photoAlert, animated: true)
        
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
        }
    }
    
    
    
    // MARK:- Image Helper Methods
    private func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}
//MARK:- TextFields funs

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
        if textField == emailTextfield {
            if !validateEmail(candidate: textField.text ?? ""){
                validationErrorShow(text: "The email entered is not valid.", texfield: textField, height: 20)
                textField.textColor = .red
                isValidEmail = false
            }else {
                textField.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
                isValidEmail = true
            }
        }else if textField == passwordTextfield {
            if !validatePassword(candidate: textField.text ?? "") {
                validationErrorShow(text: "The password entered is not valid. Must contain 8 characters, uppercase and lowercase letters, numbers",
                                    texfield: textField,
                                    height: 70)
                textField.textColor = .red
                isValidPassword = false
            }else {
                textField.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
                isValidPassword = true
            }
        }else if textField == confirmTextfield {
            if textField.text != passwordTextfield.text {
                validationErrorShow(text: "Please enter the same password.", texfield: textField, height: 20)
                textField.textColor = .red
                isValidConfirmPassword = false
            }else {
                textField.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
                isValidConfirmPassword = true
            }
        }
    }
    
}

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImageView.image = info[.editedImage] as? UIImage
        logoImageView.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
}


//
