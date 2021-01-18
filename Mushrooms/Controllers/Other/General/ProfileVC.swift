//
//  ProfileVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 10.12.2020.
//

import UIKit

class ProfileVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return tableView
    }()
    
    private var currentUser: String?
    private var userName: String?
    private var profileImageURL: String?
    private var userID: Int?
    private var posts: Posts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar()
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentUser = UserDefaults.standard.value(forKey: "currentUser") as? String
        userID = UserDefaults.standard.value(forKey: "userID") as? Int
        userName = UserDefaults.standard.value(forKey: "userName") as? String
        profileImageURL = UserDefaults.standard.value(forKey: "imageURL") as? String
        
        getPosts(currentUserID: userID)
    }
    
    
    private func customNavBar() {
        title = "Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium",size: 24)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward",
                                                                          withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24, weight: .medium))),
                                                           style: .plain, target: self, action: #selector(didTapBackButton))
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
    }
    
    
    private func getPosts(currentUserID: Int?) {
        guard let currentUserID = currentUserID else {return}
        DatabaseManager.shared.fetchPostsCurrentUser(currentUserID: currentUserID, completion: {[weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let posts):
                strongSelf.posts = posts
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }
        })
    }
    
    private func getImageToURL(imageURL: String?) -> UIImage? {
        //get image to url
        guard let imageURL = imageURL else {return nil}
        let url = URL(string: imageURL)
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)
    }
    
    //MARK: - objc funcs
    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts?.post?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = posts?.post![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.configure(post: model, user: nil, currentUserID: nil, isLike: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.width
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return view.height/3
        }else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: self.view.width,
                                            height: self.view.height/3))
            view.backgroundColor = .white
            
            let imageView = UIImageView(frame: CGRect(x: (view.width - 100)/2,
                                                      y: 30,
                                                      width: 100,
                                                      height: 100))
            
            imageView.image = getImageToURL(imageURL: profileImageURL)
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = imageView.height/2
            imageView.contentMode = .scaleAspectFill
            view.addSubview(imageView)
            
            let nameLabel = UILabel(frame: CGRect(x: 0, y: imageView.bottom + 15, width: self.view.width, height: 30))
            nameLabel.text = userName
            nameLabel.font = UIFont(name: "Roboto-Medium", size: 24)
            nameLabel.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
            nameLabel.textAlignment = .center
            view.addSubview(nameLabel)
            
            let emailLabel = UILabel(frame: CGRect(x: 0, y: nameLabel.bottom + 5, width: self.view.width, height: 18))
            emailLabel.text = currentUser
            emailLabel.font = UIFont(name: "Roboto-Regular", size: 15)
            emailLabel.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
            emailLabel.textAlignment = .center
            view.addSubview(emailLabel)
            return view
        }
        return UIView()
    }
}
