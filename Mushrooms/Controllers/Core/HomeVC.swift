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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if currentUser == nil {
            let vc = RegisterVC()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

