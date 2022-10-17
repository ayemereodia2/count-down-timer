//
//  NewEventViewModel.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/10/08.
//

import Foundation

protocol NewEventViewDelegate: AnyObject {
    func saveButton(isEnabled: Bool)
    func dismissAfterSaveView()
    func showError()
}

protocol HomeViewDelegate: AnyObject {
    func reloadTableView()
    func setTitle(title: String)
}

class NewEventViewModel {
    private let homeRepository: NewEventRepositoryProtocol
    weak var delegate: NewEventViewDelegate?
    weak var homeDelegate: HomeViewDelegate?
    private var eventName: String?
    private var eventDate: Date?
    
    init(homeRepository: NewEventRepositoryProtocol) {
        self.homeRepository = homeRepository
    }
    
    private func addNewEvent(event: FutureEvent) {
        homeRepository.create(futureEvent: event) { result in
            guard result else { return }
            NewEventNotification.setupLocalNotifcation(with: event)
            self.delegate?.dismissAfterSaveView()
            self.homeDelegate?.reloadTableView()
        }
    }
}


extension NewEventViewModel: ViewMonitor {
    func didChange(text: String?) {
        guard let text = text, text.count > 5 else {
            self.delegate?.saveButton(isEnabled: false)
            self.eventName = nil
            self.eventDate = nil
            return
        }
        self.eventName = text
        
        if let _ = self.eventDate {
            delegate?.saveButton(isEnabled: true)
        }
        
    }
    
    func didChange(date: Date?) {
        guard let eventDate = date, let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date.now) else {
            self.delegate?.saveButton(isEnabled: false)
            self.eventName = nil
            self.eventDate = nil
            return
        }
        
        if eventDate <= yesterday {
            self.delegate?.showError()
            return
        }
                
        self.eventDate = eventDate
        
        if let _ = self.eventName {
            delegate?.saveButton(isEnabled: true)
        }
    }
    
    func saveNewEvent() {
        guard let eventName = self.eventName, let eventDate = eventDate else {
            return
        }
        addNewEvent(event: FutureEvent(name: eventName, dateTime: eventDate, isDone: false))
    }
}
