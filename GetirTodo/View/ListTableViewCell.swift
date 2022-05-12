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
    
    @IBAction func DoneSwitchChanged(_ sender: Any) { // Liste elemanlarını Done yada UnDone yapmak için kullanılır
        
        
        if DoneSwitch.isOn == true{
            TitleLabelinCell.textColor = UIColor.systemGreen
             uppdateCoreData(doneState: true, idString: idLabel.text!)
            
        }else{
  
            TitleLabelinCell.textColor = UIColor.black 
            uppdateCoreData(doneState: false, idString: idLabel.text!)
        }
    }
    
}
