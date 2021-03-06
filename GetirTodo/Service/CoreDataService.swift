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

var titleArray = [String]()
var idArray = [UUID]()
var doneArray = [Bool]()

func uppdateCoreData(doneState : Bool? = nil, idString : String, subTitle : String? = nil, title : String? = nil){// farklı seneryo koşullarında da kullanılacağı için id harici olanlar optional olarak bırakılmıştır

    request.returnsObjectsAsFaults = false
    request.predicate = NSPredicate(format: "id = %@", idString) // id üzerinden işlem yapacağımız kayıt bulunur
    do
    {
        let result = try context.fetch(request)
        if let objectUpdate = result.first as? NSManagedObject{// sadece done durumu düzenlenme ihtimali olduğu için ağrı fonksiyonlar yazmak yerine boş gelme durumlarına göre kayıt üstünde güncellemeler yapılır
            
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
        print("error  uppdateCoreData")
    }
}

func saveNewCoreData( title : String, subTitle : String? = ""){// yeni data title ve subTitle verisi alınır otomatik olarak bir id ile varsayılan olarak done false olarak kaydedilir
    let newToDo = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)
    
    newToDo.setValue(title, forKey: "title")
    newToDo.setValue(subTitle, forKey: "subTitle")
    newToDo.setValue(false, forKey: "done")
    newToDo.setValue(UUID(), forKey: "id")
        
    
    do{
        try context.save()
        print("Success")

    }catch{
        print("Error! saveNewCoreData")
        
    }
}

func getCoreDataObject (idString : String) -> [String]{
    

    request.predicate = NSPredicate(format: "id = %@", idString)//id referansı ile kayıt bulunur ve return edilir
    request.returnsObjectsAsFaults = false
    var response : [String] = []

    
    do
    {        let results = try context.fetch(request)
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
        print("error getCoreDataObject")

    }
    
    return response
}

func deleteCoreDataObject( id : UUID, indexPathRow : Int){
    
    request.returnsObjectsAsFaults = false
    request.predicate = NSPredicate(format: "id = %@", id.uuidString)//id referansı ile kayıt bulunur ve remove edilir
    
    print(request)

    do{
        let results = try context.fetch(request)
        
        if results.count > 0 {
            
            for result in results as! [NSManagedObject]{
                
                if let id = result.value(forKey: "id") as? UUID{
                    if id == id {
                        context.delete(result)
                   
                        
                        do{
                            titleArray.remove(at: indexPathRow)
                            idArray.remove(at: indexPathRow)
                            doneArray.remove(at: indexPathRow)
                           
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
       print("error DeleteCoreObject")
    }
    
    
}


