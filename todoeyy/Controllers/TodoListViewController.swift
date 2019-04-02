//
//  ViewController.swift
//  todoeyy
//
//  Created by Milinda Sandaruwan on 3/31/19.
//  Copyright © 2019 WIZBIZ International. All rights reserved.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController {
var item=[Item]()

let datafilePath1=FileManager.default.urls(for:.documentDirectory,in:.userDomainMask).first
let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(datafilePath1)
        
        //loadItems()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for:indexPath)
        cell.textLabel?.text=item[indexPath.row].title
        let itemn=item[indexPath.row]
        cell.accessoryType=itemn.done ? .checkmark:.none
        
        
        
      
        
        return cell
    }
    
    //MARK - Table view delegate
    /*************************************************/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if item[indexPath.row].done==true
        {
            item[indexPath.row].done=false

            tableView.cellForRow(at: indexPath)?.accessoryType  = .none
            saveItems()
        }
        else{
            item[indexPath.row].done=true
            tableView.cellForRow(at: indexPath)?.accessoryType  = .checkmark
            saveItems()
        }
        
        
      
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Mark - add new items
     
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
          var nItem=UITextField()
        let alert=UIAlertController(title: "add new", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "add item", style: .default) { (action) in
            
            let newItem=Item(context: self.context)
            newItem.title=nItem.text!
            newItem.done=false
            
            self.item.append(newItem)
            self.saveItems()
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="create"
            nItem=alertTextField
            
            
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
   func saveItems()
   {
    
    do{
     try context.save()
    }
    catch{
        print(error)
        
    }
     self.tableView.reloadData()
    }
    
//    func loadItems()
//    {
//        if let data=try? Data(contentsOf: datafilePath!)
//        {
//
//            do{
//
//            }
//            catch{
//                print(error)
//            }
//        }
//    }
}

