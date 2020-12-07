//
//  ViewController.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit

class HomeVC: UIViewController {
    
    private let currentUser = UserDefaults.standard.value(forKey: "user")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if currentUser == nil {
            let vc = LoginVC()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    


}

