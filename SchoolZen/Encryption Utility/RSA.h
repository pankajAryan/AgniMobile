//  RSA.h
//   
//
//  Created by Ashish Singal on 04/11/14.
//  Copyright (c) 2014 Mobiquel. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void (^GenerateSuccessBlock)(void);

@interface RSA : NSObject
{
    
@private
    NSData * publicTag;
	NSData * privateTag;
    NSOperationQueue * cryptoQueue;
    GenerateSuccessBlock success;
}

@property (nonatomic,readonly) SecKeyRef publicKeyRef;
@property (nonatomic,readonly) SecKeyRef privateKeyRef;
@property (nonatomic,readonly) NSData   *publicKeyBits;
@property (nonatomic,readonly) NSData   *privateKeyBits;

+ (id)shareInstance;
- (NSData *)RSA_EncryptUsingPublicKeyWithData:(NSData *)data;
- (NSData *)RSA_DecryptUsingPrivateKeyWithData:(NSData*)data;
- (NSData*)rsaEncryptWithData:(NSData*)data;
- (NSData *)rsaEncryptWithData:(NSData*)data withAsIsKey:(SecKeyRef)key;

@end
