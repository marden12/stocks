//
//  AuthService.swift
//  AIFC project
//
//  Created by Dayana Marden on 18.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//
import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import GSMessages

struct AuthenticationService {
    
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        
        return Storage.storage().reference()
    }
    
    // 3 - We save the user info in the Database
    fileprivate func saveInfo(_ user: User!, password: String,username: String){
        
        let userInfo = ["email": user.email!,"username": username]
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        userRef.setValue(userInfo)
        
//        signIn(user.email!, password: password,vc:)
    }
    
    func logout(){
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                print("LOGOUT SUCCESS")
                (UIApplication.shared.delegate as? AppDelegate)?.loadLoginPages()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    // 4 - We sign in the User
    func signIn(_ email: String, password: String, vs: UIViewController){
        if email == "" || password == "" {
            
            vs.showMessage("Check your email or password,please", type: .success)
            
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    
                    print("You have successfully logged in")
                    (UIApplication.shared.delegate as? AppDelegate)?.loadMainPages()
    
                } else {
                    vs.showMessage("Check your email or password,please", type: .success)
                    
                }
            }
        }
        
    }
    
    // 1 - We create firstly a New User
    func signUp(_ email: String, password: String, username: String,vc: UIViewController){
        if email == "" || password == "" {
            
            vc.showMessage("Check your name,email or password,please", type: .success)
            
        } else {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                
                (UIApplication.shared.delegate as? AppDelegate)?.loadMainPages()
                
                
                }else {
                    vc.showMessage("Check your name,email or password,please", type: .success)
                }
            })
        }
        
    }
    
    func resetPassword(_ email: String){
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                DispatchQueue.main.async(execute: {
                    print("error")
                })
            }else {
                print("error")
            }
        })
        
    }
    
    // 2 - We set the User Info
    fileprivate func saveInfo(_ user: User!, username: String, password: String, country: String, biography: String){
        
        let userInfo = ["email": user.email!, "name": username, "country": country]
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        userRef.setValue(userInfo)
        
//        signIn(user.email!, password: password, vs: <#UIViewController#>)
        
        
    }
    
}
