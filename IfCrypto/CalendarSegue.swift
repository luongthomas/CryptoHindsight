//
//  CalendarSegue.swift
//  IfCrypto
//
//  Created by Puroof on 12/3/17.
//  Copyright © 2017 ModalApps. All rights reserved.
//

import UIKit
import SwiftyJSON
import LGButton
import FSCalendar

class CalendarSegue: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    var selectedDate: String?
    
    
    @IBAction func goBackYear(_ sender: Any) {
        print("Go Back one year")
    }
    
    @IBAction func goBackMonth(_ sender: Any) {
        print("Go back one month")
    }
    

    @IBAction func goForwardMonth(_ sender: Any) {
        print("Go forward one month")
    }
    
    @IBAction func goForwardYear(_ sender: Any) {
        print("Go forward one year")
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "thisIsSegueIdentifier" {
            let viewControllerB = segue.destination as! MainCryptoInput
            if let date = calendar.selectedDate {
                viewControllerB.currentDateString = date.description
                selectedDate = date.description
            }
            
        }
    }
    
    @IBAction func unwind(_ sender: Any) {
        selectedDate = calendar.selectedDate?.description
        dismiss(animated: true) {
            print("unwinded")
        }
    }
    
 
    
    @IBAction func getDay(_ sender: Any) {
        if let date = calendar.selectedDate {
            print(date.description)
            let dateWithoutTime = date.description.components(separatedBy: " ")[0]
            selectedDate = dateWithoutTime
            
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

