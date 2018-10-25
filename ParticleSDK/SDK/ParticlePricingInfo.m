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

        if ([params[@"cc_last4"] isKindOfClass:[NSNumber class]]) {
            _ccLast4 = [params[@"name"] intValue];
        }

        if ([params[@"plan_slug"] isKindOfClass:[NSString class]])
        {
            _planSlug = params[@"name"];
        }

        if ([params[@"plan"] isKindOfClass:[NSDictionary class]]) {
            _plan = params[@"plan"];
        }

        _planUpgradeNeeded = [params[@"plan_upgrade_needed"] boolValue] == YES;

        return self;
    }

    return nil;
}

@end