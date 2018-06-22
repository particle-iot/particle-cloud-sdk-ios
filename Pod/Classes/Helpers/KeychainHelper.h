//
// Created by Raimundas Sakalauskas on 22/06/2018.
//

#import <Foundation/Foundation.h>


@interface KeychainHelper : NSObject

+ (NSString *)keychainValueForKey:(NSString *)key;
+ (void)resetKeychainValueForKey:(NSString *)key;
+ (void)setKeychainValue:(NSString *)value forKey:(NSString *)key;

@end