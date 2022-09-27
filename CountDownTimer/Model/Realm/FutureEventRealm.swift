//
//  FutureEventStore.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/26.
//

import Foundation
import RealmSwift

class FutureEventRealm: FutureEventDataProtocol {
    private let realm: Realm = {
        try! Realm()
    }()
    

    
    func create(eventModel: FutureEventModel, completionHandler: @escaping (Bool)->Void) {
        do {
            try realm.write {
                realm.add(eventModel)
                completionHandler(true)
            }
        } catch {
            completionHandler(false)
        }
        completionHandler(false)
    }
    
    func view() -> [FutureEventModel] {
        []
    }
    
    func delete(eventModel: FutureEventModel) -> Bool {
        true
    }
    
    func edit(eventModel: FutureEventModel) {
        
    }
    
    // connect to realm here
}
