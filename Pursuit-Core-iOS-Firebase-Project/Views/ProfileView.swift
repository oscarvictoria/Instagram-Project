//
//  ProfileView.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    override func layoutSubviews() {
           super.layoutSubviews()
           profilePhoto.clipsToBounds = true
           profilePhoto.layer.cornerRadius = 90
       }
    
    public lazy var profilePhoto: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage(systemName: "person.fill")
        photo.contentMode = .scaleAspectFill
        photo.backgroundColor = .systemBackground
        return photo
    }()
    
    public lazy var displayNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "displayname"
        return textField
    }()
    
    public lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "email"
        return label
    }()
    
    public lazy var updateProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update Profile", for: .normal)
        return button
    }()
    
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
        configureProfilePhoto()
        configureDisplayName()
        configureEmailLabel()
        configureUpdateProfileButton()
        confifgureSigOutButton()
    }
    
    private func configureProfilePhoto() {
        addSubview(profilePhoto)
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePhoto.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            profilePhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            profilePhoto.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            profilePhoto.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func configureDisplayName() {
        addSubview(displayNameTextField)
        displayNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            displayNameTextField.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 20),
            displayNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            displayNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60)
        ])
    }
    
    private func configureEmailLabel() {
        addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: displayNameTextField.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func configureUpdateProfileButton() {
        addSubview(updateProfileButton)
        updateProfileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            updateProfileButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            updateProfileButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func confifgureSigOutButton() {
        addSubview(signoutButton)
        signoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signoutButton.topAnchor.constraint(equalTo: updateProfileButton.bottomAnchor, constant: 20),
            signoutButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    
    

    
}




