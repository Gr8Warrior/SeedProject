//
//  ListUsersViewController.swift
//  SeedProject
//
//  Created by intime on 05/06/18.
//  Copyright © 2018 In Time Tec. All rights reserved.
//

import UIKit

class ListUsersViewController: UIViewController, GetBookTypesParserDelegate {
    
    var parser: GetBooksTypesParser?
    //var booksParser: GetBooksTypesParser?
    var tableOfUserTypes: UITableView?
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
        
    }
    
    func loadTableOfUserTypes() {
        tableOfUserTypes = UITableView(frame: self.view.frame)
        tableOfUserTypes?.dataSource = self
        tableOfUserTypes?.delegate = self
        self.view.addSubview(tableOfUserTypes!)
        self.tableOfUserTypes?.reloadData()
    }
    
    func didReceiveBookTypes(_ bookTypes: [Book]) {
        print("Shailu \(bookTypes.count)")
        self.bookTypes = bookTypes
        loadTableOfUserTypes()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
    
}
