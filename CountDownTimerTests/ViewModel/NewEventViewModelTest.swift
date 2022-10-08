//
//  NewEventViewModelTest.swift
//  CountDownTimerTests
//
//  Created by Ayemere  Odia  on 2022/10/08.
//

import XCTest
@testable import CountDownTimer

class NewEventViewModelTest: XCTestCase {
    
    func test_saveNewEvent_DismissesView() {
        let mockRepo = MockNewEventRepository()
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
}


private class MockNewEventViewModel: NewEventViewModel {
    
}

private class MockNewEventRepository: NewEventRepositoryProtocol {
    var createCallCount = 0
    var createDidCall = false
    
    func create(futureEvent: FutureEvent, completionHandler: @escaping (Bool) -> ()) {
        createDidCall = true
        createCallCount += 1
        completionHandler(true)
    }
}


private class MockNewEventViewDelegate: NewEventViewDelegate {
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
