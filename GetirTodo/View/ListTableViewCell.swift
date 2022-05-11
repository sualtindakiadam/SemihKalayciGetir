//
//  ListTableViewCell.swift
//  GetirTodo
//
//  Created by Semih Kalaycı on 10.05.2022.
//

import UIKit
import CoreData

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var DoneSwitch: UISwitch!
    @IBOutlet weak var TitleLabelinCell: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func DoneSwitchChanged(_ sender: Any) {
        
        print(idLabel.text)
        if DoneSwitch.isOn == true{
            uppdateCoreData(doneState: true, idString: idLabel.text!)
            
        }else{
            uppdateCoreData(doneState: false, idString: idLabel.text!)


        }
        
    }
    
   /* func uppdateState(state : Bool){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        request.returnsObjectsAsFaults = false

        let idSting = idLabel.text
        request.predicate = NSPredicate(format: "id = %@", idSting!)
       
        do
        {
            let result = try context.fetch(request)
            if let objectUpdate = result.first as? NSManagedObject{
                objectUpdate.setValue(state, forKey: "done")
    
            }
            
            try context.save()
    
        }catch{
            print("error")
        }
    }*/
    
    
  
    
}
