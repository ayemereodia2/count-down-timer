//
//  FutureEvent.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/26.
//

import Foundation
import RealmSwift

struct FutureEvent {
    let name: String
    let dateTime: Date
    let isDone: Bool
}

extension FutureEvent {
    init(model: FutureEventModel) {
        name = model.name
        dateTime = model.dateTime
        isDone = model.isDone
    }
}

class FutureEventModel: Object {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var name: String
    @Persisted var dateTime: Date
    @Persisted var isDone: Bool
}

extension FutureEventModel {
    convenience init(futureEvent: FutureEvent) {
        self.init()
        name = futureEvent.name
        dateTime = futureEvent.dateTime
        isDone = futureEvent.isDone
    }
}

