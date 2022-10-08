//
//  HomeViewModel.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/27.
//

import Foundation
import UIKit

class HomeViewModel {
    private let homeRepository: HomeRepositoryProtocol
    private var events: [FutureEvent]?
    weak var delegate: HomeViewDelegate?
    
    init(homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }
    
    func loadInitialView() {
        events = homeRepository.view()
    }
    
    func numberOfRow(tableView: UITableView, section: Int) -> Int {
        guard let events = events else {
           return 0
        }
       return events.count
    }
    
    func populate(cell: UITableViewCell?, indexPath: IndexPath) -> UITableViewCell {
        guard let events = events, let cell = cell else {
            return UITableViewCell()
        }

        cell.textLabel?.text = events[indexPath.row].name
        cell.detailTextLabel?.text = "\(events[indexPath.row].dateTime)"
        return cell
    }
}
