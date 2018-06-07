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
    var tableOfBooksTypes: UITableView?
    var bookTypes: [Book]?
    
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
        tableOfBooksTypes = UITableView(frame: self.view.frame)
        tableOfBooksTypes?.dataSource = self
        tableOfBooksTypes?.delegate = self
        self.view.addSubview(tableOfBooksTypes!)
        self.tableOfBooksTypes?.reloadData()
    }
    
    func didReceiveBookTypes(_ bookTypes: [Book]) {
        print("Shailu \(bookTypes.count)")
        self.bookTypes = bookTypes
        loadTableOfUserTypes()
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
        
        let headers: [String: String] = [
            "content-Type" : "application/json"
        ]
        let id = bookTypes![indexPath.row].id!
        let url = URL(string: "http://localhost:3000/books/\(String(describing: id))")
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            Alamofire.request(url!, method: .delete,
                              parameters: nil,
                              encoding: JSONEncoding.default,
                              headers: headers).responseString(completionHandler: { (response) in
                print(response)
                                self.tableOfBooksTypes?.reloadData()
            })
        }
    }
}
