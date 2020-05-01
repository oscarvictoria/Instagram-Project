//
//  DatabaseServices.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

private let db = Firestore.firestore() // reference to FirebaseFirestore database

class DatabaseService {
    static let usersCollection = "users"
    
    static let postCollection = "post"
    
    
    public func createPost(description: String, displaName: String, completion: @escaping (Result <String, Error>)-> ()) {
        
        guard let user = Auth.auth().currentUser else { return }
        
        let documentRef = db.collection(DatabaseService.postCollection).document()
        
        db.collection(DatabaseService.postCollection).document(documentRef.documentID).setData(["description" : description, "postId": documentRef.documentID, "listedDate": Timestamp(date: Date()), "postedBy": displaName, "userId": user.uid]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(documentRef.documentID))
            }
        }
    }
    
    
    
    public func createDatabaseUser(authDataResult: AuthDataResult, completion: @escaping (Result <Bool, Error>)-> ()) {
        
        
        guard let email = authDataResult.user.email else {
            return
        }
        
        db.collection(DatabaseService.usersCollection).document(authDataResult.user.uid).setData(["email" : email, "createdDate": Timestamp(date: Date()), "userId": authDataResult.user.uid]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func updateDatabaseUser(displayName: String, photoURL: String, completion: @escaping (Result<Bool, Error>)->()) {
          
          guard let user = Auth.auth().currentUser else {
              return
          }
          
          db.collection(DatabaseService.usersCollection).document(user.uid).updateData(["photoURL" : photoURL, "displayName": displayName]) { (error) in
              if let error = error {
                  completion(.failure(error))
              } else {
                  completion(.success(true))
              }
          }
      }
}
