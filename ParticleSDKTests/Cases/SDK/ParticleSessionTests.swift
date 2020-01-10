//
//  ParticleSessionTests.swift
//  ParticleSDKTests
//
//  Created by Raimundas Sakalauskas on 11/12/2019.
//  Copyright © 2019 Particle Inc. All rights reserved.
//

import XCTest
@testable import ParticleSDK

class ParticleSessionTests: XCTestCase {

    let expectedAccessToken: String = "some+access+token"
    let expectedRefreshToken: String = "some+refresh+token"

    func setupCorrectDict() -> Dictionary<String,Any> {
        let string = """
                     {
                         "token_type": "bearer",
                         "expires_in": 6000,
                         "access_token": "\(expectedAccessToken)",
                         "refresh_token": "\(expectedRefreshToken)"
                     }
                     """
        let data = string.data(using: .utf8)!
        return try! JSONSerialization.jsonObject(with: data, options : .allowFragments) as! Dictionary<String,Any>
    }

    func test_initWithDict_sessionNotNil(){
        let dict = setupCorrectDict()
        let sut = ParticleSession(newSession: dict)
        
        XCTAssertNotNil(sut)
    }
    
    func test_initWithoutBearer_sessionNil() {
        var dict = setupCorrectDict()
        dict["token_type"] = nil
        
        let sut = ParticleSession(newSession: dict)
        
        XCTAssertNil(sut)
    }

    func test_initWithoutExpiresIn_sessionNil() {
        var dict = setupCorrectDict()
        dict["expires_in"] = nil
        
        let sut = ParticleSession(newSession: dict)
        
        XCTAssertNil(sut)
    }
    
    func test_initWithDict_allButUsernameValuesAreNotNil(){
        let dict = setupCorrectDict()
        let sut = ParticleSession(newSession: dict)
        
        XCTAssertNotNil(sut?.accessToken)
        XCTAssertNotNil(sut?.refreshToken)
        XCTAssertNil(sut?.username)
    }
    
    func test_initWithDict_valuesAsExpected() {
        let dict = setupCorrectDict()
        let sut = ParticleSession(newSession: dict)
        
        XCTAssertEqual(sut?.accessToken, expectedAccessToken)
        XCTAssertEqual(sut?.refreshToken, expectedRefreshToken)
    }
    
    
    func test_initWithToken_sessionNotNil() {
        let sut = ParticleSession(token: expectedAccessToken)
        
        XCTAssertNotNil(sut)
    }
    
    func test_initWithToken_valuesAreSet(){
        let sut = ParticleSession(token: expectedAccessToken)
        
        XCTAssertEqual(sut?.accessToken, expectedAccessToken)
        XCTAssertNil(sut?.refreshToken)
        XCTAssertNil(sut?.username)
    }
    
}
