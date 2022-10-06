//
//  ViewController.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/25.
//

import UIKit

class HomeViewController: UIViewController {

    
    var viewModel: HomeViewModel = {
        let data = FutureEventRealm()
        let repository = FutureEventRepository(dataSource: data)
        let viewModel = HomeViewModel(homeRepository: repository)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadInitialView()
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
