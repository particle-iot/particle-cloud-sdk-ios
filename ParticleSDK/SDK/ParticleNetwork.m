//
//  ParticleNetwork.m
//  ParticleSDKPods
//
//  Created by Ido Kleinman on 9/24/18.
//  Copyright © 2018 Particle Inc. All rights reserved.
//

#import "ParticleNetwork.h"
#import "ParticleErrorHelper.h"


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
        
        _notes = nil;
        if ([params[@"notes"] isKindOfClass:[NSString class]])
        {
            _notes = params[@"notes"];
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


-(NSURLSessionDataTask *)_takeNetworkAction:(NSString *)action
                                  deviceID:(NSString *)deviceID
                                completion:(nullable ParticleCompletionBlock)completion
{
    // TODO: put /v1/networks
    
    NSMutableDictionary *params = [@{
                                     @"action": action,
                                     @"deviceID": deviceID,
                                     } mutableCopy];
    
    NSString *url = [NSString stringWithFormat:@"/v1/networks/%@", self.id];
    
    NSURLSessionDataTask *task = [self.manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject)
                                  {
                                      NSDictionary *responseDict = responseObject;
                                      if (completion) {
                                          if ([responseDict[@"ok"] boolValue])
                                          {
                                              completion(nil);
                                          }
                                          else
                                          {
                                              NSString *errorString;
                                              if (responseDict[@"errors"][0])
                                                  errorString = [NSString stringWithFormat:@"Could not modify network: %@",responseDict[@"errors"][0]];
                                              else
                                                  errorString = @"Error modifying network";
                                              
                                              NSError *particleError = [ParticleErrorHelper getParticleError:nil task:task customMessage:errorString];
                                              
                                              completion(particleError);
                                              
                                              NSLog(@"! takeNetworkAction (%@) Failed %@ (%ld): %@\r\n%@", action, task.originalRequest.URL, (long)particleError.code, particleError.localizedDescription, particleError.userInfo[ParticleSDKErrorResponseBodyKey]);
                                          }
                                      }
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                                  {
                                      NSError *particleError = [ParticleErrorHelper getParticleError:error task:task customMessage:nil];
                                      
                                      if (completion) {
                                          completion(particleError);
                                      }
                                      
                                      NSLog(@"! takeNetworkAction (%@) Failed %@ (%ld): %@\r\n%@", action, task.originalRequest.URL, (long)particleError.code, particleError.localizedDescription, particleError.userInfo[ParticleSDKErrorResponseBodyKey]);
                                  }];
    
    [self.manager.requestSerializer clearAuthorizationHeader];
    
    return task;
}


-(NSURLSessionDataTask *)addDevice:(NSString *)deviceID
                        completion:(nullable ParticleCompletionBlock)completion
{
    return [self _takeNetworkAction:@"add-device" deviceID:deviceID completion:completion];
    
}

-(NSURLSessionDataTask *)removeDevice:(NSString *)deviceID
                           completion:(nullable ParticleCompletionBlock)completion
{
    return [self _takeNetworkAction:@"remove-device" deviceID:deviceID completion:completion];
    
}

-(NSURLSessionDataTask *)enableGatewayDevice:(NSString *)deviceID
                                  completion:(nullable ParticleCompletionBlock)completion
{
    return [self _takeNetworkAction:@"gateway-enable" deviceID:deviceID completion:completion];
}

-(NSURLSessionDataTask *)disableGatewayDevice:(NSString *)deviceID
                                   completion:(nullable ParticleCompletionBlock)completion
{
    return [self _takeNetworkAction:@"gateway-disable" deviceID:deviceID completion:completion];
    
}

-(NSURLSessionDataTask *)refresh:(nullable ParticleCompletionBlock)completion
{
    
    
    return nil;
}



@end
