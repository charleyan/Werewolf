//
//  DisplayViewController.swift
//  Werewolf
//
//  Created by Charles Yan on 8/28/19.
//  Copyright © 2019 Charles Yan. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    @IBOutlet weak var werwolvesView: UITextView!
    @IBOutlet weak var townsView: UITextView!
    
    var playerNamesarray = [String]()
    var wereRoles = [String]()
    var townsRoles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if !playerNamesarray.isEmpty {
            werwolvesView.text = ""
            townsView.text = ""
            
            var x = 0
            
            for element in wereRoles {
                werwolvesView.text.append("\(playerNamesarray[x]) - \(element)\n")
                x += 1
            }
            
            for element in townsRoles {
                townsView.text.append("\(playerNamesarray[x]) - \(element)\n")
                
                
                x += 1
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
