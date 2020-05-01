//
//  CreateView.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class CreateView: UIView {
    
    private lazy var descriptionTextView:UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        return textView
    }()
    
    private lazy var selectedPhoto: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage(systemName: "photo.fill")
        photo.contentMode = .scaleAspectFill
        return photo
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
        configureTextView()
        configurePhoto()
    }
    
    private func configureTextView() {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
            
        ])
    }
    
    private func configurePhoto() {
        addSubview(selectedPhoto)
        selectedPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedPhoto.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            selectedPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            selectedPhoto.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            selectedPhoto.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
        
    }
    
    
}



