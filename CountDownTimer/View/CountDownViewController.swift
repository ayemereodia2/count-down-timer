//
//  CountDownViewController.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/10/09.
//

import UIKit

class CountDownViewController: UIViewController {
    var viewModel: CountDownViewModel!
    
    @IBOutlet weak var numberOfWeeksLabel: UILabel!
    @IBOutlet weak var numberOfWeeksHeadingLabel: UILabel!
    
    @IBOutlet weak var numberOfDaysLabel: UILabel!
    @IBOutlet weak var numberOfDaysHeadingLabel: UILabel!
    
    @IBOutlet weak var numberOfTimeLabel: UILabel!
    @IBOutlet weak var numberOfTimeHeadingLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.startCount()
        viewModel.updateEventTile()
    }
    
    @IBAction func deleteButtonTap(_ sender: UIButton) {
        
    }
    
    @IBAction func CancelButtonTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
}


extension CountDownViewController: CountDownUpdaterDelegate {
    func updateCounter(with count: String) {
        numberOfTimeLabel.text = count
    }
    
    func updatePeriod(days: Int, and weeks: Int) {
        numberOfWeeksLabel.text = "\(weeks)"
        numberOfDaysLabel.text = "\(days)"
    }
    
    func update(title: String?) {
        eventNameLabel.text = title
    }
    
}
