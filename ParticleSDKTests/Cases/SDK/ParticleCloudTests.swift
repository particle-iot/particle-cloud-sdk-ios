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

    func test_generateAccessToken_notNil() {
        var expectedAccessToken: String = "some+access+token"
        let string = """
        {
            "token_type": "bearer",
            "access_token": "\(expectedAccessToken)",
            "expires_in": 7776000,
            "refresh_token": "5343db5c9737cff45bc734ac44b19780753389ea"
        }
        """
        let data = string.data(using: .utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any>
        
        stub(condition: isPath("/oauth/token")) {
            _ -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(jsonObject: json, statusCode: 200, headers: nil)
        }
        
        let expected = expectation(description: "Claim code endpoint returns response")
        sut.login(withUser: "user", password: "password") { (error) in
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
        
        XCTAssertEqual(sut.accessToken!, "some+access+token")
    }
}
