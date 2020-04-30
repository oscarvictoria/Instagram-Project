//
//  MainTabBarController.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    private lazy var feedViewController: FeedViewController = {
      let vc = FeedViewController()
        vc.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return vc
    }()
  
    private lazy var createPostViewController: CreatePostViewController = {
        let vc = CreatePostViewController()
         vc.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "pencil"), tag: 1)
        return vc
    }()
    
    private lazy var profileViewController: ProfileViewController = {
        let vc = ProfileViewController()
        vc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        viewControllers = [UINavigationController(rootViewController: feedViewController), UINavigationController(rootViewController: createPostViewController), profileViewController]
    }
    
    


}
