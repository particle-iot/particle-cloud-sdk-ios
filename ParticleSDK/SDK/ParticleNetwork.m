//
//  ParticleNetwork.m
//  ParticleSDKPods
//
//  Created by Ido Kleinman on 9/24/18.
//  Copyright © 2018 Particle Inc. All rights reserved.
//

#import "ParticleNetwork.h"

#ifdef USE_FRAMEWORKS
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

@interface ParticleNetwork()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSURL *baseURL;
@end


@implementation ParticleNetwork
// analyze
//                                          200 OK
//                                          {
//                                          networks:
//                                              [{
//                                              id: ‘529c1bf761966a0d35883078’,
//                                              name: ‘my-network’,
//                                              state: ‘confirmed’,
//                                              type: ‘micro_wifi’,
//                                              last_heard: `2018-08-10T02:07:45Z`
//                                              device_count: 10, // all the devices
//                                              gateway_count: 1,
//
//                                              },
//                                              {
//                                                  ...
//                                              }],
//                                          meta: {
//                                          total_records: 3,
//                                          total_pages: 1
//                                          },
//                                          }

-(nullable instancetype)initWithParams:(NSDictionary *)params
{
    if (self = [super init])
    {
        _baseURL = [NSURL URLWithString:kParticleAPIBaseURL];
        if (!_baseURL) {
            return nil;
        }
        
        _name = nil;
        if ([params[@"name"] isKindOfClass:[NSString class]])
        {
            _name = params[@"name"];
        }
        
        _id = nil;
        if ([params[@"id"] isKindOfClass:[NSString class]])
        {
            _id = params[@"id"];
        }
        
        if ([params[@"type"] isKindOfClass:[NSString class]])
        {
            if ([params[@"type"] isEqualToString:@"micro_wifi"]) {
                    _type = ParticleNetworkTypeMicroWifi;
            } else if ([params[@"type"] isEqualToString:@"micro_cellular"]) {
                _type = ParticleNetworkTypeMicroCellular;
            } else if ([params[@"type"] isEqualToString:@"high_availability"]) {
                _type = ParticleNetworkTypeHighAvailability;
            } else if ([params[@"type"] isEqualToString:@"large_site"]) {
                _type = ParticleNetworkTypeLargeSite;
            } else {
                _type = ParticleNetworkTypeMicroWifi;
            }

        }
        
        _gatewayCount = 0;
        if ([params[@"gateway_count"] isKindOfClass:[NSNumber class]])
        {
            _gatewayCount = [params[@"gateway_count"] intValue];
        }
        
        _deviceCount = 0;
        if ([params[@"device_count"] isKindOfClass:[NSNumber class]])
        {
            _deviceCount = [params[@"device_count"] intValue];
        }
        
        _channel = 0;
        if ([params[@"channel"] isKindOfClass:[NSNumber class]])
        {
            _channel = [params[@"channel"] intValue];
        }
        
        // state...
        
        if ([params[@"last_heard"] isKindOfClass:[NSString class]])
        {
            // TODO: add to utils class as POSIX time to NSDate
            NSString *dateString = params[@"last_heard"];// "2015-04-18T08:42:22.127Z"
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            [formatter setLocale:posix];
            _lastHeard = [formatter dateFromString:dateString];
        }

        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        if (!self.manager) return nil;
        
        return self;
    }
    
    return nil;
}

-(NSURLSessionDataTask *)modify:(ParticleNetworkModifyAction)action
                       deviceID:(NSString *)deviceID
                     completion:(nullable ParticleCompletionBlock)completion
{
    return nil;
}



@end
