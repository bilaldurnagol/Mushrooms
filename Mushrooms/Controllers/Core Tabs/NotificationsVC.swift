//
//  NotificationsVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit

class NotificationsVC: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.identifier)
        return tableView
    }()
    
    private var notifications: Notifications?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        //remove cell lines
        tableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userID = UserDefaults.standard.value(forKey: "userID") as? Int
        fetchNotifications(userID: userID)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func customNavBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium",size: 24)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)]
        
    }
    
    
    private func fetchNotifications(userID: Int?) {
        // Get all notification to user
        guard let userID = userID else {return}
        DatabaseManager.shared.fetchNotifications(userID: userID, completion: {[weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let notifications):
                strongSelf.notifications = notifications
                strongSelf.tableView.reloadData()
            }
        })
    }
}

extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications?.notifications.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier,
                                                 for: indexPath) as! NotificationTableViewCell
        cell.backgroundColor = UIColor(red: 230/255, green: 229/255, blue: 229/255, alpha: 1.0)
        cell.selectionStyle = .none
        let model = notifications?.notifications[indexPath.row]
        cell.configure(notification: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
