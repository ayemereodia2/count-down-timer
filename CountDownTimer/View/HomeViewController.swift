//
//  ViewController.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var addEventButton: UIButton!
    
    var viewModel: HomeViewModel = {
        let data = FutureEventRealm()
        let repository = FutureEventRepository(dataSource: data)
        let viewModel = HomeViewModel(homeRepository: repository)
        return viewModel
    }()
    
    var newEventViewModel: NewEventViewModel = {
        let data = FutureEventRealm()
        let repository = FutureEventRepository(dataSource: data)
        let viewModel = NewEventViewModel(homeRepository: repository)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadInitialView()
        viewModel.delegate = self
        newEventViewModel.homeDelegate = self
    }
    
    @IBAction func addEventButtonTap(_ sender: UIButton) {
       let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let newEventViewController = storyBoard.instantiateViewController(withIdentifier: "NewEventViewController") as? NewEventViewController else { return }
        
        newEventViewController.viewModel = newEventViewModel
        newEventViewController.modalPresentationStyle = .formSheet
        self.present(newEventViewController, animated: true)
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         viewModel.numberOfRow(tableView: tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return viewModel.populate(cell: cell, indexPath: indexPath)
    }
}

extension HomeViewController: HomeViewDelegate {
    func reloadTableView() {
        viewModel.loadInitialView()
        self.homeTableView.reloadData()
    }
}
