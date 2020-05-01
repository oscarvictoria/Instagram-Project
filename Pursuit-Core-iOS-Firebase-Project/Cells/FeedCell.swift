//
//  FeedCell.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import Kingfisher

class FeedCell: UICollectionViewCell {
    
    override func layoutSubviews() {
          super.layoutSubviews()
        self.layer.cornerRadius = 20.0
      }
    
    var currentPost: Post!
    
    public lazy var imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    public lazy var timeLabel: UILabel = {
        let label = UILabel()
        return label
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
        configureImage()
        configureTimeLabel()
    }
    
    private func configureImage() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func configureTimeLabel() {
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
  
    
    public func configureCell(for post: Post) {
        updateUI(imageURL: post.imageURL, date: post.listedDate.dateValue())
    }
    
    private func updateUI(imageURL: String, date: Date) {
        imageView.kf.setImage(with: URL(string: imageURL))
        timeLabel.text = date.description
    }
    
    
}


