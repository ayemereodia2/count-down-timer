//
//  NewEventViewController.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/27.
//

import Foundation
import UIKit

protocol ViewMonitor: AnyObject {
    func didChange(text: String?)
}
class NewEventViewController: UIViewController {
    var viewModel: NewEventViewModel!
        
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var eventNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameTextField.delegate = self
        viewModel.delegate = self
    }
    
    @IBAction func setDateButtonTap(_ sender: UIButton) {
        datePicker.isHidden = false
    }
    
    @IBAction func saveButtonTap(_ sender: UIButton) {
        viewModel.saveNewEvent()
    }
    
    @IBAction func cancelButtonTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        viewModel.didChange(date: sender.date)
    }
    
}


extension NewEventViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.resignFirstResponder() {
            return true
        }
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.didChange(text: textField.text)
    }
}


extension NewEventViewController: NewEventViewDelegate {
    func saveButton(isEnabled: Bool) {
        saveButton.isEnabled = isEnabled
    }
    
    func dismissAfterSaveView() {
        dismiss(animated: true)
    }
}
