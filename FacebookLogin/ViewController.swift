//
//  ViewController.swift
//  FacebookLogin
//
//  Created by James Rochabrun on 2/16/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class ViewController: UIViewController,FBSDKLoginButtonDelegate {
    
    let loginButton: FBSDKLoginButton = {
       let button = FBSDKLoginButton()
        button.readPermissions = ["email", "user_friends", "public_profile"]
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        
        if let token = FBSDKAccessToken.current() {
            fetchProfile()
        }
    }
    
    func fetchProfile() {
        print("fecth profile")
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) in
            if error != nil {
                print("error: ", error ?? "error")
                return
            }
            
            if let resultDict = result as? [String: Any], let email = resultDict["email"] as? String {
                print(email)
            }
            
            if let resultDict = result as? NSDictionary,
                let pictureDict = resultDict["picture"] as? NSDictionary,
                let dataDict = pictureDict["data"] as? NSDictionary, let url = dataDict["url"] as? String {
                print(url)
            }
            
        
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("completed login")
        fetchProfile()

    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

}

