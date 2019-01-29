//
// Created by Raimundas Sakalauskas on 24/10/2018.
//

#import <Foundation/Foundation.h>

@interface ParticlePricingPlanInfo : NSObject

@property (nonatomic) int freeDeviceMaxCount;
@property (nonatomic) int freeDevicesAvailableCount;
@property (nonatomic) int freeWifiNetworkMaxCount;
@property (nonatomic) int freeWifiNetworksAvailableCount;
@property (nonatomic) int includedNodeCount;
@property (nonatomic) int includedGatewayCount;
@property (nonatomic) int includedDataMb;
@property (nonatomic) int freeMonths;

@property (strong, nonatomic, nullable) NSDecimalNumber *monthlyBaseAmount;
@property (strong, nonatomic, nullable) NSDecimalNumber *overageMinCostMb;

- (instancetype)initWithParams:(NSDictionary *)params;

@end

@interface ParticlePricingInfo : NSObject
    @property (nonatomic) BOOL allowed;
    @property (nonatomic) BOOL chargeable;
    @property (nonatomic) BOOL ccOnFile;
    @property (strong, nonatomic, nullable) NSString *ccLast4;
    @property (strong, nonatomic, nullable) NSString *planSlug;
    @property (strong, nonatomic, nonnull) ParticlePricingPlanInfo *plan;
    @property (nonatomic) BOOL planUpgradeNeeded;

- (instancetype)initWithParams:(NSDictionary *)params;

@end



