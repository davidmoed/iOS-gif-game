//
//  GiphyCoreSDKNSCodingTests.swift
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


class GiphyCoreSDKNSCodingTests: XCTestCase {
    
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
    
    func requestSearch(for term: String) {
        let promise = expectation(description: "Status 200 & Receive Search Results & Map them to Objects")
        
        let _ = client.search(term) { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let data = response.data, let pagination = response.pagination {
                print(response.meta)
                print(pagination)
                // Test that search always returns some results
                XCTAssert(data.count != 0, "No results found for [" + term + "]")
                data.forEach { result in
                    do {
                        // Test the initial mapping before archiving
                        try? self.validateJSONForMedia(result, media: .gif, request: "search")
                        
                        // Test if we can archive & unarchive
                        let obj = try self.cloneViaCoding(root: result)
                        
                        // Test mapping after archive & unarchive
                        try? self.validateJSONForMedia(obj, media: .gif, request: "search")
                        
                    } catch let error as NSError {
                        print(result)
                        print(error)
                        XCTFail("Failed to archive and unarchive")
                    }
                }
                
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testNSCodingForSearchGIFs() {
        // Test to see if we can do a valid search request with our Client Api Key
        requestSearch(for: "cats")
        requestSearch(for: "cats smile")
        requestSearch(for: "cats     smile")
        requestSearch(for: "cat & dog")
        requestSearch(for: "cat %20")
    }
    
    func testNSCodingForSearchStickers() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Search Results & Map them to Objects")
        
        let _ = client.search("cats", media: .sticker) { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let data = response.data, let pagination = response.pagination {
                print(response.meta)
                print(pagination)
                data.forEach { result in
                    do {
                        // Test the initial mapping before archiving
                        try? self.validateJSONForMedia(result, media: .sticker, request: "search")
                        
                        // Test if we can archive & unarchive
                        let obj = try self.cloneViaCoding(root: result)
                        
                        // Test mapping after archive & unarchive
                        try? self.validateJSONForMedia(obj, media: .sticker, request: "search")
                        
                    } catch let error as NSError {
                        print(result)
                        print(error)
                        XCTFail("Failed to archive and unarchive")
                    }
                }
                
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testNSCodingForTrendingGIFs() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Search Results & Map them to Objects")
        
        let _ = client.trending(completionHandler: { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let data = response.data, let pagination = response.pagination {
                print(response.meta)
                print(pagination)
                data.forEach { result in
                    do {
                        // Test the initial mapping before archiving
                        try? self.validateJSONForMedia(result, media: .gif, request: "trending")
                        
                        // Test if we can archive & unarchive
                        let obj = try self.cloneViaCoding(root: result)
                        
                        // Test mapping after archive & unarchive
                        try? self.validateJSONForMedia(obj, media: .gif, request: "trending")
                        
                    } catch let error as NSError {
                        print(result)
                        print(error)
                        XCTFail("Failed to archive and unarchive")
                    }
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
        })
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testNSCodingForTrendingStickers() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Search Results & Map them to Objects")
        
        let _ = client.trending(.sticker) { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let data = response.data, let pagination = response.pagination {
                print(response.meta)
                print(pagination)
                data.forEach { result in
                    do {
                        // Test the initial mapping before archiving
                        try? self.validateJSONForMedia(result, media: .sticker, request: "trending")
                        
                        // Test if we can archive & unarchive
                        let obj = try self.cloneViaCoding(root: result)
                        
                        // Test mapping after archive & unarchive
                        try? self.validateJSONForMedia(obj, media: .sticker, request: "trending")
                        
                    } catch let error as NSError {
                        print(result)
                        print(error)
                        XCTFail("Failed to archive and unarchive")
                    }
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK: Test Translate
    
    func testNSCodingForTranslateGIF() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Translate Result & Map it to Object")
        
        let _ = client.translate("cats") { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let result = response.data  {
                print(response.meta)
                do {
                    // Test the initial mapping before archiving
                    try? self.validateJSONForMedia(result, media: .gif, request: "translate")
                    
                    // Test if we can archive & unarchive
                    let obj = try self.cloneViaCoding(root: result)
                    
                    // Test mapping after archive & unarchive
                    try? self.validateJSONForMedia(obj, media: .gif, request: "translate")
                    
                } catch let error as NSError {
                    print(result)
                    print(error)
                    XCTFail("Failed to archive and unarchive")
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
            
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testNSCodingForTranslateSticker() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Translate Result & Map it to Object")
        
        let _ = client.translate("cats", media: .sticker) { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let result = response.data  {
                print(response.meta)
                do {
                    // Test the initial mapping before archiving
                    try? self.validateJSONForMedia(result, media: .sticker, request: "translate")
                    
                    // Test if we can archive & unarchive
                    let obj = try self.cloneViaCoding(root: result)
                    
                    // Test mapping after archive & unarchive
                    try? self.validateJSONForMedia(obj, media: .sticker, request: "translate")
                    
                } catch let error as NSError {
                    print(result)
                    print(error)
                    XCTFail("Failed to archive and unarchive")
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
            
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK: Test Random
    
    func testNSCodingForRandomGIF() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Random Result & Map it to Object")
        
        let _ = client.random("cats") { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let result = response.data  {
                print(response.meta)
                do {
                    // Test the initial mapping before archiving
                    try? self.validateJSONForMedia(result, media: .gif, request: "random")
                    
                    // Test if we can archive & unarchive
                    let obj = try self.cloneViaCoding(root: result)
                    
                    // Test mapping after archive & unarchive
                    try? self.validateJSONForMedia(obj, media: .gif, request: "random")
                    
                } catch let error as NSError {
                    print(result)
                    print(error)
                    XCTFail("Failed to archive and unarchive")
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
            
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testNSCodingForRandomSticker() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Random Result & Map it to Object")
        
        let _ = client.random("cats", media: .sticker) { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let result = response.data  {
                print(response.meta)
                do {
                    // Test the initial mapping before archiving
                    try? self.validateJSONForMedia(result, media: .sticker, request: "random")
                    
                    // Test if we can archive & unarchive
                    let obj = try self.cloneViaCoding(root: result)
                    
                    // Test mapping after archive & unarchive
                    try? self.validateJSONForMedia(obj, media: .sticker, request: "random")
                    
                } catch let error as NSError {
                    print(result)
                    print(error)
                    XCTFail("Failed to archive and unarchive")
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
            
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    // MARK: Test Gif by ID
    
    func testNSCodingForGetGIFbyID() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive a Gif by its id & Map it to Object")
        
        let _ = client.gifByID("FiGiRei2ICzzG") { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let result = response.data  {
                print(response.meta)
                do {
                    // Test the initial mapping before archiving
                    try? self.validateJSONForMedia(result, media: .gif, request: "get")
                    
                    // Test if we can archive & unarchive
                    let obj = try self.cloneViaCoding(root: result)
                    
                    // Test mapping after archive & unarchive
                    try? self.validateJSONForMedia(obj, media: .gif, request: "get")
                    
                } catch let error as NSError {
                    print(result)
                    print(error)
                    XCTFail("Failed to archive and unarchive")
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
            
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK: Test Gifs by IDs
    
    func testNSCodingForGetGIFsbyIDs() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Gifs by Ids & Map them to Objects")
        let ids = ["PwyQ8ase9nuyQ", "mztEiyM7hzjDG", "5w4QZx27jDM8U"]
        
        let _ = client.gifsByIDs(ids) { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let data = response.data, let pagination = response.pagination {
                print(response.meta)
                print(pagination)
                data.forEach { result in
                    do {
                        // Test the initial mapping before archiving
                        try? self.validateJSONForMedia(result, media: .gif, request: "getAll")
                        
                        // Test if we can archive & unarchive
                        let obj = try self.cloneViaCoding(root: result)
                        
                        // Test mapping after archive & unarchive
                        try? self.validateJSONForMedia(obj, media: .gif, request: "getAll")
                        
                    } catch let error as NSError {
                        print(result)
                        print(error)
                        XCTFail("Failed to archive and unarchive")
                    }
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK: Test Term Suggestions
    func requestSuggestions(for term: String) {
        let promise = expectation(description: "Status 200 & Receive Term Suggestions & Map them to Objects")
        
        let _ = client.termSuggestions(term) { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let data = response.data {
                print(response.meta)
                // Test that suggestions always returns some values
                XCTAssert(data.count != 0, "No suggestions found for [" + term + "]")
                data.forEach { result in
                    do {
                        // Test the initial mapping before archiving
                        try? self.validateJSONForTerm(result, request: "term")
                        
                        // Test if we can archive & unarchive
                        let obj = try self.cloneViaCoding(root: result)
                        
                        // Test mapping after archive & unarchive
                        try? self.validateJSONForTerm(obj, request: "term")
                        
                    } catch let error as NSError {
                        print(result)
                        print(error)
                        XCTFail("Failed to archive and unarchive")
                    }
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testNSCodingForTermSuggestions() {
        requestSuggestions(for: "cas fails")
        requestSuggestions(for: "cat     fails")
        requestSuggestions(for: "cat & dog")
        requestSuggestions(for: "cat %20")
        requestSuggestions(for: "carm")
    }
    
    // MARK: Test Categories
    
    func testNSCodingForCategories() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Categories & Map them to Objects")
        
        let _ = client.categoriesForGifs() { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let data = response.data, let pagination = response.pagination {
                print(response.meta)
                print(pagination)
                data.forEach { result in
                    do {
                        // Test the initial mapping before archiving
                        try? self.validateJSONForCategory(result, root: nil, request: "categories")
                        
                        // Test if we can archive & unarchive
                        let obj = try self.cloneViaCoding(root: result)
                        
                        // Test mapping after archive & unarchive
                        try? self.validateJSONForCategory(obj, root: nil, request: "categories")
                        
                    } catch let error as NSError {
                        print(result)
                        print(error)
                        XCTFail("Failed to archive and unarchive")
                    }
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testNSCodingForSubCategories() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Categories & Map them to Objects")
        
        let category = "actions"
        
        let _ = client.subCategoriesForGifs(category) { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let data = response.data, let pagination = response.pagination {
                print(response.meta)
                print(pagination)
                data.forEach { result in
                    do {
                        
                        let categoryObj = GPHCategory(category, nameEncoded: self.client.encodedStringForUrl(category), encodedPath: self.client.encodedStringForUrl(category))
                        
                        // Test the initial mapping before archiving
                        try? self.validateJSONForCategory(result, root: categoryObj, request: "subCategories")
                        
                        // Test if we can archive & unarchive
                        let obj = try self.cloneViaCoding(root: result)
                        
                        // Test mapping after archive & unarchive
                        try? self.validateJSONForCategory(obj, root: categoryObj, request: "subCategories")
                    } catch let error as NSError {
                        print(result)
                        print(error)
                        XCTFail("Failed to archive and unarchive")
                    }
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testNSCodingForCategoryContent() {
        // Test to see if we can do a valid search request with our Client Api Key
        let promise = expectation(description: "Status 200 & Receive Categories & Map them to Objects")
        
        let _ = client.gifsByCategory("actions", subCategory: "cooking") { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let data = response.data, let pagination = response.pagination {
                print(response.meta)
                print(pagination)
                data.forEach { result in
                    do {
                        // Test the initial mapping before archiving
                        try? self.validateJSONForMedia(result, media: .gif, request: "categoryContent")
                        
                        // Test if we can archive & unarchive
                        let obj = try self.cloneViaCoding(root: result)
                        
                        // Test mapping after archive & unarchive
                        try? self.validateJSONForMedia(obj, media: .gif, request: "categoryContent")
                    
                    } catch let error as NSError {
                        print(result)
                        print(error)
                        XCTFail("Failed to archive and unarchive")
                    }
                }
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testNSCodingForChannel() {
        let promise = expectation(description: "Status 200 & Receive Channel")
        
        let _ = client.channel(GPHChannel.StickersRootId, media: .sticker) { (response, error) in
            if let data = response?.data {
                print(data)
                try? self.validateJSONForChannel(data, channelId: data.id, media: .sticker, request: "channel")
                if let featuredGif = data.featuredGif {
                    try? self.validateJSONForMedia(featuredGif, media: .sticker, request: "channel")
                }
            } else {
                print(response ?? "no response")
                print(error ?? "no error")
                XCTFail("Failed to fetch channel object.")
            }
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testNSCodingForChannelContent() {
        let promise = expectation(description: "Status 200 & Map gif objects")
        
        let _ = client.channelContent(3203, offset: 0, limit: 50, media: .sticker) { (response, error) in
            if let data = response?.data {
                print(data)
                data.forEach { result in
                    do {
                        // Test the initial mapping before archiving
                        try? self.validateJSONForMedia(result, media: .sticker, request: "channelContent")
                        
                        // Test if we can archive & unarchive
                        let obj = try self.cloneViaCoding(root: result)
                        
                        // Test mapping after archive & unarchive
                        try? self.validateJSONForMedia(obj, media: .sticker, request: "channelContent")
                        
                    } catch let error as NSError {
                        print(result)
                        print(error)
                        XCTFail("Failed to archive and unarchive")
                    }
                }
            } else {
                print(response ?? "no response")
                print(error ?? "no error")
                XCTFail("Failed to fetch gifs.")
            }
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testNSCodingForChannelChildren() {
        let promise = expectation(description: "Status 200 & Receive Map Channel objects")
        
        let _ = client.channelChildren(1106, offset: 0, limit: 10, media: .sticker) { (response, error) in
            if let data = response?.data {
                data.forEach { channel in
                    print(data)
                    try? self.validateJSONForChannel(channel, channelId: channel.id, media: .sticker, request: "channelChildren")
                    if let featuredGif = channel.featuredGif {
                        try? self.validateJSONForMedia(featuredGif, media: .sticker, request: "channelChildren")
                    }
                }
            } else {
                print(response ?? "no response")
                print(error ?? "no error")
                XCTFail("Failed to fetch Channel children.")
            }
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testNSCodingSearchFilter() {
        let promise = expectation(description: "Status 200 & Receive Search Results & Map them to Objects")
        
        GPHMedia.filter = { obj in
            print("Filter called...")
            if let obj = obj as? GPHMedia {
                return (obj.featuredTags != nil && obj.featuredTags!.count > 3)
            }
            return false
        }
        
        let _ = client.search("dog") { (response, error) in
            
            if let error = error as NSError? {
                XCTFail("Error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let response = response, let data = response.data, let pagination = response.pagination {
                print(response.meta)
                print(pagination)
                // Test that search always returns some results

                print("VALID TOTAL: (\(pagination.filteredCount)) vs ACTUAL TOTAL:(\(pagination.count))")
                data.forEach { result in
                    do {
                        // Test the initial mapping before archiving
                        try? self.validateJSONForMedia(result, media: .gif, request: "search")
                        
                        // Test if we can archive & unarchive
                        let obj = try self.cloneViaCoding(root: result)
                        print(obj)
                        // Test mapping after archive & unarchive
                        try? self.validateJSONForMedia(obj, media: .gif, request: "search")
                        
                    } catch let error as NSError {
                        print(result)
                        print(error)
                        XCTFail("Failed to archive and unarchive")
                    }
                }
                
                promise.fulfill()
            } else {
                XCTFail("No Result Found")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
}
