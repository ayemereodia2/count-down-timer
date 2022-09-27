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
        dataSource = FakeRealmDataBase(status: true)
        let sut = FutureEventRepositoryMock(dataSource: dataSource)
        let event = FutureEvent(name: "Birthday", dateTime: Date(), isDone: true)
        let expectation = XCTestExpectation(description: "data was not saved")
        
        sut.create(futureEvent: event) { status in
            expectation.fulfill()
            XCTAssertTrue(status)
        }
        
        wait(for: [expectation], timeout: 1)
        
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
    
    func test_delete_calls_realm_delete_returns_with_completion() {
        dataSource = FakeRealmDataBase(deleteStatus: true)
        let sut = FutureEventRepositoryMock(dataSource: dataSource)
        let event = FutureEvent(name: "Birthday", dateTime: Date(), isDone: true)
        let expectation = XCTestExpectation(description: "data was not deleted")

        sut.delete(futureEvent: event) { status in
            expectation.fulfill()
            XCTAssertTrue(status)
        }
        
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertTrue(dataSource.didCallDelete)
        XCTAssertEqual(dataSource.deleteCount, 1)
    }
    
    func test_edit_calls_realm_edit_returns_with_completion() {
        dataSource = FakeRealmDataBase(editStatus: true)
        let sut = FutureEventRepositoryMock(dataSource: dataSource)
        let event = FutureEvent(name: "Birthday", dateTime: Date(), isDone: true)
        let expectation = XCTestExpectation(description: "data was not edited")

        sut.edit(futureEvent: event) { status in
            expectation.fulfill()
            XCTAssertTrue(status)
        }
        
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertTrue(dataSource.didCallEdit)
        XCTAssertEqual(dataSource.editCount, 1)
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
    
    var deleteCount = 0
    var didCallDelete = false
    
    var editCount = 0
    var didCallEdit = false
    
    private var status: Bool = false
    private var saveStatus: Bool = false
    private var deleteStatus: Bool = false
    private var editStatus: Bool = false

    init(status: Bool = false, deleteStatus: Bool = false, editStatus: Bool = false) {
        self.status = status
        self.deleteStatus = deleteStatus
        self.editStatus = editStatus
    }
    
    func create(eventModel: FutureEventModel, completionHandler: @escaping (Bool) -> Void) {
        createCount += 1
        didCallCreate = true
        completionHandler(status)
    }
    
    func view() -> [FutureEventModel] {
        viewCount += 1
        didCallView = true
        return fakeFutureEventModel()
    }
    
    func delete(eventModel: FutureEventModel, completionHandler: @escaping (Bool) -> Void) {
        deleteCount += 1
        didCallDelete = true
        completionHandler(deleteStatus)
    }
    
    func edit(eventModel: FutureEventModel, completionHandler: @escaping (Bool) -> Void) {
        editCount += 1
        didCallEdit = true
        completionHandler(editStatus)
    }
    
    private func fakeFutureEventModel() -> [FutureEventModel] {
        [FutureEventModel(),FutureEventModel(), FutureEventModel()]
    }
    
}
