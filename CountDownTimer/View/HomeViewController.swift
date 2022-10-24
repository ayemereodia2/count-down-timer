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
        viewModel.setTitle()
    }
    
    @IBAction func addEventButtonTap(_ sender: UIButton) {
       let newEventViewController =  NewEventViewController()
        
        newEventViewController.viewModel = newEventViewModel
        //newEventViewController.modalPresentationStyle = .formSheet
        navigationController?.present(newEventViewController, animated: true)
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
    
    func setTitle(title: String) {
        navigationController?.navigationBar.topItem?.title = title
    }
}


extension HomeViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        guard let item = viewModel.item(at: indexPath) else { return }
        let counter = CountDownTimer(event: item)
        let viewModel = CountDownViewModel(event: item, countDownTimer: counter)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         guard let countDownViewController = storyBoard.instantiateViewController(withIdentifier: "CountDownViewController") as? CountDownViewController else { return }
        viewModel.delegate = countDownViewController
        countDownViewController.viewModel = viewModel
        countDownViewController.modalPresentationStyle = .formSheet
         self.present(countDownViewController, animated: true)
    }
}
