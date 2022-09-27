//
//  FutureEventRepository.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/27.
//

import Foundation
import UIKit

class FutureEventRepository {
    private let dataSource: FutureEventDataProtocol
    
    init(dataSource: FutureEventDataProtocol) {
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
