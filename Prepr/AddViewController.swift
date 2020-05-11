//
//  AddViewController.swift
//  Prepr
//
//  Created by Shyam on 10/05/20.
//  Copyright © 2020 SOLS247. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class AddViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var locationField: UITextField!
        
    @IBOutlet weak var addBtn: UIButton!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addClicked(_ sender: Any) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM - dd - yyyy"
        let result = formatter.string(from: date)
  
        ref = Database.database().reference().child("users")
        let key = ref.childByAutoId().key
        guard let userKey = Auth.auth().currentUser?.uid else {
            return
        }
        let labs = ["id":userKey,
        "Name": nameField.text! as String,
        "Location": locationField.text! as String,
        "Date": result
        ]
        ref.child(key!).setValue(labs)
        let alert = UIAlertController(title: "Alert", message: "Added Successfully", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                     self.present(alert, animated: true, completion: nil)
    }
}
