//
//  FutureEventStore.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/26.
//

import Foundation
import RealmSwift

class FutureEventRealm: FutureEventDataModelProtocol {
    private let realm: Realm = {
        try! Realm()
    }()
    

    
    func create(eventModel: FutureEventModel, completionHandler: @escaping (Bool) -> Void) {
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
        let models = realm.objects(FutureEventModel.self)
       return models.map { $0 }
    }
    
    func delete(eventModel: FutureEventModel, completionHandler: @escaping (Bool) -> Void) {
        do {
            try realm.write {
                realm.delete(eventModel)
                completionHandler(true)
            }
        } catch {
            completionHandler(false)
        }
        completionHandler(false)
    }
    
    func edit(eventModel: FutureEventModel, completionHandler: @escaping (Bool) -> Void) {
        do {
            try realm.write {
                realm.add(eventModel, update: .modified)
                completionHandler(true)
            }
        } catch {
            completionHandler(false)
        }
        completionHandler(false)
    }
}
