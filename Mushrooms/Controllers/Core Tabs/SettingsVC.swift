//
//  SettingsVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit

struct SettingsCell {
    let title: String
    let handler: (() -> Void)
    
}

class SettingsVC: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    private var settingsArray = [[SettingsCell]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        customNavBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //remove cell lines
        tableView.separatorStyle = .none
        
        settingsArray.append([
            SettingsCell(title: "Edit Profile", handler: {[weak self] in
                self?.editProfile()
            }),
            SettingsCell(title: "Change Password", handler: {[weak self] in
                self?.changePassword()
            }),
            SettingsCell(title: "Language", handler: {[weak self] in
                self?.editProfile()
            })
        ])
        
        settingsArray.append([
            SettingsCell(title: "Privacy Policy", handler: {[weak self] in
                self?.editProfile()
            }),
            SettingsCell(title: "Contact Us", handler: {[weak self] in
                self?.editProfile()
            }),
            SettingsCell(title: "About App", handler: {[weak self] in
                self?.editProfile()
            }),
            SettingsCell(title: "Logout", handler: {[weak self] in
                self?.logout()
            })
        ])
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    private func customNavBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium",size: 24)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)]
    }
    
    
    //MARK: - Settings handler funcs
    
    private func editProfile() {
        let vc = EditProfileVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    private func changePassword() {
        let vc = ChangePasswordVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    
    private func logout() {
        UserDefaults.standard.setValue(nil, forKey: "currentUser")
        UserDefaults.standard.setValue(nil, forKeyPath: "userName")
        UserDefaults.standard.setValue(nil, forKeyPath: "imageURL")
        DispatchQueue.main.async {
            let vc = LoginVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
    }
    
}
extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = settingsArray[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        if indexPath.row == 3 {
            cell.textLabel?.font = UIFont(name: "Roboto-Medium", size: 20)
        } else {
            cell.textLabel?.font = UIFont(name: "Roboto-Regular", size: 20)
        }
        cell.textLabel?.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        settingsArray[indexPath.section][indexPath.row].handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Account"
        }else {
            return "Other"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    
}
