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

    var sortParams = [ "Relevancy", "Popularity" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        let row = UserDefaults.standard.integer(forKey: "pickerViewRow")
        pickerView.selectRow(row, inComponent: 0, animated: false)
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
