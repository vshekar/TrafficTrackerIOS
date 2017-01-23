//
//  TextFieldPicker.swift
//  TrafficTracker
//
//  Created by Christian Ellis on 10/18/16.
//  Copyright © 2016 Christian Ellis. All rights reserved.
//

import UIKit

class TextFieldPicker: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet var textField: UITextField
    var data = ["1","2","50"]
    var picker = UIPickerView()
    let toolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        picker.showsSelectionIndicator = true
        
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 40/255, green: 60/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TextFieldPicker.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TextFieldPicker.cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
    }
    
    func numberOfComponents( in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func donePicker () {
        self.view.endEditing(true)
    }
    
    func cancelPicker(){
        textField.text = nil
        self.view.endEditing(true)
    }
}
