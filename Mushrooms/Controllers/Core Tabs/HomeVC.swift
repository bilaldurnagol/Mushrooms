//
//  ViewController.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit

class HomeVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    private let sorryView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.image = UIImage(named: "sorryLogoBig")
        imageView.contentMode = .scaleAspectFit
        imageView.center = view.center
        view.addSubview(imageView)
        
        let sorryLabel = UILabel(frame: CGRect(x: 0, y: imageView.bottom + 10, width: view.width, height: 50))
        sorryLabel.text = "Sorry!"
        sorryLabel.font = UIFont(name: "Roboto-Medium", size: 35)
        sorryLabel.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        sorryLabel.textAlignment = .center
        sorryLabel.numberOfLines = 1
        view.addSubview(sorryLabel)
        
        let sorryContentLabel = UILabel(frame: CGRect(x: 30, y: sorryLabel.bottom, width: view.width - 60, height: 70))
        sorryContentLabel.text = "There is no any result found in your location, Try after sometime to get better results."
        sorryContentLabel.font = UIFont(name: "Roboto-Regular", size: 18)
        sorryContentLabel.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        sorryContentLabel.textAlignment = .center
        sorryContentLabel.numberOfLines = 0
        view.addSubview(sorryContentLabel)
        
        view.isHidden = true
        return view
    }()
    
    private let navBarLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "navBarLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let profileImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let profileView: UIView = {
        let view =  UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        return view
    }()
    
    private var currentUser: String?
    private var userName: String?
    private var profileImageURL: String?
    private var userID: Int?
    private var posts: Posts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObjects()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentUser = UserDefaults.standard.value(forKey: "currentUser") as? String
        userID = UserDefaults.standard.value(forKey: "userID") as? Int
        userName = UserDefaults.standard.value(forKey: "userName") as? String
        profileImageURL = UserDefaults.standard.value(forKey: "imageURL") as? String
        //check auth status
        handleNotAuthenticated()
        customNavBar()
        fetchPosts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        frameObjects()
    }
    
    //MARK: - Custom Objects
    
    private func addObjects() {
        //Add objects to view
        view.addSubview(tableView)
        view.addSubview(sorryView)
    }
    
    private func frameObjects() {
        //Designing objects in view
        tableView.frame = view.bounds
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func customNavBar() {
        //custom navigation bar
        profileImage.image = getImageToURL(imageURL: profileImageURL)
        profileView.addSubview(profileImage)
        
        navigationItem.titleView = navBarLogo
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass",
                                                                           withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20, weight: .medium))),
                                                            style: .plain, target: self, action: #selector(didTapSearchButton))
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.5)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileView)
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.5)
        
    }
    
    
    //MARK:- Database funcs
    private func fetchPosts() {
        //get posts
        DatabaseManager.shared.fetchPosts(completion: {[weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let posts):
                strongSelf.posts = posts
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
                guard let postCount = strongSelf.posts?.post?.count else {return}
                if postCount == 0 {
                    strongSelf.sorryView.isHidden = false
                    strongSelf.tableView.isHidden = true
                }else {
                    strongSelf.tableView.isHidden = false
                    strongSelf.sorryView.isHidden = true
                }
            }
        })
    }
    
    private func getUserInfo(userID: Int?, completion: @escaping (User) -> ()) {
        guard let userID = userID else {return}
        DatabaseManager.shared.userInfo(userID: userID, completion: {result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let user):
                completion(user)
            }
        })
    }
    
    //MARK:- Helper Funcs
    private func getImageToURL(imageURL: String?) -> UIImage? {
        //get image to url
        guard let imageURL = imageURL else {return nil}
        let url = URL(string: imageURL)
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)
    }
    
    private func handleNotAuthenticated(){
        //check user login
        if currentUser == nil {
            //show login page
            let loginVC = LoginVC()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
    
    
    //MARK: - objc func
    @objc private func didTapSearchButton() {
        print("did tap search button")
    }
    
    @objc private func didTapProfileButton() {
        print("did tap profile photo button")
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.post!.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var isLike = false
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.selectionStyle = .none
        let post = posts?.post?[indexPath.row]
        
        if let likes = post?.likes_info?.likes {
            for like in likes {
                if like.user_id == userID {
                    isLike = true
                }else {
                    isLike = false
                }
            }
        }
        
        getUserInfo(userID: post?.user_id, completion: { [weak self] user in
            guard let strongSelf = self else {return}
            
            cell.configure(post: post, user: user, currentUserID: strongSelf.userID, isLike: isLike)
            cell.delegate = self
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.width + 150
    }  
}

extension HomeVC: PostTableViewCellDelegate {
    func clickedLikeButton() {
        DispatchQueue.main.async {
            self.fetchPosts()
            self.tableView.reloadData()
        }
    }
}
