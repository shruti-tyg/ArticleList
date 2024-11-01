//
//  AppData.swift
//  ArticleList
//
//  Created by shruti tyagi on 01/11/24.
//



import Foundation

class AppData {
    
    public var likedArticle : NSArray {
           get {
               return UserDefaults.standard.object(forKey: "likeArticle") as! NSArray
           }
           set {
               let defaults = UserDefaults.standard
               defaults.set(newValue, forKey: "likeArticle")
               defaults.synchronize()
           }
       }
   
}
