//
//  FirstViewController.swift
//  Werewolf
//
//  Created by Charles Yan on 8/23/19.
//  Copyright © 2019 Charles Yan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var playerNamesView: UITextView!
    @IBOutlet weak var rolesView: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var playerNamesarray = [String]()
    var wereRoles = [String]()
    var townsRoles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.playerNamesView.delegate = self
        self.rolesView.delegate = self
        self.scrollView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        
        view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(false)
        
    }
    
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow , object: nil, queue: nil) {
            notification in
            self.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) {
            notification in
            self.keyboardWillHide(notification: notification)
        }
        
        
    }
    
    func keyboardWillShow (notification: Notification) {
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func playTapped(_ sender: Any) {
        if wereRoles.isEmpty && townsRoles.isEmpty {
            randomizeRoles()
        }
        
        performSegue(withIdentifier: "transfer", sender: self)
    }
    
    // TODO: Create an array for inputted player names and shuffle it
    // TODO: Create an array for inputted roles and shuffle it
    // Randomly distribute roles to player names
    
    func randomizeRoles() {
        let playerTextNS = playerNamesView.text! as NSString
        
        self.playerNamesarray = playerTextNS.components(separatedBy: "\n")
        
        if playerNamesarray.last == "" {
            playerNamesarray.removeLast()
        }
        
        playerNamesarray.shuffle()
        
        let rolesTextNS = rolesView.text! as NSString
        var rolesArray = rolesTextNS.components(separatedBy:
     "\n\n")
        
        let wereArray = rolesArray[0].components(separatedBy: "\n")
        var townsArray = rolesArray[1].components(separatedBy: "\n")

        let stringNums: [String] = ["0","1","2","3","4","5","6","7","8","9"]
        
        for element in wereArray {
            let lastelement = element.components(separatedBy: CharacterSet.decimalDigits.inverted)
            
            let role = element.components(separatedBy: " -")
            var x = 0
            
            while stringNums[x] != lastelement.last {
                wereRoles.append(role[0])
                x += 1
            }
        }
        
        if townsArray.last == "" {
            townsArray.removeLast()
        }
        
        for element in townsArray {
            let lastelement = element.components(separatedBy: CharacterSet.decimalDigits.inverted)
            
            let role = element.components(separatedBy: " -")
            var x = 0
            
            while stringNums[x] != lastelement.last {
                townsRoles.append(role[0])
                x += 1
            }
        }
        
        wereRoles.shuffle()
        townsRoles.shuffle()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! DisplayViewController
        dvc.playerNamesarray = self.playerNamesarray
        dvc.wereRoles = self.wereRoles
        dvc.townsRoles = self.townsRoles
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.white
        if textView.text == "Example: Charles" {
            textView.text = ""
        }
        else if textView.text == "First Werewolf Roles, Then Townspeople Roles. Separate the groups by paragraph" {
            textView.text = ""
        }
        textView.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.lightGray
        textView.textColor = UIColor.white
        
    }
    
    func validate(textView: UITextView) -> Bool {
        guard let text = textView.text,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                // this will be reached if the text is nil (unlikely)
                // or if the text only contains white spaces
                // or no text at all
                return false
        }
        
        return true
    }
}




