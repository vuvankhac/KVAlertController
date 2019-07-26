//
//  CustomViewController.swift
//  KVAlertController_Example
//
//  Created by khac.vuvan on 7/26/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    lazy var dismissClosure: (() -> ())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickToDismiss(_ sender: Any) {
        dismissClosure?()
    }
}
