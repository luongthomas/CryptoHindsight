//
//  ViewController.swift
//  IfCrypto
//
//  Created by Puroof on 12/3/17.
//  Copyright © 2017 ModalApps. All rights reserved.
//

import UIKit
import SwiftyJSON
import LGButton
import FSCalendar
import Alamofire

class MainCryptoInput: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var priceOfPastDay = ""
    var pastDateString = ""
    var currentCryptoPriceToday = ""
    
    
    var pickerData = ["Bitcoin", "USD"]
    var myPickerView: UIPickerView!
   
    var amtOfCurrencyToBuy = 0
    var unitsOfCurrency = "USD"
    
    @IBOutlet weak var currentDayLbl: UILabel!
    @IBOutlet weak var TryMeBtn: LGButton!
    
    // Units
    @IBOutlet weak var amountBought: UITextField!
    @IBOutlet weak var UnitTextLabel: UITextField!
    @IBOutlet weak var totalProfitLbl: UILabel!
    @IBOutlet weak var summaryProfitLbl: UILabel!
    
    @IBOutlet weak var priceStatement: UILabel!
    @IBAction func performSegue(_ sender: LGButton) {
        print("Perform segue")
        self.performSegue(withIdentifier: "toMain", sender: self)
    }
    
    
    @IBAction func unwindFromVC(_ sender: UIStoryboardSegue) {
        if sender.source is CalendarSegue {
            if let senderVC = sender.source as? CalendarSegue {
                if let selectedDate = senderVC.selectedDate {
                    pastDateString = selectedDate
                    //getPriceOfDay(day: selectedDate)
                }
                print("Hello from VC")
            }
            
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("Hi, I appeared")
        currentDayLbl.text = pastDateString
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDayLbl.text = "DATE HERE"
        
        
        
        print(currentDayLbl.text ?? "")
        
        
        
        
        
        self.myPickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 150))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = .white
        
        // https://stackoverflow.com/questions/31728680/how-to-make-an-uipickerview-with-a-done-button-swift
        self.UnitTextLabel.inputView = myPickerView
        
        // Toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
//         Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.UnitTextLabel.inputAccessoryView = toolBar
    }
    
    
    func getPriceOfDay(day: String="") {
        print("getting price of day, day=\(day)")
        if day == "" {
            return
        }
        
        if let path = Bundle.main.path(forResource: "bitcoinData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                
                for (key, value):(String, JSON) in jsonObj {
                    //print(key, value)
                    // Way of checking if substring
                    if key.range(of: day) != nil {
                        print("Day: \(day). Price:\(value)")
                        priceOfPastDay = value.stringValue
                    }
                }
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }

    
    @IBAction func calculateProfits(_ sender: Any) {
        print(calculateProfits())
    }
   
    
    //MARK:- Calculating Bitcoin's Price
    func calculateProfits() -> String{
        
        getPriceOfDay(day: pastDateString)
        if priceOfPastDay == "" {
            print("price of past day is not determined")
            return ""
        } else {
            
            print("price of Past Day is: \(priceOfPastDay)")
        }
        
        
        
        // Closures https://stackoverflow.com/questions/43923189/why-does-unexpected-non-void-return-value-in-void-function-happen
        getCurrentBitcoinPrice() { (price) in
            print(price)
            self.currentCryptoPriceToday = price
            
            if self.currentCryptoPriceToday == "" {
                print("price of crypto today is not determined")
            } else {
                print("price of crypto today is: \(self.currentCryptoPriceToday)")
            }
        }
        
        
        if amountBought.text == "" {
            print("value of amount bought is not been entered")
            return ""
        } else {
            print("amount of crypto bought is: \(String(describing: amountBought.text) )")
        }
        
        let costBeforePerCoin = "30"
        let costNowPerCoin = "14000"
        
        let amountMoneyInvested = "50"
        
        let amountCoinsBefore:Double = (Double(amountMoneyInvested)! / Double(costBeforePerCoin)!)
        
        let valueOfTotalCoinsToday:Double = Double(amountCoinsBefore) * Double(costNowPerCoin)!
        
        
        let profits = "\(valueOfTotalCoinsToday)"
        print("You would have \(valueOfTotalCoinsToday)")
        self.totalProfitLbl.text = "\(valueOfTotalCoinsToday)"
        
        return profits
    }
    
    
    func updateUIWithProfits() {
        if calculateProfits() == "" {
            print("will not update UI with profits")
        }
        
        
    }
    
    
    //MARK:- PickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.UnitTextLabel.text = pickerData[row]
    }
    
    //MARK:- TextFiled Detegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUp(UnitTextLabel)
    }
    
  
    
    func pickUp(_ textField: UITextField) {
        
        // UIPickerView
        
        // textField.inputView = self.myPickerView
        
        
        
    }
    
    //MARK:- TextField detelgate
    func textFieldDidEdited(_ textField: UITextField) {
        self.pickUp(UnitTextLabel)
        
    }
    
    
    
    //MARK:- Button
    @objc func doneClick() {
        UnitTextLabel.resignFirstResponder()
        
    }
    
    @objc func cancelClick() {
        UnitTextLabel.resignFirstResponder()
    }

    
    
    //MARK:- API Bitcoin price call
    func getCurrentBitcoinPrice(completion: @escaping (String) -> Void) {
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
    
    
    
}

