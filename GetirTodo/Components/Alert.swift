//
//  Alert.swift
//  GetirTodo
//
//  Created by Semih Kalaycı on 11.05.2022.
//

import Foundation
import UIKit

func errrAlert(title:String,message:String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let cancleBtn = UIAlertAction(title: "Cancle", style: UIAlertAction.Style.cancel)
    alert.addAction(cancleBtn)
    self.present(alert, animated:true, completion: nil)
}
