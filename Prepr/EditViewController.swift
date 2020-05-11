//
//  EditViewController.swift
//  Prepr
//
//  Created by Shyam on 10/05/20.
//  Copyright © 2020 SOLS247. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class EditViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var updateBtn: UIButton!
    
    var name = ""
    var location = ""
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        nameField.text = name
        locationField.text = location
       
    }
    
    @IBAction func updateClicked(_ sender: Any) {
        
     ref = Database.database().reference().child("users")
////        let key = ref.childByAutoId().key
        guard let userKey = Auth.auth().currentUser?.uid else {
            return
        }
//        let labs = ["id":userKey,
//        "Name": nameField.text! as String,
//        "Location": locationField.text! as String,
//        
//        ref.child(userKey).setValue(labs)
        
        let values = ["place": self.nameField.text]
        ref.child("users").child(userKey).updateChildValues(["Places": values])
        let alert = UIAlertController(title: "Alert", message: "Updated Successfully", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                     self.present(alert, animated: true, completion: nil)
    }

}
