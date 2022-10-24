//
//  NewEventViewModelTest.swift
//  CountDownTimerTests
//
//  Created by Ayemere  Odia  on 2022/10/08.
//

import XCTest
@testable import CountDownTimer

class NewEventViewModelTest: XCTestCase {
    
    func test_saveNewEvent_WhenSaveIs_Successfull_Calls_DismissesView() {
        let mockRepo = MockNewEventRepository(saveStatus: true)
        let delegate = MockNewEventViewDelegate()
        let sut = MockNewEventViewModel(homeRepository: mockRepo)
        sut.delegate = delegate
        sut.didChange(text: "Some Event name")
        sut.didChange(date: Date.now)
        
        sut.saveNewEvent()
        
        XCTAssertTrue(mockRepo.createDidCall)
        XCTAssertEqual(mockRepo.createCallCount, 1)
        XCTAssertTrue(delegate.dismissAfterSaveViewDidCall)
        XCTAssertEqual(delegate.dismissAfterSaveViewCount, 1)
    }
    
    func test_saveNewEvent_WhenSaveIs_NotSuccessfull_Calls_DismissesView() {
        let mockRepo = MockNewEventRepository(saveStatus: false)
        let delegate = MockNewEventViewDelegate()
        let sut = MockNewEventViewModel(homeRepository: mockRepo)
        sut.delegate = delegate
        sut.didChange(text: "Some Event name")
        sut.didChange(date: Date.now)
        
        sut.saveNewEvent()
        
        XCTAssertTrue(mockRepo.createDidCall)
        XCTAssertEqual(mockRepo.createCallCount, 1)
        XCTAssertFalse(delegate.dismissAfterSaveViewDidCall)
        XCTAssertEqual(delegate.dismissAfterSaveViewCount, 0)
    }
}


private class MockNewEventViewModel: NewEventViewModel {
    
}

private class MockNewEventRepository: NewEventRepositoryProtocol {
    var createCallCount = 0
    var createDidCall = false
    private let saveStatus: Bool
    
    init(saveStatus: Bool) {
        self.saveStatus = saveStatus
    }
    
    func create(futureEvent: FutureEvent, completionHandler: @escaping (Bool) -> ()) {
        createDidCall = true
        createCallCount += 1
        completionHandler(saveStatus)
    }
}


private class MockNewEventViewDelegate: NewEventViewDelegate {
    func showError() {
        
    }
    
    var dismissAfterSaveViewDidCall = false
    var dismissAfterSaveViewCount = 0
    
    var saveButtonDidCall = false
    var saveButtonCount = 0
    
    func saveButton(isEnabled: Bool) {
        saveButtonDidCall = true
        saveButtonCount += 1
    }
    
    func dismissAfterSaveView() {
        dismissAfterSaveViewDidCall = true
        dismissAfterSaveViewCount += 1
    }
}
