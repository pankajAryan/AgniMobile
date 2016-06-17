
//
//  PBEWithMD5andDES.h
//  PBEWithMD5andDES-Sample
//
//  Created by Ashish Singal on 03/11/14.
//  Copyright (c) 2014 Ashish Singal. All rights reserved.

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface PBEWithMD5AndDES : NSObject

+(NSData*) cryptPBEWithMD5AndDES:(CCOperation)op

                       usingData:(NSData*)data

                    withPassword:(NSString*)password

                         andSalt:(NSData*)salt

                    andIterating:(NSInteger)numIterations;


+ (NSString*) encrypt:(NSString *)str password:(NSString *)pwd;

+ (NSString*) decrypt:(NSString *)str password:(NSString *)pwd;


+ (NSString *)encrypt:(NSString *)encryptValue KEY:(NSString*)key;

@end
