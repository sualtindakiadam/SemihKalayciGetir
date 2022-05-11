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
        
        
        if DoneSwitch.isOn == true{
            TitleLabelinCell.textColor = UIColor.gray
             uppdateCoreData(doneState: true, idString: idLabel.text!)
            
        }else{
  
            TitleLabelinCell.textColor = UIColor.black 
            uppdateCoreData(doneState: false, idString: idLabel.text!)
        }
    }
    
}
