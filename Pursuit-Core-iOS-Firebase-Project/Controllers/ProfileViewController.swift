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
    
    private let databaseService = DatabaseService()
    
    private let storageService = StorageService()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(showPhotoOptions))
        return gesture
    }()
    
    private var selectedImage: UIImage? {
        didSet {
            profileView.profilePhoto.image = selectedImage
        }
    }
    
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        configureButtons()
        addGestures()
    }
    
    private func addGestures() {
        profileView.profilePhoto.isUserInteractionEnabled = true
        profileView.profilePhoto.addGestureRecognizer(longPressGesture)
    }
    
    private func updateUI() {
        view.backgroundColor = .systemBlue
        guard let user = Auth.auth().currentUser else {
            return
        }
        profileView.displayNameTextField.delegate = self
        profileView.emailLabel.text = user.email
        profileView.displayNameTextField.text = user.displayName
        profileView.profilePhoto.kf.setImage(with: user.photoURL)
    }
    
    private func configureButtons() {
        profileView.signoutButton.addTarget(self, action: #selector(signout), for: .touchUpInside)
        profileView.updateProfileButton.addTarget(self, action: #selector(updateProfile), for: .touchUpInside)
    }
    
    @objc private func showPhotoOptions() {
        let alertController = UIAlertController(title: "Choose Photo Option", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { alertAction in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }
        let photoLibaray = UIAlertAction(title: "Photo Library", style: .default) { alertAction in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        alertController.addAction(photoLibaray)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @objc private func updateProfile() {
        guard let displayName = profileView.displayNameTextField.text,
            !displayName.isEmpty,
            let selectedImage = selectedImage else {
                return
        }
        
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: profileView.profilePhoto.bounds)
        
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        storageService.uploadPhoto(userId: user.uid, image: resizedImage) { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let url):
                self.updateDatabaseUser(displayName: displayName, photoURL: url.absoluteString)
                // TODO: Refactor into its own funtion
                let request = Auth.auth().currentUser?.createProfileChangeRequest()
                request?.displayName = displayName
                request?.photoURL = url
                request?.commitChanges(completion: { (error) in
                    if let error = error {
                        print("error \(error)")
                    } else {
                        DispatchQueue.main.async {
                            self.showAlert(title: "Profile updated", message: "Photo changed")
                        }
                    }
                })
            }
        }
    }
    
    private func updateDatabaseUser(displayName: String, photoURL: String) {
        databaseService.updateDatabaseUser(displayName: displayName, photoURL: photoURL) { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Error updating", message: error.localizedDescription)
                }
            case .success:
                print("success")
            }
        }
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

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        selectedImage = image
        dismiss(animated: true, completion: nil)
    }
    
}
