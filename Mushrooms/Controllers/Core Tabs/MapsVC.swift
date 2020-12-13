//
//  MapsVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import UIKit

class MapsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar()
    }
    
    
    private func customNavBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium",size: 24)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)]
        
    }
}
