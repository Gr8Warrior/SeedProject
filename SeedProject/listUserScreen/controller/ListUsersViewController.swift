//
//  ListUsersViewController.swift
//  SeedProject
//
//  Created by intime on 05/06/18.
//  Copyright © 2018 In Time Tec. All rights reserved.
//

import UIKit

class ListUsersViewController: UIViewController, GetUserTypesParserDelegate {
    
    var parser: GetUserTypesParser?
    var tableOfUserTypes: UITableView?
    var userTypes: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        edgesForExtendedLayout = UIRectEdge()
        
        parser = GetUserTypesParser()
        parser?.delegate = self
        parser!.getUserTypes()
        
    }
    
    func loadTableOfUserTypes() {
        tableOfUserTypes = UITableView(frame: self.view.frame)
        tableOfUserTypes?.dataSource = self
        tableOfUserTypes?.delegate = self
        self.view.addSubview(tableOfUserTypes!)
        self.tableOfUserTypes?.reloadData()
    }
    
    func didReceiveUserTypes(_ userTypes: [User]) {
        print("Shailu \(userTypes.count)")
        self.userTypes = userTypes
        loadTableOfUserTypes()
    }    /*
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}
