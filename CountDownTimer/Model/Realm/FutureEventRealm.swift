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
    

    
    func create(eventModel: FutureEventModel) {
        do {
            try realm.write {
                realm.add(eventModel)
            }
        } catch {
            
        }
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
