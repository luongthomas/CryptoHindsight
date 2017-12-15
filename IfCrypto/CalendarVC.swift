//
//  CalendarVC.swift
//  IfCrypto
//
//  Created by Puroof on 12/14/17.
//  Copyright © 2017 ModalApps. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var selectedDayLbl: UILabel!
    var selectedDay: String?
    
    
    @IBAction func goBackYear(_ sender: Any) {
        print("Go back year")
    }
    
    @IBAction func goBackMonth(_ sender: Any) {
        print("Go back month")
    }
    
    @IBAction func goForwardMonth(_ sender: Any) {
        print("Go forward month")
    }
    
    
    @IBAction func goForwardYear(_ sender: Any) {
        print("Go forward Year")
    }
    
    func selectDay() {
        if let date = self.calendar.selectedDate {
            let dateWithoutTime = date.description.components(separatedBy: " ")[0]
            self.selectedDay = dateWithoutTime
        }
    }
    
    
    var currentYear: Int?
    var currentMonth: Int?
    var currentDay: Int?
    
    
    
    func setCurrentDay() {
        let currentDate = Date()
        let currentCalendar = Calendar.current
        currentYear = currentCalendar.component(.year, from: currentDate)
        currentDay = currentCalendar.component(.day, from: currentDate)
        currentMonth = currentCalendar.component(.month, from: currentDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCurrentDay()
        if let month = currentMonth {
            if let year = currentYear {
                if let day = currentDay {
                    selectedDayLbl.text = "\(year)-\(month)-\(day)"
                    selectedDay = selectedDayLbl.text
                }
            }
        }
     
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AmountBoughtSegue") {
            let vc = segue.destination as! BoughtAmountVC
            vc.selectedDay = self.selectedDay
        }
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2013
        dateComponents.month = 9
        dateComponents.day = 5
        
        let calendar = Calendar.current
        let minDate = calendar.date(from: dateComponents)
        return minDate!
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = self.currentYear
        dateComponents.month = self.currentMonth
        dateComponents.day = self.currentDay! - 1
        
        let calendar = Calendar.current
        let minDate = calendar.date(from: dateComponents)
        return minDate!
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if let date = calendar.selectedDate {
            let dateWithoutTime = date.description.components(separatedBy: " ")[0]
            selectedDay = dateWithoutTime
            selectedDayLbl.text = dateWithoutTime
        }
    }

}
