//
//  ViewController.swift
//  todoeyy
//
//  Created by Milinda Sandaruwan on 3/31/19.
//  Copyright © 2019 WIZBIZ International. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    var item:Results<Item>?
    let realm=try! Realm()
    var selectedCategory:Category?{
        didSet{
           
            loadItems()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
       // print(datafilePath1)
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for:indexPath)
        
        if  let itemn=item?[indexPath.row]
        {
            cell.textLabel?.text=itemn.title
            
            cell.accessoryType=itemn.done ? .checkmark:.none
        }
        
       
        
        
        
      
        
        return cell
    }
    
    //MARK - Table view delegate
    /*************************************************/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item=item?[indexPath.row]
        {
            do{
                try realm.write{
                    //realm.delete(item)
                    item.done = !item.done
                }
            }
            catch
            {
                print(error)
            }
            
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Mark - add new items
     
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
          var nItem=UITextField()
        let alert=UIAlertController(title: "add new", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "add item", style: .default) { (action) in
           
            if let currentCategory=self.selectedCategory{
                do
                {
                    try self.realm.write {
                        let newItem=Item()
                        newItem.title=nItem.text!
                        newItem.date=Date()
                        currentCategory.items .append(newItem)
                       
                    }
                }
                catch{
                    print(error)
                }
               
            }
            self.tableView.reloadData()
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="create"
            nItem=alertTextField
            
            
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
   
//
    func loadItems()
    {
        item=selectedCategory?.items.sorted(byKeyPath: "date", ascending: true)

            tableView.reloadData()
    }
   
    
//
//
}
//MARK - Search bar methods
extension TodoListViewController:UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        item=item?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count==0
        {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
  
}
