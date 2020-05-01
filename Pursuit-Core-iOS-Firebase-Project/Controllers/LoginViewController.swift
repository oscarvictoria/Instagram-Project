//
//  LoginViewController.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    private var loginView = LoginView()
    
    private var authSession = AuthenticationSession()
    
    private var databaseService = DatabaseService()
    
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        configureButtons()
        loginView.usernameTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
    
    private func configureButtons() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.createAccountButton.addTarget(self, action: #selector(createAccoutButtonPressed), for: .touchUpInside)
    }
    
    @objc func loginButtonPressed() {
        guard let email = loginView.usernameTextField.text,
            !email.isEmpty,
            let password = loginView.passwordTextField.text,
            !password.isEmpty else {
                self.showAlert(title: "Missing Fields", message: nil)
                return
        }
        
        continueLoginFlow(email: email, password: password)
    }
    
    @objc func createAccoutButtonPressed() {
        guard let email = loginView.usernameTextField.text,
              !email.isEmpty,
              let password = loginView.passwordTextField.text,
              !password.isEmpty else {
                  self.showAlert(title: "Missing Fields", message: nil)
                  return
          }
        
        createAccount(email: email, password: password)
    }
    
    private func continueLoginFlow(email: String, password: String) {
        authSession.signExistingUser(email: email, password: password) { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "error", message: error.localizedDescription)
                }
            case .success:
                DispatchQueue.main.async {
                    self.navigateToMainView()
                }
            }
        }
    }
    
    
    
    private func createAccount(email: String, password: String) {
        authSession.createNewUser(email: email, password: password) { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "error", message: error.localizedDescription)
                }
            case .success(let authDataResult):
                // create a database user only from a new authenticated account
                self.createDatabaseUser(authDataResult: authDataResult)
            }
        }
    }
    
    
    private func createDatabaseUser(authDataResult: AuthDataResult) {
        databaseService.createDatabaseUser(authDataResult: authDataResult) { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Account Error", message: error.localizedDescription)
                }
            case .success:
                DispatchQueue.main.async {
                    self.navigateToMainView()
                }
            }
        }
    }
    
    private func navigateToMainView() {
        UIViewController.showViewController(viewController: MainTabBarController())
    }
    
}

extension UIViewController {
    public static func resetWindow(with rootViewController: UIViewController, apiNumber: Int?) {
        
        
        guard let scene = UIApplication.shared.connectedScenes.first,
            let sceneDelegate = scene.delegate as? SceneDelegate,
            let window = sceneDelegate.window else {
                fatalError("could not reset window rootViewController")
        }
        
        window.rootViewController = rootViewController
    }
    
    public static func showViewController(viewController: UIViewController) {
        resetWindow(with: viewController, apiNumber: nil)
    }
    
  
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
