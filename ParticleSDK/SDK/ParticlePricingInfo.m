//
// Created by Raimundas Sakalauskas on 24/10/2018.
//

#import "ParticlePricingInfo.h"


@implementation ParticlePricingInfo

-(instancetype)initWithParams:(NSDictionary *)params
{
    if (self = [super init])
    {
        _allowed = [params[@"allowed"] boolValue] == YES;
        _chargeable = [params[@"chargeable"] boolValue] == YES;
        _ccOnFile = [params[@"cc_on_file"] boolValue] == YES;

        if ([params[@"cc_last4"] isKindOfClass:[NSString class]]) {
            _ccLast4 = params[@"cc_last4"];
        }

        if ([params[@"plan_slug"] isKindOfClass:[NSString class]])
        {
            _planSlug = params[@"plan_slug"];
        }

        if ([params[@"plan"] isKindOfClass:[NSDictionary class]]) {
            _plan = [[ParticlePricingPlanInfo alloc] initWithParams:params[@"plan"]];
        }

        _planUpgradeNeeded = [params[@"plan_upgrade_needed"] boolValue] == YES;

        return self;
    }

    return nil;
}

@end


@implementation ParticlePricingPlanInfo

-(instancetype)initWithParams:(NSDictionary *)params
{
    if (self = [super init])
    {
        if ([params[@"free_device_max_count"] isKindOfClass:[NSNumber class]]) {
            _freeDeviceMaxCount = [params[@"free_device_max_count"] intValue];
        }

        if ([params[@"free_devices_available_count"] isKindOfClass:[NSNumber class]]) {
            _freeDevicesAvailableCount = [params[@"free_devices_available_count"] intValue];
        }

        if ([params[@"free_wifi_network_max_count"] isKindOfClass:[NSNumber class]]) {
            _freeWifiNetworkMaxCount = [params[@"free_wifi_network_max_count"] intValue];
        }

        if ([params[@"free_wifi_networks_available_count"] isKindOfClass:[NSNumber class]]) {
            _freeWifiNetworksAvailableCount = [params[@"free_wifi_networks_available_count"] intValue];
        }

        if ([params[@"included_node_count"] isKindOfClass:[NSNumber class]]) {
            _includedNodeCount = [params[@"included_node_count"] intValue];
        }

        if ([params[@"included_gateway_count"] isKindOfClass:[NSNumber class]]) {
            _includedGatewayCount = [params[@"included_gateway_count"] intValue];
        }

        if ([params[@"included_data_mb"] isKindOfClass:[NSNumber class]]) {
            _includedDataMb = [params[@"included_data_mb"] intValue];
        }

        if ([params[@"free_months"] isKindOfClass:[NSNumber class]]) {
            _freeMonths = [params[@"free_months"] intValue];
        }

        if ([params[@"monthly_base_amount"] isKindOfClass:[NSString class]]) {
            _monthlyBaseAmount = [NSDecimalNumber decimalNumberWithDecimal:[params[@"monthly_base_amount"] decimalValue]];
        }

        if ([params[@"overage_min_cost_mb"] isKindOfClass:[NSString class]]) {
            _overageMinCostMb = [NSDecimalNumber decimalNumberWithDecimal:[params[@"overage_min_cost_mb"] decimalValue]];
        }

        return self;
    }

    return nil;
}

@end