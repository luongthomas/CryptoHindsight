//
//  IntroVC.swift
//  IfCrypto
//
//  Created by Puroof on 12/14/17.
//  Copyright © 2017 ModalApps. All rights reserved.
//

import UIKit

class IntroVC: UIViewController {

    
    @IBOutlet weak var introLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var introText = "Welcome to CryptoHindsight\n\n You can calculate the amount of \n "
        introText += "Bitcoin you would have earned \n if you had invested earlier!"
        introLabel.text = introText
    }

    override func viewDidAppear(_ animated: Bool) {
        
    }

}
