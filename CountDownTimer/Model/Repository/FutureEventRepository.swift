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
    
    func create(futureEvent: FutureEvent) {
        self.dataSource.create(eventModel: FutureEventModel.init(futureEvent: futureEvent))
    }
    
    func view() -> [FutureEvent] {
        self.dataSource.view().map { FutureEvent.init(model: $0) }
    }
    
    func delete(futureEvent: FutureEvent) -> Bool {
        self.dataSource.delete(eventModel: FutureEventModel.init(futureEvent: futureEvent))
    }
    
    func edit(futureEvent: FutureEvent) {
        self.dataSource.edit(eventModel: FutureEventModel.init(futureEvent: futureEvent))
    }
}
