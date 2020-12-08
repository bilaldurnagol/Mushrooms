//
//  TextButton.swift
//  Mushrooms
//
//  Created by Bilal Durnagöl on 8.12.2020.
//

import UIKit

class TextButton: UIButton {
    
    private let buttonText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 24)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(buttonText)
        clipsToBounds = true
        layer.cornerRadius = 10.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: InfoTextButton) {
        buttonText.text = viewModel.text
        applyGradient(colors: viewModel.backgroundColor!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonText.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    
}
