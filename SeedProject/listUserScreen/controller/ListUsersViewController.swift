//
//  ListUsersViewController.swift
//  SeedProject
//
//  Created by intime on 05/06/18.
//  Copyright © 2018 In Time Tec. All rights reserved.
//

import UIKit

class ListUsersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}
