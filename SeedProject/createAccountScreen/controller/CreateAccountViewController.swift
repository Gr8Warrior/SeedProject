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
        view.backgroundColor = UIColor.cyan
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
        if(isValidEmail(emailString: emailTextField.text!)) {
            isValid = true
        } else {
            showOkAlertWithMessage(title: "Alert", message: "Email format not correct")
        }
        return isValid
    }
    
    @IBAction func createAccount(_ sender: Any) {
        
        if validateFields() {
            let url = URL(string: Endpoints.users)
            
            let parameters: [String: Any]? = [
                "id" : emailTextField.text ?? "Test" ,
                "password" : confirmPasswordTextField.text ?? "test"
            ]
            let headers: [String: String] = [
                "content-Type" : "application/json"
            ]
            
            Alamofire.request(url!, method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default,
                              headers: headers).responseJSON { response in
                
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
    
    func isValidEmail(emailString:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailString)
    }
    
    func showOkAlertWithMessage(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertActionStyle.default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
