//
//  ProfileView.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    public lazy var signoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign out", for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    private func commonInit() {
        confifgureSigOutButton()
    }
    
    private func confifgureSigOutButton() {
        addSubview(signoutButton)
        signoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signoutButton.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            signoutButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}




