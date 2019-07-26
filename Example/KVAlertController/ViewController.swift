//
//  ViewController.swift
//  KVAlertController
//
//  Created by Vu Van Khac on 07/25/2019.
//  Copyright (c) 2019 Vu Van Khac. All rights reserved.
//

import KVAlertController
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func clickToShowAlert(_ sender: Any) {
        KVAlertController.shared.showIn(self, title: "KVAlertController", message: "My fullname is Vu Van Khac", cancelTitle: "CANCEL", cancelAction: {
            print("Cancel")
        }, submitTitle: "OK", submitAction: {
            print("OK")
        })
        
//        let customViewController: CustomViewController = CustomViewController.loadFromXib()
//        customViewController.dismissClosure = {
//            KVAlertController.shared.dismiss()
//        }
//
//        KVAlertController.shared.setAlertController(customViewController)
//        KVAlertController.shared.showIn(self)
    }
}

extension UIViewController {
    static func loadFromXib<T: UIViewController>(nibName: String = "") -> T {
        var finalNibName = String(describing: self)
        if !nibName.isEmpty {
            finalNibName = nibName
        }
        
        return T(nibName: finalNibName, bundle: Bundle.main)
    }
}

