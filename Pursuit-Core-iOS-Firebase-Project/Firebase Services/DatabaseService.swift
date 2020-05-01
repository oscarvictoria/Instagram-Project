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
    
//    public func createItem(item: String, price: Double, category: Category, displayName: String, completion: @escaping (Result <String, Error>)-> ()) {
//        guard let user = Auth.auth().currentUser else { return }
//
//        // generate a document reference for our collection
//        let documentRef = db.collection(DatabaseService.itemsCollection).document()
//
//        //create a document for our collection .document(documentPath: string)
//        db.collection(DatabaseService.itemsCollection).document(documentRef.documentID).setData(["itemName": item, "price": price, "itemId":documentRef.documentID, "listedDate": Timestamp(date: Date()), "sellerName": displayName, "aellerId": user.uid, "categoryName": category.name]) { (error) in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(documentRef.documentID))
//            }
//        }
//
//    }
    
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
}
