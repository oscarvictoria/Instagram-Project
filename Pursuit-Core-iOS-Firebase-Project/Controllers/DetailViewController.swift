//
//  DetailViewController.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    public var detailPost: Post!
    
    private var detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        updateUI()
    
    }
    
    private func updateUI() {
        guard let post = detailPost else {
            return
        }
        detailView.detailPhoto.kf.setImage(with: URL(string: post.imageURL))
        detailView.displayNameLabel.text = post.postedBy
        detailView.detailDescription.text = post.description

    }
  

}
