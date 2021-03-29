//
//  TableViewsTest.swift
//  SportApplicationTests
//
//  Created by AhmedFareed on 29/03/2021.
//

import XCTest
@testable import SportApplication

class TableViewsTest: XCTestCase {

    var homeViewController : HomeViewController?
    var promise = XCTestExpectation(description: "Success CollectionView Test")
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        homeViewController = storyboard.instantiateViewController(identifier: "HomeViewController")
        homeViewController?.loadViewIfNeeded()
        
    }

    override func tearDownWithError() throws {
        homeViewController = nil
        try super.tearDownWithError()
    }
    
    func testCollectionViewDelegate(){
        XCTAssertNotNil(homeViewController?.sportsCollectionView.delegate)
        XCTAssertNotNil(homeViewController?.sportsCollectionView.dataSource)
    }
//    func testCollectionNumberOfRows() {
//
//        guard let collectionView = homeViewController?.sportsCollectionView else{
//            XCTFail()
//            return
//        }
//
//        XCTAssertEqual(collectionView.numberOfItemsIn(section: 0), 0)
//        promise.fulfill()
//        wait(for: [promise], timeout: 2)
}

