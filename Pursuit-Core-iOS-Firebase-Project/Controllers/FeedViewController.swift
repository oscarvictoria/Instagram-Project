//
//  FeedViewController.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FeedViewController: UIViewController {
    
    private var feedView = FeedView()
    
    override func loadView() {
        view = feedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureColllectionView()
    }
    
    private func configureColllectionView() {
        feedView.collectionView.dataSource = self
        feedView.collectionView.delegate = self
        feedView.collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "postCell")
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as? FeedCell else {
            fatalError("could not get cell")
        }
        cell.backgroundColor = .systemRed
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let numberOfItems: CGFloat = 1
        let itemHeight:CGFloat = maxSize.height * 0.50
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1 ) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
