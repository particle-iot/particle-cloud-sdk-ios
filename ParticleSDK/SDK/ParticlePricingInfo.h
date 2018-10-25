//
// Created by Raimundas Sakalauskas on 24/10/2018.
//

#import <Foundation/Foundation.h>


@interface ParticlePricingInfo : NSObject
    @property (nonatomic) BOOL allowed;
    @property (nonatomic) BOOL chargeable;
    @property (nonatomic) BOOL ccOnFile;
    @property (nonatomic) int ccLast4;
    @property (strong, nonatomic, nullable) NSString *planSlug;
    @property (strong, nonatomic, nonnull) NSDictionary *plan;
    @property (nonatomic) BOOL planUpgradeNeeded;

- (instancetype)initWithParams:(NSDictionary *)params;

@end
