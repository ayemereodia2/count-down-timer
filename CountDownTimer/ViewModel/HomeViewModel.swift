//
//  HomeViewModel.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/27.
//

import Foundation
import UIKit

protocol HomeViewDelegate: AnyObject {
    func showSavedEvents(events: [FutureEvent])
}

class HomeViewModel {
    private let homeRepository: HomeRepositoryProtocol
    weak var delegate: HomeViewDelegate?
    private var events: [FutureEvent]?
    
    init(homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }
    
    func loadInitialView() {
        events = homeRepository.view()
        //delegate?.showSavedEvents(events: events)
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
