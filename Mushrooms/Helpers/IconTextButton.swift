//
//  CustomButton.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 7.12.2020.
//

import Foundation
import UIKit



class IconTextButton: UIButton {
    
    private let buttonText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 24)
        return label
    }()
    
    private let buttonIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(buttonText)
        addSubview(buttonIcon)
        clipsToBounds = true
        layer.cornerRadius = 10.0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: InfoIconTextButton) {
        buttonText.text = viewModel.text
        buttonIcon.image = viewModel.icon
        applyGradient(colors: viewModel.backgroundColor!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonText.sizeToFit()
        let iconSize: CGFloat = 30.0
        buttonIcon.frame = CGRect(x: frame.width - iconSize - 30, y: (frame.size.height - iconSize)/2, width: iconSize, height: iconSize)
        buttonText.frame = CGRect(x: 30, y: 0, width: buttonText.frame.size.width, height: frame.size.height)
    }
}

/*
 family: Roboto
 font: Roboto-Regular
 font: Roboto-Italic
 font: Roboto-Thin
 font: Roboto-ThinItalic
 font: Roboto-Light
 font: Roboto-LightItalic
 font: Roboto-Medium
 font: Roboto-MediumItalic
 font: Roboto-Bold
 font: Roboto-BoldItalic
 font: Roboto-Black
 font: Roboto-BlackItalic
 */
