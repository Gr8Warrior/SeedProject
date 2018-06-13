//
//  User.swift
//  SeedProject
//
//  Created by intime on 06/06/18.
//  Copyright © 2018 In Time Tec. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var id: String?
    var firstName: String?
    var lastName: String?
    var avatar: String?
    
    init(dictionary: [String: Any]) {
        id = dictionary["id"]! as? String
        firstName = dictionary["first_name"]! as? String
        lastName = dictionary["last_name"]! as? String
        avatar = dictionary["avatar"]! as? String
    }
    
}
