//
//  LocationVC.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 8.12.2020.
//

import UIKit

class LocationVC: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Location")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.font = UIFont(name: "Roboto-Medium", size: 32)
        label.textAlignment = .center
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        label.numberOfLines = 1
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enable your location to get better search results in your location."
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        label.textAlignment = .center
        label.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    
    private let enableButton = TextButton(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(enableButton)
        
        
        enableButton.configure(with: InfoTextButton(text: "Enable Location",
                                                  backgroundColor: [UIColor(red: 245/255, green: 133/255, blue: 36/255, alpha: 1.0).cgColor,
                                                                    UIColor(red: 249/255, green: 43/255, blue: 127/255, alpha: 1.0).cgColor]))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 40, y: view.height/2 - 200, width: view.width - 80, height: 200)
        titleLabel.frame = CGRect(x: 0, y: imageView.bottom + 40, width: view.width, height: 40)
        subTitleLabel.frame = CGRect(x: 25, y: titleLabel.bottom, width: view.width - 50, height: 100)
        enableButton.frame = CGRect(x: 30, y: view.bottom - 80, width: view.width - 60, height: 70)
    }
    
}
