//
//  GiphyCoreSDKOffsetTests.swift
//  GiphyCoreSDK
//
//  Created by Cem Kozinoglu, Gene Goykhman, Giorgia Marenda on 4/24/17.
//  Copyright © 2017 Giphy. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import XCTest
@testable import GiphyCoreSDK

class GiphyCoreSDKOffsetTests: XCTestCase {
    
    // MARK: Setup Client and Tests
    
    let client = GPHClient(apiKey: "4OMJYpPoYwVpe")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testClientSearchGIFsOffsetLimit() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Search Results")
        
        let _ = client.search("cats", media:.gif, offset: 0, limit: 4) { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let data = response.data, let pagination = response.pagination {
                print(response.meta)
                print(pagination)
                if pagination.totalCount != 4 && pagination.count != 4 {
                    XCTFail("Pagination doesn't match limit of 4")
                }
                if data.count != 4 {
                    XCTFail("Offset/Limit is returning wrong amount of results")
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func testClientSearchStickersOffsetLimit() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Search Results")
        
        let _ = client.search("cats", media:.sticker, offset: 0, limit: 4) { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let data = response.data, let pagination = response.pagination {
                print(response.meta)
                print(pagination)
                if pagination.totalCount != 4 && pagination.count != 4 {
                    XCTFail("Pagination doesn't match limit of 4")
                }
                if data.count != 4 {
                    XCTFail("Offset/Limit is returning wrong amount of results")
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
