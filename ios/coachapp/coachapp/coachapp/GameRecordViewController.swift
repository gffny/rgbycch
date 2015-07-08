//
//  GameRecordViewController.swift
//  coachapp
//
//  Created by John D. Gaffney on 7/7/15.
//  Copyright (c) 2015 gffny.com. All rights reserved.
//

import UIKit

class GameRecordViewController: UIViewController {

    @IBOutlet weak var fieldView: FieldView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fieldView.fieldName.text = "Blah"
        
    }

}

