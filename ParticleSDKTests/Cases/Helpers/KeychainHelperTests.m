//
//  KeychainHelperTests.m
//  ParticleSDKTests
//
//  Created by Raimundas Sakalauskas on 17/07/2018.
//  Copyright © 2018 Particle Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KeychainHelper.h"

@interface KeychainHelperTests : XCTestCase

@end



@implementation KeychainHelperTests

- (void)testKeychainHelperValueCycle {
    NSString *key = [self randomStringWithLength:20];
    NSString *value = [self randomStringWithLength:20];
    NSString *value2 = [self randomStringWithLength:20];
    
    NSString *retrievedValue;
    
    XCTAssertNil([KeychainHelper keychainValueForKey:key]);
    
    [KeychainHelper setKeychainValue:value forKey:key];
    retrievedValue = [KeychainHelper keychainValueForKey:key];
    XCTAssertTrue([retrievedValue isEqualToString:value]);
    
    [KeychainHelper setKeychainValue:value2 forKey:key];
    retrievedValue = [KeychainHelper keychainValueForKey:key];
    XCTAssertTrue([retrievedValue isEqualToString:value2]);
    
    [KeychainHelper resetKeychainValueForKey:key];
    XCTAssertNil([KeychainHelper keychainValueForKey:key]);
}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

@end
