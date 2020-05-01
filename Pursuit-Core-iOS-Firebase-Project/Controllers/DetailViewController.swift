//
//  DetailViewController.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
    
    }
    

  

}
