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

class MainCryptoInput: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var currentDateString = ""
   
    var pickerData = ["Bitcoin", "USD", "Chicken Nuggets"]
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
    
    @IBAction func performSegue(_ sender: LGButton) {
        print("Perform segue")
        self.performSegue(withIdentifier: "toMain", sender: self)
    }
    
    
    @IBAction func unwindFromVC(_ sender: UIStoryboardSegue) {
        if sender.source is CalendarSegue {
            if let senderVC = sender.source as? CalendarSegue {
                if let currentDateString = senderVC.selectedDate {
                    print(currentDateString)
                    getPriceOfDay(day: currentDateString)
                }
                print("Hello from VC")
            }
            
        }
    }
    
    
 
    
    @IBAction func hello(_ sender: Any) {
        print("Hello world")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Hi, I appeared")
        currentDayLbl.text = currentDateString
        
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
                    }
                }
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
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
        
        //        textField.inputView = self.myPickerView
        
        
        
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

}

