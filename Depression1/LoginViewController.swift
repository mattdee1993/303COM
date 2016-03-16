//
//  LoginViewController.swift
//  Depression1
//
//  Created by Matthew Dee on 09/03/2016.
//  Copyright © 2016 Matthew Dee. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
  
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func loginButton(sender: AnyObject) {
        Login()
        if (emailTextField.text == "" || passwordTextField.text == "") {
            
            let alertView = UIAlertController(title: "Cannot log into account",
                message: "Please enter an email address and password." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    //this function is called when the login button is pressed
    
    func Login(){
        let ref = Firebase(url: "https://depression1.firebaseio.com")
        ref.authUser(emailTextField.text, password: passwordTextField.text,
            withCompletionBlock: { error, authData in
                if error != nil {
                    print("There was an error logging in to this account")
                } else {
                    print ("Login Successful")
                    self.performSegueWithIdentifier("LoginToQuestion", sender: self)
                }
        })
        
    }
    
    
}