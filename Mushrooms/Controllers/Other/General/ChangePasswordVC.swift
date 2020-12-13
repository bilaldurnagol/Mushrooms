//
//  ChangePasswordVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 9.12.2020.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Password"
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
        return label
    }()
    
    private let newPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "New Password"
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
        return label
    }()
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Re-Enter Password"
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.50)
        return label
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
        textfield.text = "123456789"
        return textfield
    }()
    
    private let newPasswordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.keyboardType = .default
        textfield.autocapitalizationType = .none
        textfield.returnKeyType = .continue
        textfield.autocorrectionType = .no
        textfield.leftViewMode = .always
        textfield.isSecureTextEntry = true
        textfield.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        textfield.text = "123456789"
        return textfield
    }()
    
    private let confirmPasswordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.keyboardType = .default
        textfield.autocapitalizationType = .none
        textfield.returnKeyType = .done
        textfield.autocorrectionType = .no
        textfield.leftViewMode = .always
        textfield.isSecureTextEntry = true
        textfield.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        textfield.text = "123456789"
        return textfield
    }()
    
    private let updateButton = TextButton(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        customNavBar()
        
        view.addSubview(scrollView)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextfield)
        scrollView.addSubview(newPasswordLabel)
        scrollView.addSubview(newPasswordTextfield)
        scrollView.addSubview(confirmPasswordLabel)
        scrollView.addSubview(confirmPasswordTextfield)
        scrollView.addSubview(updateButton)
        
        updateButton.configure(with: InfoTextButton(text: "Update",
                                                  backgroundColor: [UIColor(red: 245/255, green: 133/255, blue: 36/255, alpha: 1.0).cgColor,
                                                                    UIColor(red: 249/255, green: 43/255, blue: 127/255, alpha: 1.0).cgColor]))
        
        let gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureHideKeyboard)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let sizeX: CGFloat = 30
        let newWidth: CGFloat = scrollView.width - 60
        let textfieldHeight: CGFloat = 50.0
        let labelHeight: CGFloat = 17.0
        
        passwordLabel.frame = CGRect(x: sizeX, y: scrollView.safeAreaInsets.top + 30, width: newWidth, height: labelHeight)
        passwordTextfield.frame = CGRect(x: sizeX, y: passwordLabel.bottom, width: newWidth, height: textfieldHeight)
        passwordTextfield.addBottomBorder()
        newPasswordLabel.frame = CGRect(x: sizeX, y: passwordTextfield.bottom + 10, width: newWidth, height: labelHeight)
        newPasswordTextfield.frame = CGRect(x: sizeX, y: newPasswordLabel.bottom, width: newWidth, height: textfieldHeight)
        newPasswordTextfield.addBottomBorder()
        confirmPasswordLabel.frame = CGRect(x: sizeX, y: newPasswordTextfield.bottom + 10, width: newWidth, height: labelHeight)
        confirmPasswordTextfield.frame = CGRect(x: sizeX, y: confirmPasswordLabel.bottom, width: newWidth, height: textfieldHeight)
        confirmPasswordTextfield.addBottomBorder()
        
        
        
        updateButton.frame = CGRect(x: sizeX,
                                    y: scrollView.bottom - 180,
                                    width: newWidth,
                                    height: 70)
    }
    
    
    
    
    private func customNavBar() {
        
        title = "Change Password"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium",size: 24)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancelButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward",
                                                                          withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24, weight: .medium))),
                                                           style: .plain, target: self, action: #selector(didTapBackButton))
      
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.5)
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 20)!],
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
