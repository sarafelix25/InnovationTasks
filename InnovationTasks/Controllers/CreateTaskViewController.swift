//
//  CreateTaskViewController.swift
//  InnovationTasks
//
//  Created by sara.batista.d.felix on 13/07/21.
//

import UIKit

class CreateTaskViewController: UITableViewController, UITextFieldDelegate {
    
    private var datePicker: UIDatePicker = UIDatePicker()
    private var dateFormatter = DateFormatter()
    private var selectedIndexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .dateAndTime
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Task Name"
        } else if section == 1 {
            return "Category"
        }
        
        return "Date and Time"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskDescriptionCell", for: indexPath) as! TaskDescriptionTableViewCell
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateTimeTableViewCell
        cell.dateTimeTextField.inputView = datePicker
        cell.dateTimeTextField.delegate = self
        cell.dateTimeTextField.inputAccessoryView = accessoryView()
        return cell
    }
    // MARK : - Actions buttons
    @IBAction func tapSaveButton(_ sender: Any) {
        print("Task Saved")
    }
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? DateTimeTableViewCell
        if let dateCell = cell {
            self.selectedIndexPath = tableView.indexPath(for: dateCell)
        }
    }
    
    // MARK: - UIView Functions
    func accessoryView() -> UIView {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
        let barItemSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace ,
                                           target: nil,
                                           action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done ,
                                         target: self,
                                         action: #selector(CreateTaskViewController.selectDate))
        
        toolBar.setItems([barItemSpace, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        return toolBar
    }
    
    @objc func selectDate() {
        if let indexPath = self.selectedIndexPath {
            let cell = tableView.cellForRow(at: indexPath) as? DateTimeTableViewCell
            if let dateCell = cell {
                dateCell.dateTimeTextField.text = dateFormatter.string(from: datePicker.date)
                self.view.endEditing(true)
            }
        }
    }
}
