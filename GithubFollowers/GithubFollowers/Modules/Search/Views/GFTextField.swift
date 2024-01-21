//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Israkul Tushaer-81 on 21/1/24.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        backgroundColor = .tertiarySystemFill
        autocorrectionType = .no
        returnKeyType = .go
        placeholder = "Enter a username "
    }
    
}
