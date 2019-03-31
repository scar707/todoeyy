//
//  ViewController.swift
//  todoeyy
//
//  Created by Milinda Sandaruwan on 3/31/19.
//  Copyright © 2019 WIZBIZ International. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
let item=["item1","item2","item3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for:indexPath)
        cell.textLabel?.text=item[indexPath.row]
        return cell
    }
    
    //MARK - Table view delegate
    /*************************************************/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType  == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType  = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType  = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
}

