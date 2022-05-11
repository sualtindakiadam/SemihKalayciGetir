//
//  ViewController.swift
//  GetirTodo
//
//  Created by Umut Afacan on 21.12.2020.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

     
    @IBOutlet weak var ListTableView: UITableView!
    
    var titleArray = [String]()
    var idArray = [UUID]()
    var doneArray = [Bool]()
    var choosenTitle = ""
    var choosenId : UUID?
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        ListTableView.delegate = self
        ListTableView.dataSource = self
        

        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newPlace"), object: nil )
       }
    
    @objc func getData(){
        request.returnsObjectsAsFaults = false

        
        do{
            let results = try context.fetch(self.request)
            
            if results.count > 0 {
                self.titleArray.removeAll(keepingCapacity: false)
                self.idArray.removeAll(keepingCapacity: false)
                self.doneArray.removeAll(keepingCapacity: false)

                
                for result in results as! [NSManagedObject]{
                    if let title = result.value(forKey: "title") as? String{
                        self.titleArray.append(title)
                        
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID{
                        self.idArray.append(id)
                        
                    }
                    if let done = result.value(forKey: "done") as? Bool{
                        self.doneArray.append(done)
                        
                    }
                    
                    ListTableView.reloadData()
                    
                    
                }
            }
            
            
        }catch{
            print("error")
        }
    }
    
    @objc func addButtonClicked(){
        choosenTitle = ""
        performSegue(withIdentifier: "toDetail", sender: "add")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListTableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! ListTableViewCell
        
        cell.TitleLabelinCell.text = titleArray[indexPath.row]
        cell.DoneSwitch.isOn = doneArray[indexPath.row]
        cell.idLabel.text = idArray[indexPath.row].uuidString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenTitle = titleArray[indexPath.row]
        choosenId = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" && sender == nil {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.selectedId = choosenId
            destinationVC.selectedTitle = choosenTitle
        }
    }
    
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
               
               
               do{
                   let results = try context.fetch(self.request)
                   
                   if results.count > 0 {
                       
                       for result in results as! [NSManagedObject]{
                           
                           if let id = result.value(forKey: "id") as? UUID{
                               if id == idArray[indexPath.row] {
                                   context.delete(result)
                                   titleArray.remove(at: indexPath.row)
                                   idArray.remove(at: indexPath.row)
                                   doneArray.remove(at: indexPath.row)
                                   self.ListTableView.reloadData()
                                   
                                   do{
                                       try context.save()
                                       
                                   }catch{
                                       print("delete error")
                                       
                                   }
                                   
                                   break
                                   
                               }
                               
                           }
                           
                           
                       }
                       
                   }
                   
                   
                   
                   
               }catch{
                   
               }
              
               
               
           }
    }
}
