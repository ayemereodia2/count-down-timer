//
//  FutureEventRepositoryTest.swift
//  CountDownTimerTests
//
//  Created by Ayemere  Odia  on 2022/09/27.
//

import XCTest
@testable import CountDownTimer

class FutureEventRepositoryTest: XCTestCase {
    private var dataSource: FakeRealmDataBase!
    override func setUp() {
        dataSource = FakeRealmDataBase()
    }

    func test_create_call_realm_create_method() {
        let sut = FutureEventRepositoryMock(dataSource: dataSource)
        let event = FutureEvent(name: "Birthday", dateTime: Date(), isDone: true)
        sut.create(futureEvent: event)
        
        XCTAssertTrue(dataSource.didCallCreate)
        XCTAssertEqual(dataSource.createCount, 1)
    }
    
    func test_view_calls_realm_view_with_result() {
        let sut = FutureEventRepositoryMock(dataSource: dataSource)
        let response = sut.view()
        XCTAssertEqual(response.count, 3)
        XCTAssertTrue(dataSource.didCallView)
        XCTAssertEqual(dataSource.viewCount, 1)
    }

}


private class FutureEventRepositoryMock: FutureEventRepository {
    override init(dataSource: FutureEventDataProtocol) {
        super.init(dataSource: dataSource)
    }
}

class FakeRealmDataBase: FutureEventDataProtocol {
    var createCount = 0
    var didCallCreate = false
    
    var viewCount = 0
    var didCallView = false
    
    func create(eventModel: FutureEventModel) {
        createCount += 1
        didCallCreate = true
    }
    
    func view() -> [FutureEventModel] {
        viewCount += 1
        didCallView = true
        return fakeFutureEventModel()
    }
    
    func delete(eventModel: FutureEventModel) -> Bool {
        false
    }
    
    func edit(eventModel: FutureEventModel) {
        
    }
    
    private func fakeFutureEventModel() -> [FutureEventModel] {
        [FutureEventModel(),FutureEventModel(), FutureEventModel()]
    }
    
}
