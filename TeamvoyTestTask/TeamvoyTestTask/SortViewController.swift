//
//  SortViewController.swift
//  TeamvoyTestTask
//
//  Created by Ростик on 30.07.2023.
//

import Foundation
import UIKit

class SortViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private var sortPicker: UIPickerView!
    
    var sortParams: [String] = ["Popularity", "Relevancy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortPicker.dataSource = self
        sortPicker.delegate = self
    }
}


extension SortViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "popularity"
    }
    
}
