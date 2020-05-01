//
//  ProfileViewController.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseAuth
import Kingfisher

class ProfileViewController: UIViewController {
    
    private var profileView = ProfileView()
    
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        configureButtons()
    }
    
    private func configureButtons() {
        profileView.signoutButton.addTarget(self, action: #selector(signout), for: .touchUpInside)
    }
    
    @objc private func signout() {
        do {
            try Auth.auth().signOut()
            UIViewController.showViewController(viewController: LoginViewController())
            
        } catch {
            DispatchQueue.main.async {
                self.showAlert(title: "Error signing out", message: "\(error.localizedDescription)")
            }
        }
    }
    
}
