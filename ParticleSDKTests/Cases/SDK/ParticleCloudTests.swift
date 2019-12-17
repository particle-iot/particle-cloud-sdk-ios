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

    let expectedClaimCode: String = "some+claim+code"
    let expectedDevice1: String = "some+device+id1"
    let expectedDevice2: String = "some+device+id2"

    func setupAccessTokenDict() -> Dictionary<String,Any>  {
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

    func setupClaimCodeDict() -> Dictionary<String, Any> {
        let string = """
                     {
                         "claim_code": "\(expectedClaimCode)",
                         "device_ids": [
                             "\(expectedDevice1)",
                             "\(expectedDevice2)"
                         ]
                     }
                     """
        let data = string.data(using: .utf8)!
        return try! JSONSerialization.jsonObject(with: data, options : .allowFragments) as! Dictionary<String,Any>
    }
    
    func test_generateAccessToken_notNil() {
        let json = setupAccessTokenDict()
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


    func test_generateClaimCode_notNil() {
        let json = setupClaimCodeDict()
        stub(condition: isPath("/v1/device_claims")) {
            _ -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(jsonObject: json as Any, statusCode: 200, headers: nil)
        }

        let expected = expectation(description: "Generate claim code endpoint returns request")


        var generatedClaimCode: String!
        var receivedDevices: [String]!
        sut.generateClaimCode { claimCode, devices, error in
            generatedClaimCode = claimCode
            receivedDevices = devices as? [String]
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
        XCTAssertEqual(generatedClaimCode, self.expectedClaimCode)
    }

    func test_generateClaimCode_deviceIdsAreCorrect() {
        let json = setupClaimCodeDict()
        stub(condition: isPath("/v1/device_claims")) {
            _ -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(jsonObject: json as Any, statusCode: 200, headers: nil)
        }

        let expected = expectation(description: "Generate claim code endpoint returns request")


        var generatedClaimCode: String!
        var receivedDevices: [String]!
        sut.generateClaimCode { claimCode, devices, error in
            generatedClaimCode = claimCode
            receivedDevices = devices as? [String]
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
        XCTAssertTrue(receivedDevices.contains(self.expectedDevice1))
        XCTAssertTrue(receivedDevices.contains(self.expectedDevice2))
    }
    
    
}
