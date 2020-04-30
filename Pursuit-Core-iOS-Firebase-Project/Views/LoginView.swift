//
//  LoginView.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        usernameTextField.clipsToBounds = true
        usernameTextField.layer.cornerRadius = 5
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 5
    }
    
    public lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "username"
        return textField
    }()
    
    public lazy var passwordTextField: UITextField = {
        let textFiedld = UITextField()
        textFiedld.backgroundColor = .systemBackground
        textFiedld.placeholder = "password"
        textFiedld.isSecureTextEntry = true
        return textFiedld
    }()
    
    public lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    public lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
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
        configureTextField()
        configurePasswordTextField()
        configureLoginButton()
        configureCreateAccountButton()
    }
    
    private func configureTextField() {
        addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            usernameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            usernameTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.030)
        ])
    }
    
    private func configurePasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            passwordTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.030)
            
        ])
    }
    
    private func configureLoginButton() {
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func configureCreateAccountButton() {
        addSubview(createAccountButton)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            createAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}



