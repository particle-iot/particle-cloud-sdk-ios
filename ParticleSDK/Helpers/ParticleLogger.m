//
//  ParticleLogger.m
//  ParticleSDK
//
//  Created by Raimundas Sakalauskas on 27/11/2018.
//  Copyright © 2018 Particle Inc. All rights reserved.
//

#import "ParticleLogger.h"

NSString * const ParticleLogNotification = @"io.particle.log";
NSString * const ParticleLogNotificationTypeKey = @"io.particle.log.type";
NSString * const ParticleLogNotificationMessageKey = @"io.particle.log.message";

@implementation ParticleLogger

static ParticleLoggerLevel particleLoggerLevel = ParticleLoggerLevelOff;
static NSArray<NSString *> *ignoreControls = nil;

+ (void)setLoggerLevel:(ParticleLoggerLevel)level {
    particleLoggerLevel = level;
}

+ (void)setIgnoreControls:(NSArray<NSString *> *)list {
    ignoreControls = list;
}

+ (void)log:(NSString *)control type:(ParticleLogType)type format:(NSString *)format withParameters:(va_list)args {
    if (ignoreControls != nil && [ignoreControls containsObject:control]) {
        return;
    }

    NSDictionary *info = @{ ParticleLogNotificationTypeKey: @((int)type), ParticleLogNotificationMessageKey: [[NSString alloc] initWithFormat:format arguments:args] };
    if ((int)particleLoggerLevel >= (int)type) {
        [self logToConsole:control type:type message:info[ParticleLogNotificationMessageKey]];
    }

    [NSNotificationCenter.defaultCenter postNotificationName:ParticleLogNotification object:control userInfo:info];
}

+ (void)log:(NSString *)control type:(ParticleLogType)type format:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    [self log:control type:type format:format withParameters:args];
    va_end(args);
}



+ (void)logError:(NSString *)control format:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    [self log:control type:ParticleLogTypeError format:format withParameters: args];
    va_end(args);
}

+ (void)logError:(NSString *)control format:(NSString *)format withParameters:(va_list)args {
    [self log:control type:ParticleLogTypeError format:format withParameters: args];
}


+ (void)logInfo:(NSString *)control format:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    [self log:control type:ParticleLogTypeInfo format:format withParameters: args];
    va_end(args);
}

+ (void)logInfo:(NSString *)control format:(NSString *)format withParameters:(va_list)args {
    [self log:control type:ParticleLogTypeInfo format:format withParameters: args];
}


+ (void)logDebug:(NSString *)control format:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    [self log:control type:ParticleLogTypeDebug format:format withParameters: args];
    va_end(args);
}

+ (void)logDebug:(NSString *)control format:(NSString *)format withParameters:(va_list)args {
    [self log:control type:ParticleLogTypeDebug format:format withParameters: args];
}


+ (NSString *)logTypeStringFromType:(ParticleLogType)type {
    return [self logTypeStringFromInt:(int)type];
}

+ (NSString *)logTypeStringFromInt:(int)typeInt {
    switch (typeInt) {
        case (int)ParticleLogTypeError:
            return @"Error";
        case (int)ParticleLogTypeInfo:
            return @"Info";
        case (int)ParticleLogTypeDebug:
            return @"Debug";
        default:
            return @"Unknown";
    }
}

+ (void)logToConsole:(NSString *)control type:(ParticleLogType)type message:(NSString *)message {
    NSLog(@"(%@ %@): %@", control, [self logTypeStringFromType:type], message);
}

@end
