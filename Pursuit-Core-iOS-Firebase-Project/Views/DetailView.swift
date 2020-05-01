//
//  DetailView.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    public lazy var detailPhoto: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage(systemName: "photo.fill")
        return photo
    }()
    
    public lazy var displayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "name here"
        label.textAlignment = .center
        return label
    }()
    
    public lazy var detailDescription: UITextView = {
        let textView = UITextView()
        return textView
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
        configurePhoto()
        configureLabel()
        configureTextView()
    }
    
    private func configurePhoto() {
        addSubview(detailPhoto)
        detailPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailPhoto.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            detailPhoto.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailPhoto.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailPhoto.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func configureLabel() {
        addSubview(displayNameLabel)
        displayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            displayNameLabel.topAnchor.constraint(equalTo: detailPhoto.bottomAnchor, constant: 20),
            displayNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            displayNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureTextView() {
        addSubview(detailDescription)
        detailDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailDescription.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 40),
            detailDescription.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailDescription.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailDescription.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
}



