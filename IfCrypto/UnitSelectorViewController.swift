//
//  UnitSelectorView.swift
//  IfCrypto
//
//  Created by Puroof on 12/5/17.
//  Copyright © 2017 ModalApps. All rights reserved.
//

import UIKit

class UnitSelectorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var pickerData = ["Bitcoin", "USD", "Chicken Nuggets"]
    var myPickerView: UIPickerView!
    @IBOutlet weak var UnitTextLabel: UITextField!
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = .white
        
        self.UnitTextLabel.inputAccessoryView = myPickerView
    }
    
    
    func pickUp(_ textField: UITextField) {
        
        // UIPickerView
        
//        textField.inputView = self.myPickerView
        
        // Toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
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



