//
//  Results.swift
//  Depression1
//
//  Created by Matthew Dee on 26/02/2016.
//  Copyright © 2016 Matthew Dee. All rights reserved.
//

import UIKit
import Firebase

class Results: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    let usersRef = Firebase(url:"depression1.firebaseio.com/")
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidAppear(animated: Bool) {
        var finalScore = 0
        for items in Score{
            finalScore += items
        }
        
        self.scoreLabel.text = String(finalScore)
        print("the final score")
        updateScore(finalScore)
    }
    
    func updateScore(score:Int){
        let username:String = defaults.objectForKey("username") as! String
        print(username)
        let hopperRef = usersRef.childByAppendingPath(("Users/\(username)"))
        let nickname:NSDictionary = ["score":score]
        hopperRef.updateChildValues(nickname as [NSObject : AnyObject])
    }
    

}
