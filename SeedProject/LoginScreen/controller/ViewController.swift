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
        //view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func createAccount(_ sender: Any) {
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        
        if validateFields() {
            let sv = UIViewController.displaySpinner(onView: self.view)
            
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
                    UIViewController.removeSpinner(spinner: sv)
                    let viewControllerYouWantToPresent = UIStoryboard(name: "ListBooks", bundle: nil)
                        .instantiateViewController(withIdentifier: "ListBooks")
                    self.present(viewControllerYouWantToPresent, animated: true, completion: nil)
            }
        }
    }
    
    func validateFields() -> Bool {
        var isValid = false
        if (passwordTextField.text?.isEmpty)! ||
            (emailTextField.text?.isEmpty)! {
            showOkAlertWithMessage(title: Strings.alert.rawValue, message: Strings.no_empty.rawValue)
            return isValid
        }
        if(Utility.isValidEmail(emailString: emailTextField.text!)) {
            isValid = true
        } else {
            showOkAlertWithMessage(title: Strings.alert.rawValue, message: Strings.email_format_incorrect.rawValue)
        }
        return isValid
    }
}
