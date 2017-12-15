//
//  BoughtAmountVC.swift
//  IfCrypto
//
//  Created by Puroof on 12/14/17.
//  Copyright © 2017 ModalApps. All rights reserved.
//

import UIKit
import LGButton

class BoughtAmountVC: UIViewController, UITextFieldDelegate {
    
    var selectedDay: String?
    
    @IBOutlet weak var calculateBtn: LGButton!
    @IBOutlet weak var boughtAmountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let day = selectedDay {
            print("BoughtAmountVC detects selectedDay var is: \(day)")
        }
        
        
        boughtAmountTextField.keyboardType = .decimalPad
        boughtAmountTextField.textAlignment = .right
        boughtAmountTextField.addDoneButtonOnKeyboard()
        boughtAmountTextField.delegate = self
        //calculateBtn.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        boughtAmountTextField.becomeFirstResponder()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\(String(describing: boughtAmountTextField.text))")
        print("Finished editing")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "CalculateSegue") {
            let vc = segue.destination as! CalculateVC
            vc.amountBought = self.boughtAmountTextField.text
            vc.selectedDay = self.selectedDay
        }
    }
}


extension UITextField{

    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }

    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

