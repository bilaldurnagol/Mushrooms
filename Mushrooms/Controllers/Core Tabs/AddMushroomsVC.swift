//
//  AddMushroomsVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit
import CoreML
import Vision

class AddMushroomsVC: UIViewController {
    
    private let currentUser = UserDefaults.standard.value(forKey: "currentUser")
    private let userName = UserDefaults.standard.value(forKey: "userName")
    private let profileImageURL = UserDefaults.standard.value(forKey: "imageURL")
    private let userID = UserDefaults.standard.value(forKey: "userID")
    
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
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black
        label.isHidden = true
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .systemGray
        progressView.progressTintColor = .systemGreen
        progressView.isHidden = true
        return progressView
    }()
    
    private let shareButton = TextButton(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    
    private var keyboardHeight = CGFloat()
    private var choosenImage: CIImage?
    private var mushroomName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavBar()
        view.addSubview(scrollView)
        scrollView.addSubview(progressView)
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(postImageView)
        postImageView.addSubview(uploadLabel)
        postImageView.addSubview(addPostButton)
        scrollView.addSubview(resultLabel)
        scrollView.addSubview(contentPostTextView)
        scrollView.addSubview(shareButton)
        
        progressView.setProgress(0.0, animated: false)
        
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
        progressView.frame = CGRect(x: 10,
                                    y: 0,
                                    width: view.width - 20,
                                    height: 20)
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
        resultLabel.frame = CGRect(x: 0,
                                   y: postImageView.bottom - 50,
                                   width: scrollView.width,
                                   height: 50)
    }
    
    private func recognizeImage(image: CIImage) {
        //1)request
        //2)handle
        if let model = try? VNCoreMLModel(for: Mushrooms().model) {
            let request = VNCoreMLRequest(model: model, completionHandler: {[weak self] vnRequest, error in
                guard let strongSelf = self else {return}
                if let result = vnRequest.results as? [VNClassificationObservation] {
                    if result.count > 0 {
                        let topResult = result.first
                        DispatchQueue.main.async {
                            let confidenceLevel = (topResult?.confidence ?? 0 ) * 100
                            let rounded = Int(confidenceLevel * 100) / 100
                            strongSelf.resultLabel.text = "\(rounded)% it's \(topResult!.identifier)"
                            strongSelf.resultLabel.isHidden = false
                            strongSelf.mushroomName = topResult?.identifier
                        }
                    }
                }
            })
            let handle = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handle.perform([request])
                } catch {
                    print("failed")
                }
            }
        }
    }
    
    private func customNavBar() {
        //Custom navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium",size: 24)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancelButton))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 20)!],
                                                                  for: UIControl.State.normal)
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.5)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func fileNameGenerator() -> String {
        //Create uniq filename
        let passwordCharacters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
        let len = 15
        var password = ""
        for _ in 0..<len {
            // generate a random index based on your array of characters count
            let rand = arc4random_uniform(UInt32(passwordCharacters.count))
            // append the random character to your string
            password.append(passwordCharacters[Int(rand)])
        }
        return password
    }
    
    //MARK: -objc funcs
    
    @objc private func didTapCancelButton() {
        //default settings for post image, result and content text
        postImageView.backgroundColor = UIColor(red: 247/255, green: 83/255, blue: 86/255, alpha: 0.1)
        uploadLabel.isHidden = false
        addPostButton.isHidden = false
        postImageView.image = nil
        resultLabel.isHidden = true
        contentPostTextView.text = "Write something here..."
        contentPostTextView.textColor = UIColor.lightGray
        progressView.isHidden = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.5)
    }
    
    @objc private func didTapShareButton() {
        view.endEditing(true)
        progressView.isHidden = false
        for i in 0...5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i/2), execute: {
                self.progressView.setProgress(Float(i * 10)/100, animated: true)
            })
        }
        guard let imageData = postImageView.image?.jpegData(compressionQuality: 1.0),
              let email = currentUser,
              let content = contentPostTextView.text,
              let mushroomName = mushroomName,
              let userID = userID as? Int else {return}
        let uniqFileName = fileNameGenerator()
        StorageManager.shared.uploadImage(with: imageData, fileName: "post_image/\(email)_\(uniqFileName)", completion: {[weak self] result
            in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                strongSelf.didTapCancelButton()
            case .success(let imageURL):
                strongSelf.progressView.setProgress(0.8, animated: true)
                let post = Post(name: mushroomName, content: content, image_url: imageURL, lat: 324.324, long: 23.42, user_id: userID)
                DatabaseManager.shared.sharePost(post: post, completion: { result in
                    if result {
                        strongSelf.progressView.setProgress(1.0, animated: true)
                        strongSelf.didTapCancelButton()
                        strongSelf.dismiss(animated: true, completion: {
                            strongSelf.tabBarController?.selectedIndex = 0
                        })
                    }else {
                        print("fail")
                        strongSelf.didTapCancelButton()
                    }
                })
            }
        })
    }
    
    @objc private func didTapAddPostButton() {
        //choose post method
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


extension AddMushroomsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        postImageView.image = info[.editedImage] as? UIImage
        postImageView.backgroundColor = .clear
        uploadLabel.isHidden = true
        addPostButton.isHidden = true
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.rightBarButtonItem?.tintColor = .systemRed
        
        if let ciImage = CIImage(image: postImageView.image!) {
            self.choosenImage = ciImage
        }
        self.dismiss(animated: true, completion: nil)
        recognizeImage(image: choosenImage!)
    }
}
