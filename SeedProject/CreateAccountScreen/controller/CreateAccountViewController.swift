//
//  ViewController.swift
//  SeedProject
//
//  Created by intime on 04/06/18.
//  Copyright © 2018 In Time Tec. All rights reserved.
//

import UIKit
import Alamofire
class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        view.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.lightText]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func validateFields() -> Bool {
        var isValid = false
        if (passwordTextField.text?.isEmpty)! ||
            (emailTextField.text?.isEmpty)! ||
            ((confirmPasswordTextField.text?.isEmpty)! ) {
            showOkAlertWithMessage(title: "Alert", message: "fields cant be empty")
            return isValid
        }
        if (confirmPasswordTextField.text! != passwordTextField.text!) {
            showOkAlertWithMessage(title: "Alert", message: "Passwords are not matching")
        }
        if(Utility.isValidEmail(emailString: emailTextField.text!)) {
            isValid = true
        } else {
            showOkAlertWithMessage(title: "Alert", message: "Email format not correct")
        }
        return isValid
    }
    
    @IBAction func createAccount(_ sender: Any) {
        
        if validateFields() {
            let url = URL(string: Endpoints.localRegister)
            
            let parameters: [String: Any]? = [
                "email" : emailTextField.text ?? "" ,
                "password" : confirmPasswordTextField.text ?? ""
            ]
            let headers: [String: String] = [
                "content-Type" : "application/json"
            ]
            let sv = UIViewController.displaySpinner(onView: self.view)
            Alamofire.request(url!, method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default,
                              headers: headers).responseJSON { response in
                UIViewController.removeSpinner(spinner: sv)
                                if (response.response?.statusCode)! ==
                                    HTTPStatusCode.created.rawValue {
                                    print("Created")
                                    self.showOkAlertWithMessage(title: "Success", message: "User successfully created")
                                } else {
                                    self.showOkAlertWithMessage(title: "Failure", message: "User not created")
                                }
                
            }
        }
    }
}
