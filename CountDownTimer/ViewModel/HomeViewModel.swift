//
//  HomeViewModel.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/27.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func showSavedEvents(events: [FutureEvent])
}

class HomeViewModel {
    private let homeRepository: HomeRepositoryProtocol
    weak var delegate: HomeViewDelegate?
    
    init(homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }
    
    func loadInitialView() {
        let events = homeRepository.view()
        delegate?.showSavedEvents(events: events)
    }
}
