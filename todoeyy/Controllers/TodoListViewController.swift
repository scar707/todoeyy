//
//  ViewController.swift
//  todoeyy
//
//  Created by Milinda Sandaruwan on 3/31/19.
//  Copyright © 2019 WIZBIZ International. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
var item=[Item]()
let defaults=UserDefaults.standard
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem=Item()
        newItem.title="item1"
        item.append(newItem)
        
        let newItem1=Item()
        newItem1.title="item1"
        item.append(newItem1)
        
        let newItem2=Item()
        newItem2.title="item1"
        item.append(newItem2)
        
        
        
        
       /*if let items=defaults.array(forKey: "ToDoListArray") as? [String]
       {
        item=items
        }*/
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for:indexPath)
        cell.textLabel?.text=item[indexPath.row].title
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
    
    //Mark - add new items
     
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
          var nItem=UITextField()
        let alert=UIAlertController(title: "add new", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "add item", style: .default) { (action) in
            let newItem=Item()
            newItem.title=nItem.text!
            
            self.item.append(newItem)
            self.defaults.set(self.item,forKey:"ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="create"
            nItem=alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
   
}

