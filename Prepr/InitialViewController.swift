//
//  InitialViewController.swift
//  Prepr
//
//  Created by Shyam on 09/05/20.
//  Copyright © 2020 SOLS247. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class InitialViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool){
     super.viewDidAppear(animated)
     if Auth.auth().currentUser != nil {
       self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
    }
    }
    
    @IBAction func loginClicked(_ sender: Any) {
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
    }
    
}
