//
//  GiphyCoreSDKStatusCodeTests.swift
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

class GiphyCoreSDKStatusCodeTests: XCTestCase {
    
    // MARK: Setup Client and Tests
    
    let client = GPHClient(apiKey: "4OMJYpPoYwVpe")
    let clientProblematicApiKey = GPHClient(apiKey: "some_fake_api_key")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    // MARK: Test 401 / Not Authorized
    func testClient403() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 403 & Receive 403 Error")
        
        let _ = clientProblematicApiKey.gifByID("some_fake_id") { (response, error) in
            
            if let error = error as NSError? {
                if error.code == 403 {
                    promise.fulfill()
                } else {
                    XCTFail("Error(\(error.code)): \(error.localizedDescription) does not match 403!")
                }
            } else {
                XCTFail("Didn't return 403")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK: Test 404 / Not Found
    func testClient404() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 404 & Receive 404 Error")
        
        let _ = client.gifByID("some_fake_id") { (response, error) in
            if let error = error as NSError? {
                if error.code == 404 {
                  promise.fulfill()
                } else {
                  XCTFail("Error(\(error.code)): \(error.localizedDescription) does not match 404!")
                }
            } else {
                XCTFail("Didn't return 404")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
