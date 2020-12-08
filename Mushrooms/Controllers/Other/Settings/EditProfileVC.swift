//
//  EditProfileVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 8.12.2020.
//

import UIKit

class EditProfileVC: UIViewController {
    
    private let outerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 100
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
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number"
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
    
    private let phoneTextfield: UITextField = {
        let textfield = UITextField()
        textfield.keyboardType = .phonePad
        textfield.autocapitalizationType = .none
        textfield.returnKeyType = .done
        textfield.autocorrectionType = .no
        textfield.leftViewMode = .always
        textfield.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        textfield.font = UIFont(name: "Roboto-Regular", size: 24)
        return textfield
    }()

    
    private let updateButton = TextButton(frame: CGRect(x: 0, y: 0, width: 500, height: 500))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        customNavBar()
    
        view.addSubview(outerView)
        outerView.addSubview(profileImageView)
        profileImageView.addSubview(logoImageView)
        outerView.addSubview(addButton)
        view.addSubview(nameLabel)
        view.addSubview(nameTextfield)
        view.addSubview(emailLabel)
        view.addSubview(emailTextfield)
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextfield)
        view.addSubview(updateButton)
        
        updateButton.configure(with: InfoTextButton(text: "Update",
                                                  backgroundColor: [UIColor(red: 245/255, green: 133/255, blue: 36/255, alpha: 1.0).cgColor,
                                                                    UIColor(red: 249/255, green: 43/255, blue: 127/255, alpha: 1.0).cgColor]))
        
        let gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureHideKeyboard)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        outerView.frame = CGRect(x: (view.width - 250)/2,
                                 y: view.safeAreaInsets.top,
                                 width: 250,
                                 height: 250)
        
        profileImageView.frame = CGRect(x: (outerView.width - 200)/2,
                                        y: (outerView.height - 200)/2,
                                        width: 200,
                                        height: 200)
        logoImageView.frame = CGRect(x: (profileImageView.width - 100)/2,
                                     y: (profileImageView.height - 100)/2,
                                     width: 100,
                                     height: 100)
        addButton.frame = CGRect(x: (outerView.width - 40)/2,
                                 y: profileImageView.bottom - 20,
                                 width: 40,
                                 height: 40)
        
        nameLabel.frame = CGRect(x: 30,
                                 y: outerView.bottom,
                                 width: view.width - 60,
                                 height: 17)
        nameTextfield.frame = CGRect(x: 30,
                                     y: nameLabel.bottom,
                                     width: view.width - 60,
                                     height: 50)
        nameTextfield.addBottomBorder()
        emailLabel.frame = CGRect(x: 30,
                                  y: nameTextfield.bottom + 10,
                                  width: view.width - 60,
                                  height: 17)
        emailTextfield.frame = CGRect(x: 30,
                                      y: emailLabel.bottom,
                                      width: view.width - 60,
                                      height: 50)
        emailTextfield.addBottomBorder()
        phoneLabel.frame = CGRect(x: 30,
                                  y: emailTextfield.bottom + 10,
                                  width: view.width - 60,
                                  height: 17)
        phoneTextfield.frame = CGRect(x: 30,
                                      y: phoneLabel.bottom,
                                      width: view.width - 60,
                                      height: 50)
        phoneTextfield.addBottomBorder()
        updateButton.frame = CGRect(x: 30,
                                    y: view.bottom - 80,
                                    width: view.width - 60,
                                    height: 70)
        
    }

    
    
    private func customNavBar() {
        
        title = "Edit Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium",size: 24)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancelButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward",
                                                                          withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24, weight: .medium))),
                                                           style: .plain, target: self, action: #selector(didTapBackButton))
      
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.5)
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 24)!],
                                                                  for: UIControl.State.normal)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    //MARK: -objc funcs
    
    @objc private func didTapCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
}
