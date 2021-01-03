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
        tableView.register(PostHeaderTableViewCell.self, forCellReuseIdentifier: PostHeaderTableViewCell.identifier)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PostActionsTableViewCell.self, forCellReuseIdentifier: PostActionsTableViewCell.identifier)
        return tableView
    }()
    
    private let sorryLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sorryLogoBig")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let sorryLabel: UILabel = {
        let label = UILabel()
        label.text = "Sorry!"
        label.font = UIFont(name: "Roboto-Medium", size: 35)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let sorryContentLabel: UILabel = {
        let label = UILabel()
        label.text = "There is no any result found in your location, Try after sometime to get better results."
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
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
    
    private let currentUser = UserDefaults.standard.value(forKey: "currentUser")
    private let userName = UserDefaults.standard.value(forKey: "userName")
    private let profileImageURL = UserDefaults.standard.value(forKey: "imageURL")
    private let tableCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar()
        view.addSubview(tableView)
        view.addSubview(sorryLogoImageView)
        view.addSubview(sorryLabel)
        view.addSubview(sorryContentLabel)
        tableView.delegate = self
        tableView.dataSource = self
        
        //check auth status
        handleNotAuthenticated()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        print("bilal durnagol")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableCount == 0 {
            tableView.frame = view.bounds
        }else {
            sorryLogoImageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            sorryLogoImageView.center = view.center
            sorryLabel.frame = CGRect(x: 0, y: sorryLogoImageView.bottom + 10, width: view.width, height: 50)
            sorryContentLabel.frame = CGRect(x: 30, y: sorryLabel.bottom, width: view.width - 60, height: 70)
        }
    }
    
    private func handleNotAuthenticated(){
        if currentUser == nil {
            //show login page
            let loginVC = LoginVC()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
    
    private func customNavBar() {
        profileImage.image = getImage(imageURL: profileImageURL as? String)
        profileView.addSubview(profileImage)
        
        navigationItem.titleView = navBarLogo
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass",
                                                                           withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20, weight: .medium))),
                                                            style: .plain, target: self, action: #selector(didTapSearchButton))
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.5)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileView)
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.5)
        
    }
    
    private func getImage(imageURL: String?) -> UIImage? {
        guard let imageURL = imageURL else {return nil}
        let url = URL(string: imageURL)
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        }else if section == 2 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostHeaderTableViewCell.identifier, for: indexPath) as! PostHeaderTableViewCell
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostActionsTableViewCell.identifier, for: indexPath) as! PostActionsTableViewCell
            cell.selectionStyle = .none
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }else if indexPath.section == 1 {
            return tableView.width
        }else if indexPath.section == 2 {
            return 70
        }else {
            return 0
        }
    }  
}
