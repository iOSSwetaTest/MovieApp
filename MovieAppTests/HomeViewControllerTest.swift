//
//  HomeViewControllerTest.swift
//  CumberbatchAppTests
//
//  Created by shweta dodiya on 2024-08-13.
//

import Foundation
import XCTest

@testable import MovieApp

class HomeViewControllerTest: XCTestCase {
    
    private var appDelegate: AppDelegate!
    private var homeVC: HomeViewController!
    
    override func setUp() {
        super.setUp()
            
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        homeVC = HomeViewController()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetFirstRow() {
        let tableView = homeVC.tableView
        homeVC.setupTableView()

        let indexPath0 = IndexPath(item: 0, section: 0)

        _ = homeVC.tableView(tableView, cellForRowAt: indexPath0)
          
        let visibleRows = tableView.indexPathsForVisibleRows
        XCTAssert(visibleRows != nil)
        XCTAssert(tableView.indexPathsForVisibleRows!.contains(indexPath0))
    }

    
    // This will only pass if Internet is not available
    func testInternetConnectionAlert() {
        homeVC.setupTableView()
        let expectation = XCTestExpectation(description: "testExample")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertTrue(UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.presentedViewController is UIAlertController)
                expectation.fulfill()
            })
        wait(for: [expectation], timeout: 1.5)
    }
    
}
