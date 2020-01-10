//
//  ParticleErrorHelperTests.swift
//  ParticleSDKTests
//
//  Created by Raimundas Sakalauskas on 13/12/2019.
//  Copyright © 2019 Particle Inc. All rights reserved.
//

import XCTest
@testable import ParticleSDK

class ParticleErrorHelperTests: XCTestCase {

    func test_errorDescriptionSet_PrioritizedOverError() {
        let json = "{ \"error\" : \"error1\", \"error_description\": \"error2\" }"
        let expectedMessage = "error2"
        
        let message = ParticleErrorHelper.getErrorMessage(getJSONDict(withJSONString: json))
        XCTAssertEqual(message, expectedMessage)
    }
  
    func test_errorSet_parsedCorrectly() {
        let json = "{ \"error\" : \"error1\" }"
        let expectedMessage = "error1"
        
        let message = ParticleErrorHelper.getErrorMessage(getJSONDict(withJSONString: json))
        XCTAssertEqual(message, expectedMessage)
    }
    
    func test_errSet_parsedCorrectly() {
        let json = "{ \"err\" : \"error1\" }"
        let expectedMessage = "error1"
        
        let message = ParticleErrorHelper.getErrorMessage(getJSONDict(withJSONString: json))
        XCTAssertEqual(message, expectedMessage)
    }

    func test_infoSet_parsedCorrectly() {
        let json = "{ \"info\" : \"error1\" }"
        let expectedMessage = "error1"
        
        let message = ParticleErrorHelper.getErrorMessage(getJSONDict(withJSONString: json))
        XCTAssertEqual(message, expectedMessage)
    }

    func test_multipleErrorsSet_parsedCorrectly() {
        let json = "{ \"errors\" : [ \"error1\", \"error2\" ] }"
        let expectedMessage = "error1\r\nerror2"
        
        let message = ParticleErrorHelper.getErrorMessage(getJSONDict(withJSONString: json))
        XCTAssertEqual(message, expectedMessage)
    }

    func test_errorDictionarySet_parsedCorrectly() {
        let json = "{ \"errors\" : [ {\"error\" : \"error1\"}, {\"error\" : \"error2\"} ] }"
        let expectedMessage = "error1\r\nerror2"
        
        let message = ParticleErrorHelper.getErrorMessage(getJSONDict(withJSONString: json))
        XCTAssertEqual(message, expectedMessage)
    }
    
    func test_errorAndStatusDictionarySet_parsedCorrectly() {
        let json = "{ \"errors\" : [ {\"error\" : { \"status\" : \"error1\"} }, {\"error\" : { \"status\" : \"error2\"} } ] }"
        let expectedMessage = "error1\r\nerror2"
        
        let message = ParticleErrorHelper.getErrorMessage(getJSONDict(withJSONString: json))
        XCTAssertEqual(message, expectedMessage)
    }
    
    func test_noErrorSet_templateErrorReturned() {
        let json = "{ }"
        let expectedMessage = "Unknown error occurred."
        
        let message = ParticleErrorHelper.getErrorMessage(getJSONDict(withJSONString: json))
        XCTAssertEqual(message, expectedMessage)
    }
    

    func getJSONDict(withJSONString inputString: String) -> [AnyHashable: Any] {
        let data = inputString.data(using: .utf8)!
        return try! JSONSerialization.jsonObject(with: data, options: []) as! [AnyHashable: Any]
    }
}
