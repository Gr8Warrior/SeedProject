//
//  Book.swift
//  SeedProject
//
//  Created by Shailendra Suriyal on 07/06/18.
//  Copyright © 2018 In Time Tec. All rights reserved.
//

import UIKit

class Book: NSObject {
    
    var id: Int?
    var name: String?
    var bookDescription: String?
    
    init(dictionary: [String: Any]) {
        id = dictionary["id"]! as? Int
        name = dictionary["name"]! as? String
        bookDescription = dictionary["description"]! as? String
    }
    
}
