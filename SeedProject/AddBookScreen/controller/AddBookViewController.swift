//
//  AddUserViewController.swift
//  SeedProject
//
//  Created by Shailendra Suriyal on 07/06/18.
//  Copyright © 2018 In Time Tec. All rights reserved.
//

import UIKit
import Alamofire

class AddBookViewController: UIViewController {

    @IBOutlet weak var bookNameTextfield: UITextField!
    
    @IBOutlet weak var bookDescriptionTextView: UITextView!
    
    @IBAction func saveBook(_ sender: Any) {
            let url = URL(string: Endpoints.books)
            
            let parameters: [String: Any]? = [
                "name" : bookNameTextfield.text ?? "" ,
                "description" : bookDescriptionTextView.text ?? ""
            ]
            let headers: [String: String] = [
                "content-Type" : "application/json"
            ]
            
            Alamofire.request(url!, method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default,
                              headers: headers).responseJSON { response in
                                
                                guard let response = response.response else {
                                    self.showOkAlertWithMessage(title: "Failure", message: "Unable to create book")
                                    log.error("Unable to fetch response")
                                    return
                                }
                                if (response.statusCode) ==
                                    HTTPStatusCode.created.rawValue {
                                    print("Created")
                                    //self.showOkAlertWithMessage(title: "Success", message: "Book sucessfully created")
                                    self.showOkAlertWithMessage(title: "Success", message: "Book sucessfully created")
                                    print("Book successfully created")
                                } else {
                                    print("Book not created")
                                    
                                    self.showOkAlertWithMessage(title: "Failure", message: "Unable to create book")
                                    //self.showOkAlertWithMessage(title: "Failure", message: "Book not created")
                                }
                                
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
