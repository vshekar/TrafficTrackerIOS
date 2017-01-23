//
//  SettingsDemographicsTableViewController.swift
//  TrafficTracker
//
//  Created by Christian Ellis on 10/17/16.
//  Copyright © 2016 Christian Ellis. All rights reserved.
//

import UIKit

class SettingsDemographicsTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    //save users information
    let defaults: UserDefaults = UserDefaults.standard
    
    @IBOutlet var SettingsDemographics: UITableView!
    
    // Instanttiate Pickers
    var agePicker = UIPickerView()
    var genderPicker = UIPickerView()
    var racePicker = UIPickerView()
    var occupationPicker = UIPickerView()
    var toolBar = UIToolbar() // used for done, and cancel buttons
    
    // Bring in each outlet & Set data values for each picker
    @IBOutlet weak var ageField: UITextField!
    var age:[String] = ["Prefer not to say","0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135"]
    var selectedAge:String = ""
    
    @IBOutlet weak var genderField: UITextField!
    var gender:[String] = ["Prefer not to say", "Male", "Female", "Transgender", "Other"]
    var selectedGender:String = ""
    
    @IBOutlet weak var raceField: UITextField!
    var race:[String] = ["Prefer not to say","Caucasian", "African American", "Hispanic", "Indian", "Asian","Arab","Other"]
    var selectedRace:String = ""
    
    @IBOutlet weak var occupationField: UITextField!
    var occupation:[String]  = ["Prefer not to say","Engineer", "Other"]
    var selectedOccupation:String = ""
    
    var currentPicker:Int = 0 //used later to decide what picker to pull up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //check for users information
        //age info
        if(defaults.object(forKey:"Age") != nil){
            selectedAge = defaults.object(forKey: "Age") as! String
            print("Age key found", selectedAge)
        }else{
            print("Age key not found, creating....")
            defaults.set("", forKey:"Age")
            selectedAge = defaults.object(forKey: "Age") as! String
        }
        //gender info
        if(defaults.object(forKey:"Gender") != nil){
            selectedGender = defaults.object(forKey: "Gender") as! String
            print("Gender key found", selectedGender)
        }else{
            print("Gender key not found, creating...")
            defaults.set("",forKey:"Gender")
            selectedGender = defaults.object(forKey:"Gender") as! String
        }
        //race info
        if (defaults.object(forKey:"Race") != nil){
            selectedRace = defaults.object(forKey:"Race") as! String
            print("Race key found", selectedRace)
        }else{
            print("Race key not found, creating...")
            defaults.set("",forKey:"Race")
            selectedRace = defaults.object(forKey:"Race") as! String
        }
        //occupation info
        if (defaults.object(forKey:"Occupation") != nil){
            selectedOccupation = defaults.object(forKey:"Occupation") as! String
            print("Occupation key found", selectedOccupation)
        }else{
            print("Occupation key not found, creating...")
            defaults.set("",forKey:"Occupation")
            selectedOccupation = defaults.object(forKey:"Occupation") as! String
        }
        //set all delegates and data sources
        agePicker.delegate = self
        agePicker.dataSource = self
        agePicker.showsSelectionIndicator = true
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderPicker.showsSelectionIndicator = true
        racePicker.delegate = self
        racePicker.dataSource = self
        racePicker.showsSelectionIndicator = true
        occupationPicker.delegate = self
        occupationPicker.dataSource = self
        occupationPicker.showsSelectionIndicator = true
        
        //establish a tag for each to decide what picker to pull up into UI
        agePicker.tag = 0
        genderPicker.tag = 1
        racePicker.tag = 2
        occupationPicker.tag = 3
        
        //toolbar settings
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 40/255, green: 60/255, blue: 255/255, alpha: 1) //button color
        toolBar.sizeToFit()
        //done button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SettingsDemographicsTableViewController.donePicker))
        //space inbetween
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        //cancel button
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SettingsDemographicsTableViewController.cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        //make it so that each text field opens up a picker
        ageField.inputView = agePicker
        ageField.inputAccessoryView = toolBar
        genderField.inputView = genderPicker
        genderField.inputAccessoryView = toolBar
        raceField.inputView = racePicker
        raceField.inputAccessoryView = toolBar
        occupationField.inputView = occupationPicker
        occupationField.inputAccessoryView = toolBar
        
        //load user defaults when app starts
        ageField.text = selectedAge
        genderField.text = selectedGender
        raceField.text = selectedRace
        occupationField.text = selectedOccupation
        
        let userDefaultsJSON:String = "User:\"\(selectedAge)\",\"\(selectedGender)\",\"\(selectedRace)\",\"\(selectedOccupation)\""
        print(userDefaultsJSON)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3 //demographics, settings, feedback and bugs
    }
    
    let numberOfRowsAtSection: [Int] = [4,1,1] //4 demographics, 1 settings, 1 feedback and bugs
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        if section < numberOfRowsAtSection.count{
            rows = numberOfRowsAtSection[section]
        }
        return rows
    }
    
    //MARK: - Picker View
    func numberOfComponents( in pickerView: UIPickerView) -> Int {
        return 1
    }
    //goes to the data source of each picker, so they can show up.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            currentPicker = 0
            return age.count
        }
        else if pickerView.tag == 1{
            currentPicker = 1
            return gender.count
        }
        else if pickerView.tag == 2{
            currentPicker = 2
            return race.count
        }
        else if pickerView.tag == 3{
            currentPicker = 3
            return occupation.count
        }
        else{
            return 0
        }
    }

    //brings up name of each row in section such as a picker of ages to scroll through
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentPicker == 0{
            return age[row]
        }
        else if currentPicker == 1{
            return gender[row]
        }
        else if currentPicker == 2{
            return race[row]
        }
        else if currentPicker == 3{
            return occupation[row]
        }
        else{
            return ""
        }
    }
    //has the selected option to appear in the text box
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentPicker == 0 {
            ageField.text = age[row]
            defaults.set(age[row],forKey: "Age")
        }
        else if currentPicker == 1{
            genderField.text = gender[row]
            defaults.set(gender[row],forKey: "Gender")
        }
        else if currentPicker == 2{
            raceField.text = race[row]
            defaults.set(race[row],forKey:"Race")
        }
        else if currentPicker == 3{
            occupationField.text = occupation[row]
            defaults.set(occupation[row],forKey:"Occupation")
        }
    }
    //done button to end picker view
    func donePicker () {
        self.view.endEditing(true)
    }
    //cancel current view and dont put any values in
    func cancelPicker(){
        
        if currentPicker == 0 {
            if ageField == nil{
                ageField.text = nil
            }
        }
        else if currentPicker == 1{
            if genderField == nil{
                genderField.text = nil
            }
        }
        else if currentPicker == 2{
            if raceField == nil{
                raceField.text = nil
            }
        }
        else if currentPicker == 3{
            if occupationField == nil{
                occupationField.text = nil
            }
        }
        self.view.endEditing(true)
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
