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
    
    private var listener: ListenerRegistration?
    
    private let databaseService = DatabaseService()
    
    private var feedView = FeedView()
    
    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.feedView.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        listener = Firestore.firestore().collection(DatabaseService.postCollection).addSnapshotListener({ (snapshot, error) in
                   if let error = error {
                       DispatchQueue.main.async {
                           self.showAlert(title: "Firestore Error", message: "\(error.localizedDescription)")
                       }
                   } else if let snapshot = snapshot {
                       let post = snapshot.documents.map { Post($0.data()) }
                       self.posts = post
                   }
               })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        listener?.remove()
    }
    
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
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as? FeedCell else {
            fatalError("could not get cell")
        }
        let post = posts[indexPath.row]
        cell.configureCell(for: post)
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let maxWidth: CGFloat = UIScreen.main.bounds.size.width
          let itemWidth: CGFloat = maxWidth * 0.90
          return CGSize(width: itemWidth, height: itemWidth)
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.detailPost = post
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
