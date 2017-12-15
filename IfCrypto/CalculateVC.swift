//
//  CalculateVC.swift
//  IfCrypto
//
//  Created by Puroof on 12/14/17.
//  Copyright © 2017 ModalApps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CalculateVC: UIViewController {

    var amountBought: String?
    var selectedDay: String?
    var currentCryptoPrice: String?
    var pastCryptoPrice: String?
    var spinnerView: UIView?
    var totalWorth: String?
    
    @IBOutlet weak var resultsLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView = UIViewController.displaySpinner(onView: self.view)
        

        // Do any additional setup after loading the view.
        if let amount = amountBought {
            print("CalculateVC detects amountBought var is: \(amount)")
        }
        
        if let day = selectedDay {
            print("CalculateVC detects selectedDay var is \(day)")
        }
        
        
        
        

    }

    func downloadPrices(completion: @escaping (String) -> Void) {
        getCurrentCryptoPrice() { (price) in
            self.currentCryptoPrice = price
            if self.currentCryptoPrice == "" {
                print("price of crypto today is not determined")
            } else {
                if let currentPrice = self.currentCryptoPrice {
                    print("price of crypto today is: \(currentPrice)")
                    
                    // Could separate these two get prices
                    self.getPastCryptoPrice() { (price) in
                        self.pastCryptoPrice = price
                        if self.pastCryptoPrice == "" {
                            print("price of crypto today is not determined")
                        } else {
                            if let pastPrice = self.pastCryptoPrice {
                                if let day = self.selectedDay {
                                    self.pastCryptoPrice = pastPrice
                                    print("price of crypto from \(day) is: \(pastPrice)")
                                    completion("Finished")
                                }
                            }
                        }
                    }
                }
            }
        }
        
        
        
        
        
    }
    
    
    func updateViewWithResults() {
        if let sv = spinnerView {
            sleep(3)
            totalWorth = calculateProfits()
            if let worth = totalWorth {
                resultsLbl.text = worth
            }
            
            UIViewController.removeSpinner(spinner: sv)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        downloadPrices() { (price) in
            self.updateViewWithResults()
        }
        
        
    }
    
    func getCurrentCryptoPrice(completion: @escaping (String) -> Void) {
        let url = "https://api.coinmarketcap.com/v1/ticker/"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                var json = JSON(value)
                
                
                let price = json[0]["price_usd"].stringValue
                completion(price)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getPastCryptoPrice(completion: @escaping (String) -> Void) {
        var fullUrl = ""
        let baseUrl = "https://api.coindesk.com/v1/bpi/historical/close.json?"
        if let day = self.selectedDay {
            fullUrl = baseUrl + "start=\(day)&end=\(day)"
        }
        
        Alamofire.request(fullUrl, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                if let day = self.selectedDay {
                    var json = JSON(value)
                    let price = json["bpi"][day].stringValue
                    print(price)
                    completion(price)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    func calculateProfits() -> String {
        var profits = "0"
        if let costBefore = self.pastCryptoPrice {
            if let costNow = self.currentCryptoPrice {
                if let investment = self.amountBought {
                    
                    let numberOfCoins:Double = (Double(investment)! / Double(costBefore)!)
                    let totalWorth:Double = Double(numberOfCoins) * Double(costNow)!
                    
                    print("You would now have a total value of $\(totalWorth)")
                    profits = "\(totalWorth)"
                } else {
                    print("Error: Investment is unknown")
                }
            } else {
                print("Error: costNow is unknown")
            }
        } else {
            print("Error: costBefore is unknown")
        }
        
        return profits
    }
}


extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
