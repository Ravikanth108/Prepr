//
//  HomeViewController.swift
//  Prepr
//
//  Created by Shyam on 09/05/20.
//  Copyright © 2020 SOLS247. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import GoogleMaps
import GooglePlaces
import CoreLocation

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    
    var labList = [LabModel]()
    var keys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("users")
        guard let userKey = Auth.auth().currentUser?.uid else {
            return
        }
    
        ref.queryOrdered(byChild: "id").queryEqual(toValue: userKey).observe(DataEventType.value, with: { (snapshot) in

                  if snapshot.childrenCount > 0 {
                      
                      self.labList.removeAll()
                      
                    for labs in snapshot.children.allObjects as! [DataSnapshot] {
                        
                          let labObject = labs.value as? [String: AnyObject]
                          let name  = labObject?["Name"]
                          let id  = labObject?["id"]
                          let location = labObject?["Location"]
                          let date = labObject?["Date"]
                        
                          
                        let lab = LabModel(name: name as! String?, date: date as! String?, location: location as! String?)
                          
                          self.labList.append(lab)
                          self.keys.append(labs.key)
                      }
                    
                      self.tableView.reloadData()
                  }
              })
    }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        self.labList.remove(at: indexPath.row)
        let postID =  self.keys.remove(at: indexPath.row)
        Database.database().reference().child("users").child(postID).removeValue()
        tableView.deleteRows(at: [indexPath], with: .fade)
     }
    }
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "LabListTableViewCell", for: indexPath) as! LabListTableViewCell
             
             let lab: LabModel
             
             lab = labList[indexPath.row]
             
        cell.nameLbl.text = ("Name: \(String(describing: lab.name!))")
             cell.dateLbl.text = ("Date: \(String(describing: lab.date!))")
             cell.locationLbl.text = ("Location: \(String(describing: lab.location!))")
                 
             return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "Action Sheet", message: "What do you like to do?", preferredStyle: .alert)
        
            var lab: LabModel
            lab = self.labList[indexPath.row]
        

            let editButton = UIAlertAction(title: "Edit", style: .default, handler: { (action) -> Void in
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "EditViewController")as! EditViewController
                
                vc.name = lab.name!
                vc.location = lab.location!
                self.present(vc, animated: true, completion: nil)
            })

            let mapButton = UIAlertAction(title: "open Map", style: .default, handler: { (action) -> Void in
                    
                
                    let address = lab.location!
                    let geocoder = CLGeocoder()
                   geocoder.geocodeAddressString(address) {
                       placemarks, error in
                       let placemark = placemarks?.first
                       let lat = placemark?.location?.coordinate.latitude
                       let lon = placemark?.location?.coordinate.longitude
                    
                    let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: lon!, zoom: 12.0)
                    let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
                    self.view.addSubview(mapView)

                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
                    marker.map = mapView
                    mapView.setMinZoom(4, maxZoom: 12)
                }
                
            })

        alertController.addAction(editButton)
        alertController.addAction(mapButton)
        present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func logoutClicked(_ sender: Any) {
    do {
           try Auth.auth().signOut()
       }
    catch let signOutError as NSError {
           print ("Error signing out: %@", signOutError)
       }
       
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let initial = storyboard.instantiateInitialViewController()
       UIApplication.shared.keyWindow?.rootViewController = initial
    
    }
    
    @IBAction func addClicked(_ sender: Any) {
    
    }
    
}
