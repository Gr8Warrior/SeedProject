//
//  ListUsersViewController.swift
//  SeedProject
//
//  Created by intime on 05/06/18.
//  Copyright © 2018 In Time Tec. All rights reserved.
//

import UIKit
import Alamofire

class ListBooksViewController: UIViewController, GetBookTypesParserDelegate {
    
    var parser: GetBooksTypesParser?
    var booksTableView: UITableView?
    var bookList: [Book]?
    var deleteBookIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //edgesForExtendedLayout = UIRectEdge()
        
        parser = GetBooksTypesParser()
        parser?.delegate = self
        parser!.getBookTypes()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        parser!.getBookTypes()
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        log.debug("Logout")
        log.error("No")
        log.info("get")
        
        confirmLogout()
    }
    
    func confirmLogout() {
        let alert = UIAlertController(title: "Logout",
                                      message: "Are you sure you want to logout?",
            preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Logout", style: .destructive, handler: handleLogout)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteBook)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width/2.0,
                                                                 y: self.view.bounds.size.height / 2.0,
                                                                 width: 1.0, height: 1.0)
        // CGRect(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func loadTableOfUserTypes() {
        booksTableView = UITableView(frame: self.view.frame)
        booksTableView?.dataSource = self
        booksTableView?.delegate = self
        self.view.addSubview(booksTableView!)
        self.booksTableView?.reloadData()
    }
    
    func didReceiveBookTypes(_ bookTypes: [Book]) {
        
        self.bookList = bookTypes
        loadTableOfUserTypes()
    }
    
    func confirmDelete(book: String) {
        let alert = UIAlertController(title: "Delete Book",
                                      message: "Are you sure you want to permanently delete \(book)?",
            preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteBook)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteBook)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width/2.0,
                                                                 y: self.view.bounds.size.height / 2.0,
                                                                 width: 1.0, height: 1.0)
           // CGRect(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleLogout(alertAction: UIAlertAction!) {
        let viewControllerYouWantToPresent = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "loginNav")
        self.present(viewControllerYouWantToPresent, animated: true, completion: nil)
    }
    
    func handleDeleteBook(alertAction: UIAlertAction!) {
        if let indexPath = deleteBookIndexPath {
            
            let headers: [String: String] = [
                "content-Type" : "application/json"
            ]
            
            guard let bookId = bookList![indexPath.row].id else {
                return
            }
            
           // let id = bookTypes![indexPath.row].id!
            let url = URL(string: "http://localhost:3000/books/\(String(describing: bookId))")
            Alamofire.request(url!, method: .delete,
                              parameters: nil,
                              encoding: JSONEncoding.default,
                              headers: headers).responseString(completionHandler: { (response) in
                                print(response)
            })
            booksTableView?.beginUpdates()
            
            bookList?.remove(at: indexPath.row)
            
            // Note that indexPath is wrapped in an array:  [indexPath]
            booksTableView?.deleteRows(at: [indexPath], with: .automatic)
            
            deleteBookIndexPath = nil
            
            booksTableView?.endUpdates()
        }
    }
    
    func cancelDeleteBook(alertAction: UIAlertAction!) {
        deleteBookIndexPath = nil
    }
    
}

extension ListBooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "user")
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "user")
        }
        let user = bookList![indexPath.row]
        cell?.textLabel?.text = user.name
        cell?.detailTextLabel?.text = user.bookDescription
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "\(String(describing: (bookList?[indexPath.row].name)!))",
            message: "Update name", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = (self.bookList![indexPath.row].name)!
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let headers: [String: String] = [
                "content-Type" : "application/json"
            ]
            let url = URL(string: "http://localhost:3000/books/\((self.bookList![indexPath.row].id)!)")
            let bookName = alert?.textFields![0] // Force unwrapping because we know it exists.
            
            let parameters: [String: Any]? = [
                "name" : bookName?.text! ?? ""
            ]
            Alamofire.request(url!, method: HTTPMethod.patch,
                              parameters: parameters,
                              encoding: JSONEncoding.default,
                              headers: headers).responseString(completionHandler: { (_) in
                                self.bookList![indexPath.row].name = bookName?.text!
                                self.booksTableView?.reloadData()
            })
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            deleteBookIndexPath = indexPath
            confirmDelete(book: bookList![indexPath.row].name!)
        }
    }
    
}
