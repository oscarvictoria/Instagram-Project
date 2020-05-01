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
    
    override func loadView() {
        view = createView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()

    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(add))
    }
    
    @objc private func add() {
        print("button pressed")
    }
}
