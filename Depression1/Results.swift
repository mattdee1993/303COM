//
//  Results.swift
//  Depression1
//
//  Created by Matthew Dee on 26/02/2016.
//  Copyright © 2016 Matthew Dee. All rights reserved.
//

import UIKit

class Results: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        print(score)
        self.scoreLabel.text = String(score)
    }
    

}
