//
//  APIServiceTest.swift
//  SportApplicationTests
//
//  Created by AhmedFareed on 29/03/2021.
//

import XCTest

@testable import SportApplication

class APIServiceTest: XCTestCase {

    var homeViewController : HomeViewController?
    
    var promise = XCTestExpectation(description: "Success API Response")
    
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
    
    func testAPIMockService() {
        let mockAPIService = APIMockService()
        mockAPIService.getResponses(url: "", id: "") { (data: Sport?, error) in
            XCTAssertNil(data)
            self.promise.fulfill()
        }
        wait(for: [promise], timeout: 4)
    }
    
    
    
    
    func testAPIRealService(url:String) {
        
        ApiServices.instance.getResponses(url: ApiURLs.allSports.rawValue) { (data: Sport?, error) in
            
            XCTAssertNotNil(data)
            self.promise.fulfill()
        }
        wait(for: [promise], timeout: 4)
    }
    
}
