//
//  SignUpViewController.swift
//  Prepr
//
//  Created by Shyam on 09/05/20.
//  Copyright © 2020 SOLS247. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if passwordField.text != confirmPasswordField.text {
        let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
                }
        else{
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!){ (user, error) in
         if error == nil {
            
    let alertController = UIAlertController(title: "Success!", message: "User registered", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "ok", style: .default, handler: { (action) -> Void in
                 self.performSegue(withIdentifier: "signupToHome", sender: self)
                      })
            alertController.addAction(okButton)
            self.present(alertController, animated: true, completion: nil)
                    }
         else{
           let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
           let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
               }
                    }
              }
    
    }

}
