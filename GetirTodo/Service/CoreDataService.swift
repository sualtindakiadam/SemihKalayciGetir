//
//  CoreDataService.swift
//  GetirTodo
//
//  Created by Semih Kalaycı on 11.05.2022.
//

import Foundation
import CoreData
import UIKit

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")


func uppdateCoreData(doneState : Bool? = nil, idString : String, subTitle : String? = nil, title : String? = nil){

    request.returnsObjectsAsFaults = false
    request.predicate = NSPredicate(format: "id = %@", idString)
    do
    {
        let result = try context.fetch(request)
        if let objectUpdate = result.first as? NSManagedObject{
            
            if doneState != nil {
                objectUpdate.setValue(doneState, forKey: "done")

            }
            if subTitle != nil {
                objectUpdate.setValue(subTitle, forKey: "subTitle")

            }
            if title != nil {
                objectUpdate.setValue(title, forKey: "title")

            }
            
        }
        
        try context.save()

    }catch{
        print("error")
    }
}

func saveNewCoreData( title : String, subTitle : String? = ""){
    let newToDo = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)
    
    newToDo.setValue(title, forKey: "title")
    newToDo.setValue(subTitle, forKey: "subTitle")
    newToDo.setValue(false, forKey: "done")
    newToDo.setValue(UUID(), forKey: "id")
        
    
    do{
        try context.save()
        print("Success")

    }catch{
        print("Error!")
        
    }
}

func getCoreDataObject (idString : String) -> [String]{
    

    request.predicate = NSPredicate(format: "id = %@", idString)
    request.returnsObjectsAsFaults = false
    var response : [String] = []

    
    do
    {
        let results = try context.fetch(request)
        if results.count > 0 {
            for result in results as! [NSManagedObject] {
                
                if let title = result.value(forKey: "title") as? String{
                    
                    if let subTitle = result.value(forKey: "subTitle") as? String{
                        
                        response.append(title)
                        response.append(subTitle)
                        
                        print(response)
                       
                    }
                    
                }
                
                                        
            }
        }
    }catch{
        print("error")
        
    }
    
    return response
}

func deleteCoreDataObject( id : UUID){
    
    
    do{
        let results = try context.fetch(request)
        
        if results.count > 0 {
            
            for result in results as! [NSManagedObject]{
                
                if let id = result.value(forKey: "id") as? UUID{
                    if id == id {
                        context.delete(result)
                   
                        
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
    

