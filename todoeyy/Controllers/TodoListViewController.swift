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
    var selectedCategory:Category?{
        didSet{
           
            loadItems()
        }
    }

//let datafilePath1=FileManager.default.urls(for:.documentDirectory,in:.userDomainMask).first
let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // print(datafilePath1)
        
       
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
        
        item[indexPath.row].done = !item[indexPath.row].done
        
//        context.delete(item[indexPath.row])
//        item.remove(at: indexPath.row)
        saveItems()
       
        
        
      
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
            newItem.parentCategory=self.selectedCategory
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
    
    func loadItems(with request:NSFetchRequest<Item>=Item.fetchRequest(),predicate:NSPredicate?=nil)
    {
        let cPredicate=NSPredicate(format: "parentCategory.name MATCHES %@",selectedCategory!.name!)
        //let request:NSFetchRequest<Item>=Item.fetchRequest()
        
        if let additionalPredicate=predicate{
             request.predicate=NSCompoundPredicate(andPredicateWithSubpredicates: [cPredicate,additionalPredicate])
        }
        else{
          request.predicate=cPredicate
        }
       
        

        do
        {
            item=try context.fetch(request)
            tableView.reloadData()
    }
        catch
        {
            print(error)
        }
    }
    
    
}
//MARK - Search bar methods
extension TodoListViewController:UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request:NSFetchRequest<Item>=Item.fetchRequest()
        let predicate=NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
       
        request.sortDescriptors=[NSSortDescriptor(key: "title", ascending: true)]
        
        
        loadItems(with: request,predicate: predicate)
        
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
