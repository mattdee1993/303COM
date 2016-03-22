//
//  RegisterViewController.swift
//  Depression1
//
//  Created by Matthew Dee on 10/03/2016.
//  Copyright © 2016 Matthew Dee. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let myRootRef = Firebase(url:"https://depression1.firebaseio.com")
    var gender = ""
    var username = ""
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func register(sender: AnyObject) {
        
        
        
        if (usernameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" || ageTextField.text == "")
        {
            
            let alertView = UIAlertController(title: "Cannot register account",
                message: "Please fill in all the fields." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return
        } else {
            newUser()
        }
        
    }
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var picker1: UIPickerView!
    
    @IBOutlet weak var label: UILabel!
    
    
    var Array = ["Male", "Female"]
    
    var PlacementAnswer = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker1.delegate = self
        picker1.dataSource = self
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


   
    //registration and login functions
    func writeData() {
        
        var list = emailTextField.text?.componentsSeparatedByString("@")
        username = list![0]
        let usersRef = myRootRef.childByAppendingPath("Users")
        let update = usersRef.childByAppendingPath(username as String)
        let newUserData = ["Age": ageTextField.text! as String, "Gender": label.text! as String, "Email": emailTextField.text! as String]
        defaults.setObject(username, forKey: "username")
        
        update.updateChildValues(newUserData)
    }
    
    func readData() {
        
        // Read data and reacts to changes
        myRootRef.observeEventType(.Value, withBlock: {
            snapshot in
            print("\(snapshot.key) -> \(snapshot.value)")
        })
        
    }
    
    //this function is called when the register button is pressed
    func newUser() {
        
        myRootRef.createUser(emailTextField.text, password: passwordTextField.text,           withValueCompletionBlock: { error, result in
            
            if error != nil {
                print(error)
                print("There was an error creating the account")
            } else {
                let uid = result["uid"] as? String
                print("Successfully created user account with uid: \(uid)")
                //add a popup here saying account created
                self.writeData()
                self.performSegueWithIdentifier("GoToLogin", sender: self)
                
            }
            
            
        })
        
    }


    //beginning of gender picker view
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Array.count
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func submit(sender: AnyObject) {
        
        if (PlacementAnswer == 0) {
            label.text = "Male"
            
        } else if (PlacementAnswer == 1) {
            
            label.text = "Female"
            
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        PlacementAnswer = row
    }
    
    
}