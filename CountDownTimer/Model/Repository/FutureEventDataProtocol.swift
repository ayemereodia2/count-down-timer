//
//  FutureEventDataProtocol.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/26.
//

import Foundation
protocol FutureEventDataProtocol {
    func create(eventModel: FutureEventModel)
    func view() -> [FutureEventModel]
    func delete(eventModel: FutureEventModel) -> Bool
    func edit(eventModel: FutureEventModel)
}
