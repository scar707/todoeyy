//
//  CategoryTableViewController.swift
//  todoeyy
//
//  Created by Milinda Sandaruwan on 4/2/19.
//  Copyright © 2019 WIZBIZ International. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryTableViewController: UITableViewController {
let realm=try! Realm()
    
var cat:Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cat?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for:indexPath)
        cell.textLabel?.text=cat?[indexPath.row].name ?? "No Categories"
        
        return cell
    }
    // Mark: - Table view delegate method
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //next
       performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC=segue.destination as! TodoListViewController
        if let indexPath=tableView.indexPathForSelectedRow
        {
            destinationVC.selectedCategory=cat?[indexPath.row]
        }
        
    }
    // Mark: - Data manipulation methods


    @IBAction func addButtonpressed(_ sender: UIBarButtonItem) {
        var nItem=UITextField()
        let alert=UIAlertController(title: "add new", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "add item", style: .default) { (action) in
            
            let newItem=Category()
            newItem.name=nItem.text!
            self.saveItems(category: newItem)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="create"
            nItem=alertTextField
            
            
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    func saveItems(category:Category)
    {
        
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print(error)
            
        }
        self.tableView.reloadData()
    }
    
 func loadItems()
    {
        //let request:NSFetchRequest<Item>=Item.fetchRequest()

        cat=realm.objects(Category.self)
        tableView.reloadData()
    }
  
}
