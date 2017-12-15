//
//  IntroVC.swift
//  IfCrypto
//
//  Created by Puroof on 12/14/17.
//  Copyright © 2017 ModalApps. All rights reserved.
//

import UIKit
import GoogleMobileAds

class IntroVC: UIViewController {

    @IBOutlet weak var bannerAdView: GADBannerView!
    
    @IBOutlet weak var introLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var introText = "Welcome to CryptoHindsight\n\n You can calculate the amount of \n "
        introText += "Bitcoin you would have earned \n if you had invested earlier!"
        introLabel.text = introText
        //bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerAdView.rootViewController = self
        bannerAdView.load(GADRequest())
    }

    override func viewDidAppear(_ animated: Bool) {
        
    }

}
