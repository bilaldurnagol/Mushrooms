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
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
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
    
    private let profileView: UIView = {
        let view =  UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.image = UIImage(named: "Bilal")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        view.addSubview(imageView)
        return view
    }()
    
    private let currentUser = UserDefaults.standard.value(forKey: "user")
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if currentUser != nil {
            let vc = SettingsVC()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    
    
    private func customNavBar() {
        
        navigationItem.titleView = navBarLogo
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass",
                                                                           withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20, weight: .medium))),
                                                            style: .plain, target: self, action: #selector(didTapSearchButton))
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.5)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileView)
       
       navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 0.5)
        
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        
        
        return cell
    }
    
    
}
