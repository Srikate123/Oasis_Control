//
//  PostData.swift
//  U-CITY
//
//  Created by JayJay on 2/7/19.
//  Copyright © 2019 semon12694. All rights reserved.
//



import Firebase


class PostData {
    var postText: String?
    var postImageViewURL: String?
    var createAt: String?
    var Case:Int
    var userName:String?
    var profileImage:String?
    var statusHavefunClicked:String!
    var postID:String!
    var NumberOfHaveFun:String!
    
    init(postText: String?,postImageURL: String?,createAt: String?,Case:Int!,postOwnerID:String!,postID:String!,statusHavefunClicked:String!,userName: String!,profileImageUrl: String?,NumberOfHaveFun: String?) {
        self.postText = postText
        self.postImageViewURL = postImageURL
        self.createAt = createAt
        self.userName = userName
        self.Case = Case!
        self.statusHavefunClicked = statusHavefunClicked
        print("\n\n\n\(self.statusHavefunClicked)lll\n\n\n")
        self.postID = postID
        self.profileImage = profileImageUrl
        self.NumberOfHaveFun = NumberOfHaveFun!
    }
    
    init(postText: String?,createAt: String?,Case:Int!,postOwnerID:String!,postID:String!,statusHavefunClicked:String!,userName: String!,profileImageUrl: String?,NumberOfHaveFun: String?) {
        self.postText = postText
        self.createAt = createAt
        self.Case = Case!
        self.statusHavefunClicked = statusHavefunClicked
        self.userName = userName
         print("\n\n\n\(self.statusHavefunClicked)lll\n\n\n")
        self.postID = postID
        self.profileImage = profileImageUrl
        self.NumberOfHaveFun = NumberOfHaveFun!
    }

    init(postImageURL: String?,createAt: String?,Case:Int!,postOwnerID:String!,postID:String!,statusHavefunClicked:String!,userName: String!,profileImageUrl: String?,NumberOfHaveFun: String?) {
        self.postImageViewURL = postImageURL
        self.createAt = createAt
        self.Case = Case!
        self.userName = userName
        self.statusHavefunClicked = statusHavefunClicked
        print("\n\n\n\(self.statusHavefunClicked)lll\n\n\n")
        self.postID = postID
        self.profileImage = profileImageUrl
        self.NumberOfHaveFun = NumberOfHaveFun!
    }
}






