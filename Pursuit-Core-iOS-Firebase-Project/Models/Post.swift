//
//  Post.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 4/30/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation
import Firebase

struct Post {
    let postDescription: String
    let postId: String
    let imageURL: String
    let postedBy: String
    let listedDate: Timestamp
}

extension Post {
    init(_ dictionary: [String: Any]) {
        self.postDescription = dictionary["postedDescription"] as? String ?? "no item name"
        self.postId = dictionary["postId"] as? String ?? "no post id"
        self.imageURL = dictionary["imageURL"] as? String ?? "no photoURL"
        self.postedBy = dictionary["postedBy"] as? String ?? "no username"
        self.listedDate = dictionary["listedDate"] as? Timestamp ?? Timestamp()
    }
}


