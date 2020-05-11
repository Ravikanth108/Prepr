//
//  LabModel.swift
//  Prepr
//
//  Created by Shyam on 10/05/20.
//  Copyright © 2020 SOLS247. All rights reserved.
//

import Foundation

class LabModel {

var location: String?
var name: String?
var date: String?

init(name: String?, date: String?, location: String?){
    self.name = name
    self.date = date
    self.location = location
}
}
