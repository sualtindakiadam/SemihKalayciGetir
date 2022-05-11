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
    @IBOutlet weak var DescriptionTextField: UITextField!
    
    var selectedTitle = ""
    var selectedId : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveOrUpdateBtton = UIBarButtonItem(title: selectedTitle == "" ? "Save" : "Update" , style: .done, target: self, action: #selector(saveOrUpdateBttonPressed))
            navigationItem.rightBarButtonItem = saveOrUpdateBtton
        
        if selectedId != nil {
            
            var data = getCoreDataObject(idString: selectedId!.uuidString)
            TitleTextField.text = data[0]
            DescriptionTextField.text = data[1]
            
        }
    }
    
    @objc func saveOrUpdateBttonPressed(){
        if TitleTextField.text != ""{
            if selectedId == nil{
                saveNewCoreData(title: TitleTextField.text!, subTitle: DescriptionTextField.text)
            }else{
                
                uppdateCoreData(idString: selectedId!.uuidString, subTitle: DescriptionTextField.text ,title: TitleTextField.text)
            }
            
            NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)

            navigationController?.popViewController(animated: true)
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
}
