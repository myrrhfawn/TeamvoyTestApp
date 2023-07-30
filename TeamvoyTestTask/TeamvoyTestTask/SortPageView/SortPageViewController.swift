//
//  SortPageViewController.swift
//  TeamvoyTestTask
//
//  Created by Ростик on 30.07.2023.
//

import Foundation
import UIKit



class SortPageViewController: UIViewController {

    @IBOutlet private var pickerView: UIPickerView!
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!

    let datePicker = UIDatePicker()
    
    var sortParams = [ "Relevancy", "Popularity" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        let row = UserDefaults.standard.integer(forKey: "pickerViewRow")
        pickerView.selectRow(row, inComponent: 0, animated: false)
        datePicker.preferredDatePickerStyle = .wheels
        fromDate.inputView = datePicker
        toDate.inputView = datePicker
        datePicker.datePickerMode = .date
        
        let fromToolbar = UIToolbar()
        fromToolbar.sizeToFit()
        let toToolbar = UIToolbar()
        toToolbar.sizeToFit()
        
        let fromDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(fromDoneAction))
        let  toDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toDoneAction))
        
        let fromFlexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toFlexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:  nil)
        
        fromToolbar.setItems([fromDoneButton], animated: true)
        toToolbar.setItems([toDoneButton], animated: true)

        fromDate.inputAccessoryView = fromToolbar
        toDate.inputAccessoryView = toToolbar
        
    }
    
    @objc func fromDoneAction(){
        getDateFromPicker(date: "from")
        view.endEditing(true)
    }
    @objc func toDoneAction(){
        getDateFromPicker(date: "to")
        view.endEditing(true)
    }
    
    
    
    func getDateFromPicker(date: String){
        let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-d"
        formatter.dateFormat = "d, MMM y"
        if date == "from"{
            fromDate.text = formatter.string(from: datePicker.date)
            formatter.dateFormat = "yyyy-MM-d"
            NotificationCenter.default.post(name: Notification.Name("setFromDate"), object: formatter.string(from: datePicker.date))
            NotificationCenter.default.post(name: Notification.Name("update"), object: nil)
        } else {
            if formatter.date(from: fromDate.text!) != nil{
                if formatter.date(from: fromDate.text!)! > datePicker.date {
                    toDate.text = "The date can`t be less than initial"
                } else {
                    toDate.text = formatter.string(from: datePicker.date)
                    formatter.dateFormat = "yyyy-MM-d"
                    NotificationCenter.default.post(name: Notification.Name("setToDate"), object: formatter.string(from: datePicker.date))
                    NotificationCenter.default.post(name: Notification.Name("update"), object: nil)
                }
            } else  {
                toDate.text = formatter.string(from: datePicker.date)
                formatter.dateFormat = "yyyy-MM-d"
                NotificationCenter.default.post(name: Notification.Name("setToDate"), object: formatter.string(from: datePicker.date))
                NotificationCenter.default.post(name: Notification.Name("update"), object: nil)
            }
        }

        }
}

extension SortPageViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return sortParams[row]
        } else {
            return "FAIL"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NotificationCenter.default.post(name: Notification.Name("params"), object: sortParams[row].lowercased())
        NotificationCenter.default.post(name: Notification.Name("update"), object: nil)
        UserDefaults.standard.set(row, forKey: "pickerViewRow")
    }
}
