//
//  ListUsersViewController.swift
//  SeedProject
//
//  Created by intime on 05/06/18.
//  Copyright © 2018 In Time Tec. All rights reserved.
//

import UIKit
import Alamofire

class ListUsersViewController: UIViewController, GetBookTypesParserDelegate {
    
    var parser: GetBooksTypesParser?
    var booksTableView: UITableView?
    var bookTypes: [Book]?
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
    
    func loadTableOfUserTypes() {
        booksTableView = UITableView(frame: self.view.frame)
        booksTableView?.dataSource = self
        booksTableView?.delegate = self
        self.view.addSubview(booksTableView!)
        self.booksTableView?.reloadData()
    }
    
    func didReceiveBookTypes(_ bookTypes: [Book]) {
        print("Shailu \(bookTypes.count)")
        self.bookTypes = bookTypes
        loadTableOfUserTypes()
    }
    
    func confirmDelete(book: String) {
        let alert = UIAlertController(title: "Delete Planet",
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
    
    func handleDeleteBook(alertAction: UIAlertAction!) {
        if let indexPath = deleteBookIndexPath {
            
            let headers: [String: String] = [
                "content-Type" : "application/json"
            ]
            let id = bookTypes![indexPath.row].id!
            let url = URL(string: "http://localhost:3000/books/\(String(describing: id))")
            Alamofire.request(url!, method: .delete,
                              parameters: nil,
                              encoding: JSONEncoding.default,
                              headers: headers).responseString(completionHandler: { (response) in
                                print(response)
            })
            booksTableView?.beginUpdates()
            
            bookTypes?.remove(at: indexPath.row)
            
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

extension ListUsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookTypes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "user")
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "user")
        }
        let user = bookTypes![indexPath.row]
        cell?.textLabel?.text = user.name
        cell?.detailTextLabel?.text = user.bookDescription
        
        return cell!
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            deleteBookIndexPath = indexPath
            confirmDelete(book: bookTypes![indexPath.row].name!)
//            Alamofire.request(url!, method: .delete,
//                              parameters: nil,
//                              encoding: JSONEncoding.default,
//                              headers: headers).responseString(completionHandler: { (response) in
//                print(response)
//                                self.tableOfBooksTypes?.reloadData()
//            })
        }
    }
    
}
