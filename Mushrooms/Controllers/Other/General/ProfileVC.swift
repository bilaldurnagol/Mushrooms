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
        tableView.register(PostHeaderTableViewCell.self, forCellReuseIdentifier: PostHeaderTableViewCell.identifier)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PostActionsTableViewCell.self, forCellReuseIdentifier: PostActionsTableViewCell.identifier)
        return tableView
    }()
    
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
    
    
    private func customNavBar() {
        title = "Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium",size: 24)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward",
                                                                          withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24, weight: .medium))),
                                                           style: .plain, target: self, action: #selector(didTapBackButton))
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
    }
    
    
    //MARK: - objc funcs
    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
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
            cell.backgroundColor = .lightGray
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .lightGray
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostActionsTableViewCell.identifier, for: indexPath) as! PostActionsTableViewCell
            cell.selectionStyle = .none
            return cell
        }else {
            return UITableViewCell()
        }
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
            imageView.image = UIImage(named: "Bilal")
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = imageView.height/2
            imageView.contentMode = .scaleAspectFill
            view.addSubview(imageView)
            
            let nameLabel = UILabel(frame: CGRect(x: 0, y: imageView.bottom + 15, width: self.view.width, height: 30))
            nameLabel.text = "Bilal Durnagöl"
            nameLabel.font = UIFont(name: "Roboto-Medium", size: 24)
            nameLabel.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
            nameLabel.textAlignment = .center
            view.addSubview(nameLabel)
            
            let emailLabel = UILabel(frame: CGRect(x: 0, y: nameLabel.bottom + 5, width: self.view.width, height: 18))
            emailLabel.text = "bilaldurnagol@gmail.com"
            emailLabel.font = UIFont(name: "Roboto-Regular", size: 15)
            emailLabel.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
            emailLabel.textAlignment = .center
            view.addSubview(emailLabel)
            return view
        }
        return UIView()
       
    }
    
    
    
}
