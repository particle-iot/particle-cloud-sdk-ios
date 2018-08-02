//
//  ErrorHelperTests.m
//  ParticleSDKTests
//
//  Created by Raimundas Sakalauskas on 12/07/2018.
//  Copyright © 2018 Ido Kleinman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ErrorHelper.h"

@interface ErrorHelperTests : XCTestCase

@end

@implementation ErrorHelperTests

- (void)testErrorMessage {
    NSString *message;

    //error_description should be prioritized against error
    //{ error: 'error1', error_description: 'error2' }
    message = [ErrorHelper getErrorMessage:[self getJSONDictionary:
            @"{ \"error\" : \"error1\", \"error_description\": \"error2\" }"]];
    XCTAssertTrue([message isEqualToString:@"error2"]);

    //{ error: 'error1' }
    message = [ErrorHelper getErrorMessage:[self getJSONDictionary:
                                            @"{ \"error\" : \"error1\" }"]];
    XCTAssertTrue([message isEqualToString:@"error1"]);


    //{ err: 'error1' }
    message = [ErrorHelper getErrorMessage:[self getJSONDictionary:
                                            @"{ \"err\" : \"error1\" }"]];
    XCTAssertTrue([message isEqualToString:@"error1"]);
    
    
    //{ info: 'error1' }
    message = [ErrorHelper getErrorMessage:[self getJSONDictionary:
                                            @"{ \"info\" : \"error1\"  }"]];
    XCTAssertTrue([message isEqualToString:@"error1"]);
    
    
    
    //{ errors: ['error1', 'error2'] }
    message = [ErrorHelper getErrorMessage:[self getJSONDictionary:
                                            @"{ \"errors\" : [ \"error1\", \"error2\" ] }"]];
    XCTAssertTrue([message isEqualToString:@"error1\r\nerror2"]);
    
    

    //{ errors: [ { error: 'error1' }, { error: 'error2' } ] }
    message = [ErrorHelper getErrorMessage:[self getJSONDictionary:
                                            @"{ \"errors\" : [ {\"error\" : \"error1\"}, {\"error\" : \"error2\"} ] }"]];
    XCTAssertTrue([message isEqualToString:@"error1\r\nerror2"]);


    
    //{ errors: [ { error: { status: 'error1' } }, { error: { status: 'error2' } } ] }
    message = [ErrorHelper getErrorMessage:[self getJSONDictionary:
                                            @"{ \"errors\" : [ {\"error\" : { \"status\" : \"error1\"} }, {\"error\" : { \"status\" : \"error2\"} } ] }"]];
    XCTAssertTrue([message isEqualToString:@"error1\r\nerror2"]);
    
    
    
    // { }
    message = [ErrorHelper getErrorMessage:[self getJSONDictionary:@"{ }"]];
    XCTAssertTrue([message isEqualToString:@"Unknown error occurred."]);
}

- (NSDictionary *)getJSONDictionary:(NSString *)jsonString {
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
