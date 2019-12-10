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
}
