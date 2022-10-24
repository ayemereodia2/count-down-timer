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
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Create your event"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor.black
        return label
    }()
        
    let setDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select a date", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.isAccessibilityElement = true
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(configuration: .bordered(), primaryAction: nil)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 4
        button.backgroundColor = .gray
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(configuration: .bordered(), primaryAction: nil)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.isEnabled = false
        return button
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.isAccessibilityElement = true
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        datePicker.backgroundColor = .green
        datePicker.isHidden = true
        return datePicker
    }()
    
    let eventNameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "enter event name"
        field.textAlignment = .left
        field.borderStyle = .roundedRect
        field.backgroundColor = .lightGray
        return field
    }()
    
    let innerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 100
        return stack
    }()
    
    let outerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(outerStack)
        view.backgroundColor = .white
        outerStack.translatesAutoresizingMaskIntoConstraints = false
        innerStack.translatesAutoresizingMaskIntoConstraints = false
        eventNameTextField.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        setDateButton.translatesAutoresizingMaskIntoConstraints = false
        pageTitle.translatesAutoresizingMaskIntoConstraints = false
        datePicker.setContentHuggingPriority(.defaultLow, for: .vertical)
        innerStack.addArrangedSubview(saveButton)
        innerStack.addArrangedSubview(cancelButton)
        
        outerStack.addArrangedSubview(pageTitle)
        outerStack.setCustomSpacing(20, after: pageTitle)
        outerStack.addArrangedSubview(eventNameTextField)
        outerStack.addArrangedSubview(setDateButton)
        outerStack.addArrangedSubview(datePicker)
        outerStack.addArrangedSubview(innerStack)
    
        setupLayout()
        setupViewAction()
    }
    
    private func setupLayout() {
        NSLayoutConstraint(item: innerStack, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.9, constant: 0).isActive = true
        
        NSLayoutConstraint(item: outerStack, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.8, constant: 0).isActive = true
        NSLayoutConstraint(item: eventNameTextField, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.8, constant: 0).isActive = true
        NSLayoutConstraint.activate([
            outerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupViewAction() {
        setDateButton.addTarget(self, action: #selector(setDateButtonTap), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        datePicker.addTarget(self, action: #selector(datePickerAction), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameTextField.delegate = self
        viewModel.delegate = self
    }
    
    @objc func setDateButtonTap() {
        UIView.animate(withDuration: 0.3) {
            self.datePicker.isHidden = false
        }
    }
    
    @objc func saveButtonTap() {
        viewModel.saveNewEvent()
    }
    
    @objc func cancelButtonTap() {
        dismiss(animated: true)
    }
    
    @objc func datePickerAction(_ sender: UIDatePicker) {
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
    
    func showError() {
        dismiss(animated: true)
        let alert = UIAlertController(title: "Invalid date selection", message: "All date and time must be in the future", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}


class SimpleDatePicker: UIDatePicker {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isAccessibilityElement = true
    }
}
