//
//  ConstAlertBox.swift
//  U-CITY
//
//  Created by semon12694 on 17/4/2561 BE.
//  Copyright © 2561 semon12694. All rights reserved.
//

import Foundation
import UIKit
class ConstAlertBox{
    func showAlertBox(title:String,message:String,ViewController:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle:.alert)
        let resultAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(resultAlert)
        ViewController.present(alert, animated: true, completion: nil)
    }
}
