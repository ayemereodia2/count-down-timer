//
//  HomeViewModelTest.swift
//  CountDownTimerTests
//
//  Created by Ayemere  Odia  on 2022/09/27.
//

import XCTest
@testable import CountDownTimer

class HomeViewModelTest: XCTestCase {

    func test_loadInitialView_triggers_HomeViewDelegate_ShowEvent() {
        let respository = HomeRepositoryMock()
        let delegate = HomeViewDelegateMock()
        let sut = HomeViewModelMock(homeRepository: respository, mockDelegate: delegate)
        
        sut.loadInitialView()
        
        XCTAssertTrue(respository.viewDidCall)
        XCTAssertEqual(respository.viewDidCount, 1)
        
        XCTAssertTrue(delegate.showSavedEventsDidCall)
        XCTAssertEqual(delegate.showSavedEventsDidCount, 1)
    }
}


private class HomeViewModelMock: HomeViewModel {
    init(homeRepository: HomeRepositoryProtocol, mockDelegate: HomeViewDelegate) {
        super.init(homeRepository: homeRepository)
        self.delegate = mockDelegate
    }
}

private class HomeRepositoryMock: HomeRepositoryProtocol {
    var viewDidCall = false
    var viewDidCount = 0
    
    func view() -> [FutureEvent] {
        viewDidCall = true
        viewDidCount += 1
        return []
    }
}

private class HomeViewDelegateMock: HomeViewDelegate {
    func setTitle(title: String) {
        
    }
    
    var showSavedEventsDidCall = false
    var showSavedEventsDidCount = 0

    var reloadTableViewDidCall = false
    var reloadTableViewCount = 0
    
    func showSavedEvents(events: [FutureEvent]) {
        showSavedEventsDidCall = true
        showSavedEventsDidCount += 1
    }
    
    func reloadTableView() {
         reloadTableViewDidCall = true
         reloadTableViewCount += 1
    }
}
