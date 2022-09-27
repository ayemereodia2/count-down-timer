//
//  FutureEventRepository.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/27.
//

import Foundation

protocol HomeRepositoryProtocol {
    func view() -> [FutureEvent]
}

protocol NewEventRepositoryProtocol {
    func create(futureEvent: FutureEvent, completionHandler: @escaping (Bool) -> ())
}

protocol FutureEventRepositoryProtocol: HomeRepositoryProtocol, NewEventRepositoryProtocol {
    func delete(futureEvent: FutureEvent, completionHandler: @escaping (Bool) -> ())
    func edit(futureEvent: FutureEvent, completionHandler: @escaping (Bool) -> Void)
}

class FutureEventRepository: FutureEventRepositoryProtocol {
    
    private let dataSource: FutureEventDataModelProtocol
    
    init(dataSource: FutureEventDataModelProtocol) {
        self.dataSource = dataSource
    }
    
    func create(futureEvent: FutureEvent, completionHandler: @escaping (Bool) -> ()) {
        self.dataSource.create(eventModel: FutureEventModel.init(futureEvent: futureEvent)) { status in
            completionHandler(status)
        }
    }
    
    func view() -> [FutureEvent] {
        self.dataSource.view().map { FutureEvent.init(model: $0) }
    }
    
    func delete(futureEvent: FutureEvent, completionHandler: @escaping (Bool) -> ()) {
        self.dataSource.delete(eventModel: FutureEventModel.init(futureEvent: futureEvent)) { deleteStatus in
            completionHandler(deleteStatus)
        }
    }
    
    func edit(futureEvent: FutureEvent, completionHandler: @escaping (Bool) -> Void) {
        self.dataSource.edit(eventModel: FutureEventModel.init(futureEvent: futureEvent)) { editStatus in
            completionHandler(editStatus)
        }
    }
}
