//
//  ViewController.swift
//  SeedProject
//
//  Created by intime on 04/06/18.
//  Copyright © 2018 In Time Tec. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        view.backgroundColor = UIColor.cyan
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(_ sender: Any) {
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        
        let parameters: [String: Any]? = [
            "email" : emailTextField.text ?? "" ,
            "password" : passwordTextField.text ?? ""
        ]
        let headers: [String: String] = [
            "content-Type" : "application/json"
        ]
        
        let url = URL(string: Endpoints.login)
        Alamofire.request(url!, method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .responseJSON { (response) in
                            print(response)
                let viewControllerYouWantToPresent = UIStoryboard(name: "ListUsers", bundle: nil)
                    .instantiateViewController(withIdentifier: "ListUsersViewController")
                self.present(viewControllerYouWantToPresent, animated: true, completion: nil)
        }
    }
}
