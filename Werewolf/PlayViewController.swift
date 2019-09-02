//
//  PlayViewController.swift
//  Werewolf
//
//  Created by Charles Yan on 8/23/19.
//  Copyright © 2019 Charles Yan. All rights reserved.
//

import Foundation
import UIKit

class PlayViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func playPressed(_ sender: Any) {
        
        let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        
        present(mainTabController, animated: true, completion: nil) 
        
    }
    
}
