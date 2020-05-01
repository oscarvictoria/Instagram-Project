//
//  CreatePostViewController.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class CreatePostViewController: UIViewController {
    
    private var createView = CreateView()
    
    private let dbService = DatabaseService()
    
    private let storageService = StorageService()
    
    private var selectedImage: UIImage? {
        didSet {
            createView.selectedPhoto.image = selectedImage
        }
    }
    
    private lazy var imagePickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(showPhotoOptions))
        return gesture
    }()
    
    private func addGestures() {
        createView.selectedPhoto.isUserInteractionEnabled = true
        createView.selectedPhoto.addGestureRecognizer(longPressGesture)
    }
    
    override func loadView() {
        view = createView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        addGestures()
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(add))
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
    
    @objc private func add() {
        guard let description = createView.descriptionTextView.text,
            !description.isEmpty,
            let selectedImage = selectedImage else {
                showAlert(title: "Missing Fields", message: nil)
                return
        }
        
        guard let displayName = Auth.auth().currentUser?.displayName else {
            showAlert(title: "Inconplete Profile", message: "Please complete your profile")
            return
        }
        
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: createView.selectedPhoto.bounds)
        
        dbService.createPost(description: description, displaName: displayName) { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Error creating items", message: error.localizedDescription)
                }
            case .success(let documentId):
                self.uploadPhoto(photo: resizedImage, documentId: documentId)
            }
        }
        
    }
    
    private func uploadPhoto(photo: UIImage, documentId: String) {
         storageService.uploadPhoto(postId: documentId, image: photo) { (result) in
             switch result {
             case .failure(let error):
                 DispatchQueue.main.async {
                     self.showAlert(title: "Error uploading photo", message: "\(error.localizedDescription)")
                 }
             case .success(let url):
                self.updateItemImageURL(url, documentsId: documentId)
             }
         }
     }
    
    private func updateItemImageURL(_ url: URL, documentsId: String) {
         // update an existing document on firestore
         Firestore.firestore().collection(DatabaseService.postCollection).document(documentsId).updateData(["imageURL" : url.absoluteString]) { (error) in
             if let error = error {
                 DispatchQueue.main.async {
                     self.showAlert(title: "Fail to update item", message: "\(error.localizedDescription)")
                 }
             } else {
                 DispatchQueue.main.async {
                    self.showAlert(title: "Post Successfully uploaded", message: nil)
                 }
             }
         }
     }
    
    
}
extension CreatePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("could not attain original image")
        }
        selectedImage = image
        dismiss(animated: true, completion: nil)
    }
}
