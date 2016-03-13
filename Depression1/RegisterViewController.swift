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
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func register(sender: AnyObject) {
        newUser()
        
        let username = usernameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if (username != nil || email !=  nil || password != nil)
        {
            let myAlert = UIAlertController(title: "Alert", message: "All fields are required", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Okay", style: .Cancel, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            
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

    func alert(message:String) {
        let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action:UIAlertAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

   
    //registration and login functions
    func writeData() {
        
        let scoreLabel:String = self.label.text! as String
        let genderValue:String = self.label.text! as String
        let usersRef = myRootRef.childByAppendingPath("Users")
        let update = usersRef.childByAppendingPath(usernameTextField.text)
        let newUserData = ["Age": ageTextField.text! as String, "Gender": genderValue, "Score": scoreLabel as String]
        
        
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
                print("There was an error creating the account")
                //add a popup saying account could not be created
            } else {
                let uid = result["uid"] as? String
                print("Successfully created user account with uid: \(uid)")
                //add a popup here saying account created
                self.performSegueWithIdentifier("GoToLogin", sender: self)
                
            }
            
            self.writeData()
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