//
//  ParticleCloudTests.swift
//  ParticleSDKTests
//
//  Created by Raimundas Sakalauskas on 10/12/2019.
//  Copyright © 2019 Particle Inc. All rights reserved.
//

import XCTest
@testable import ParticleSDK
import OHHTTPStubs

class ParticleCloudTests: XCTestCase {

    private var sut: ParticleCloud!
    
    override func setUp() {
        sut = ParticleCloud.sharedInstance()
    }

    override func tearDown() {
        sut = nil
        OHHTTPStubs.removeAllStubs()
    }

    func test_whenInitialized_baseURLNotNil() {
        XCTAssertNotNil(sut.currentBaseURL)
    }

    let expectedAccessToken: String = "some+access+token"
    let expectedTokenType: String = "bearer"
    let expectedExpiresIn: String = "6000"
    let expectedRefreshToken: String = "some+refresh+token"

    func setupCorrectDict() -> Dictionary<String,Any> {
        let string = """
                     {
                         "token_type": "\(expectedTokenType)",
                         "access_token": "\(expectedAccessToken)",
                         "expires_in": \(expectedExpiresIn),
                         "refresh_token": "\(expectedRefreshToken)"
                     }
                     """
        let data = string.data(using: .utf8)!
        return try! JSONSerialization.jsonObject(with: data, options : .allowFragments) as! Dictionary<String,Any>
    }
    
    func test_generateAccessToken_notNil() {
        let json = setupCorrectDict()
        stub(condition: isPath("/oauth/token")) {
            _ -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(jsonObject: json as Any, statusCode: 200, headers: nil)
        }
        
        let expected = expectation(description: "Login endpoint returns request")
        sut.login(withUser: "user", password: "password") { (error) in
            expected.fulfill()
        }
        
        wait(for: [expected], timeout: 1)
        XCTAssertEqual(sut.accessToken, self.expectedAccessToken)
    }
}
