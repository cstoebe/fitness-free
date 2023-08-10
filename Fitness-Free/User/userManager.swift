//
//  UserManager.swift
//  Personal Fitness Free
//
//  Created by Conner Stoebe on 5/29/23.
//  This is for data continuity

import Foundation
import UIKit

class UserManager: ObservableObject {
    static let shared = UserManager()
    
    // Add a published currentUser property
    @Published var currentUser: User?

    private init() {
        // Load the user at initialization
        currentUser = loadUser()
    }

    // Save user to UserDefaults
    func saveUser(user: User) {
        let userDictionary: [String: Any] = ["name": user.name,
                                              "age": user.age,
                                              "height": user.height,
                                              "weight": user.weight,
                                              "gender": user.gender,
                                              "picture": user.pictureFileName,
                                              "email": user.email]
        UserDefaults.standard.set(userDictionary, forKey: "userProfile")
        
        // Update currentUser after saving
        currentUser = user
    }

    // Load user from UserDefaults
    func loadUser() -> User? {
        if let userDictionary = UserDefaults.standard.dictionary(forKey: "userProfile") {
            guard let name = userDictionary["name"] as? String,
                  let age = userDictionary["age"] as? Int,
                  let height = userDictionary["height"] as? Double,
                  let weight = userDictionary["weight"] as? Double,
                  let gender = userDictionary["gender"] as? String,
                  let picture = userDictionary["picture"] as? String,
                  let email = userDictionary["email"] as? String else {
                return nil
            }
            return User(name: name, age: age, height: height, weight: weight, gender: gender, pictureFileName: picture, email: email)
        } else {
            return nil
        }
    }
    
    //Profile Picture Functions
    func saveImage(_ image: UIImage) -> String {
        let fileName = UUID().uuidString + ".jpg"
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)
            
        if let data = image.jpegData(compressionQuality: 1.0) {
            try? data.write(to: filePath)
        }
            
        return fileName
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func loadImage(fileName: String) -> UIImage? {
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)
        return UIImage(contentsOfFile: filePath.path)
    }

    //call to get pfp
    func getProfilePicture(for user: User) -> UIImage? {
        return loadImage(fileName: user.pictureFileName)
    }
}
    
                                             
                                             
   
