//
//  DetailViewController.swift
//  GetirTodo
//
//  Created by Semih Kalaycı on 10.05.2022.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var DescriptionTextView: UITextView!
    @IBOutlet weak var DeleteButton: UIButton!
    
    var selectedTitle = ""
    var selectedId : UUID?
    var selectedIndexPathRow = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveOrUpdateBtton = UIBarButtonItem(title: selectedTitle == "" ? "Save" : "Update" , style: .done, target: self, action: #selector(saveOrUpdateBttonPressed))
            navigationItem.rightBarButtonItem = saveOrUpdateBtton
        DescriptionTextView.layer.borderWidth = 1
        DescriptionTextView.layer.cornerRadius = 5
        DescriptionTextView.layer.borderColor = UIColor.systemGray5.cgColor
        
        if selectedId != nil {
            
            var data = getCoreDataObject(idString: selectedId!.uuidString)
            TitleTextField.text = data[0]
            DescriptionTextView.text = data[1]
            DeleteButton.isHidden = false
            
        }
    }
    
    @IBAction func DeleteButtonClicked(_ sender: Any) {
        
        deleteCoreDataObject(id: selectedId!, indexPathRow : selectedIndexPathRow)
        doneGoBack()

    }
    
    
    @objc func saveOrUpdateBttonPressed(){
        if TitleTextField.text != ""{
            if selectedId == nil{
                saveNewCoreData(title: TitleTextField.text!, subTitle: DescriptionTextView.text)
            }else{
                
                uppdateCoreData(idString: selectedId!.uuidString, subTitle: DescriptionTextView.text ,title: TitleTextField.text)
            }
            
            doneGoBack()
        }else{
            errrAlert(title: "Error !", message: "Title can not be empty")
        }
    }

    func errrAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancleBtn = UIAlertAction(title: "Cancle", style: UIAlertAction.Style.cancel)
        alert.addAction(cancleBtn)
        self.present(alert, animated:true, completion: nil)
    }
    
    func doneGoBack(){
        
        NotificationCenter.default.post(name: NSNotification.Name("newObject"), object: nil)

        navigationController?.popViewController(animated: true)
        
    }
}
