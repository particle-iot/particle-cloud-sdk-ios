//
//  KeychainHelperTests.swift
//  ParticleSDKTests
//
//  Created by Raimundas Sakalauskas on 13/12/2019.
//  Copyright © 2019 Particle Inc. All rights reserved.
//

import XCTest
@testable import ParticleSDK


class KeychainHelperTests: XCTestCase {

    var key:String!
    var expectedValue:String!
    var expectedValue2:String!

    override func setUp() {
        key = self.randomString(withLength: 20)
        expectedValue = self.randomString(withLength: 20)
        expectedValue2 = self.randomString(withLength: 20)
    }
    
    override func tearDown() {
        KeychainHelper.resetKeychainValue(forKey: key)
    }
   
    func test_keychainValueNotSet_valueIsNil(){
        XCTAssertNil(KeychainHelper.keychainValue(forKey: key))
    }
    
    func test_keychainValueSet_valueNotNil() {
        KeychainHelper.setKeychainValue(expectedValue, forKey: key)
        XCTAssertNotNil(KeychainHelper.keychainValue(forKey: key))
    }
    
    func test_keychainValueSet_valueIsSet() {
        KeychainHelper.setKeychainValue(expectedValue, forKey: key)
        XCTAssertEqual(KeychainHelper.keychainValue(forKey: key)!, expectedValue)
    }
    
    func test_keychainValueOverwritten_valueIsSet() {
        KeychainHelper.setKeychainValue(expectedValue, forKey: key)
        
        KeychainHelper.setKeychainValue(expectedValue2, forKey: key)
        XCTAssertEqual(KeychainHelper.keychainValue(forKey: key)!, expectedValue2)
    }
    
    func test_keychainValueReset_valueIsNil() {
        KeychainHelper.setKeychainValue(expectedValue, forKey: key)
        XCTAssertNotNil(KeychainHelper.keychainValue(forKey: key))
        
        KeychainHelper.resetKeychainValue(forKey: key)
        XCTAssertNil(KeychainHelper.keychainValue(forKey: key))
    }
        
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    func randomString(withLength len: Int) -> String {
        var randomString = ""
        
        for _ in 0 ..< len {
            randomString.append(letters.randomElement()!)
        }
        
        return randomString
    }
}
