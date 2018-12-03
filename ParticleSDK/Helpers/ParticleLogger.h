//
//  ParticleLogger.h
//  ParticleSDK
//
//  Created by Raimundas Sakalauskas on 27/11/2018.
//  Copyright © 2018 Particle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const ParticleLogNotification;
FOUNDATION_EXPORT NSString * const ParticleLogNotificationTypeKey;
FOUNDATION_EXPORT NSString * const ParticleLogNotificationMessageKey;

typedef NS_ENUM(NSInteger, ParticleLogType) {
    ParticleLogTypeError=0,
    ParticleLogTypeInfo=1,
    ParticleLogTypeDebug=2
};

typedef NS_ENUM(NSInteger, ParticleLoggerLevel) {
    ParticleLoggerLevelOff=-1,
    ParticleLoggerLevelError=0,
    ParticleLoggerLevelInfo=1,
    ParticleLoggerLevelDebug=2
};


@interface ParticleLogger : NSObject

+ (void)setLoggerLevel:(ParticleLoggerLevel)level;
+ (void)setIgnoreControls:(NSArray<NSString *> *)list;

+ (void)log:(NSString *)control type:(ParticleLogType)type format:(NSString *)format withParameters:(va_list)args;
+ (void)log:(NSString *)control type:(ParticleLogType)type format:(NSString *)format, ...;

+ (void)logError:(NSString *)control format:(NSString *)format, ...;
+ (void)logError:(NSString *)control format:(NSString *)format withParameters:(va_list)args;

+ (void)logInfo:(NSString *)control format:(NSString *)format, ...;
+ (void)logInfo:(NSString *)control format:(NSString *)format withParameters:(va_list)args;

+ (void)logDebug:(NSString *)control format:(NSString *)format, ...;
+ (void)logDebug:(NSString *)control format:(NSString *)format withParameters:(va_list)args;

+ (NSString *)logTypeStringFromType:(ParticleLogType)type;
+ (NSString *)logTypeStringFromInt:(int)typeInt;

@end

NS_ASSUME_NONNULL_END
