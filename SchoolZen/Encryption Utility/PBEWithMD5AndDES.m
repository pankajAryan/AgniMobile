//
//  PBEWithMD5andDES.m
//  PBEWithMD5andDES-Sample
//
//  Created by Ashish Singal on 03/11/14.
//  Copyright (c) 2014 Ashish Singal. All rights reserved.
//

#import "PBEWithMD5AndDES.h"
#import "SecurityUtility.h"

static NSString *defaultPwd = @"WoAiBeiJingTianAnMen";
//static Byte salt2[] = { 24, -121, -109, 109, 53, 58, 106, -96 };//running algo

//my salt
//static Byte salt[] = { 168, 155, 200, 50, 86, 52, 227 , 3};//running algo

static Byte salt[] = { 2, 3, 4, 5, 6, 7, 8 , 9};//running algo

//		byte[] salt = { (byte) 0xA8/168, (byte) 0x9B//155, (byte) 0xC8, (byte) 0x32,(byte) 0x56, (byte) 0x34, (byte) 0xE3, (byte) 0x03 };
//		byte[] salt = { (byte) 0x02, (byte) 0x03, (byte) 0x04, (byte) 0x05,(byte) 0x06, (byte) 0x07, (byte) 0x08, (byte) 0x09 };


static NSInteger numIterations = 20;

@implementation PBEWithMD5AndDES

#pragma mark-
#pragma mark-DES加密
+(NSData*) cryptPBEWithMD5AndDES:(CCOperation)op
                       usingData:(NSData*)data
                    withPassword:(NSString*)password
                         andSalt:(NSData*)salt
                    andIterating:(NSInteger)numIterations
{
    
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    memset(md5, 0, CC_MD5_DIGEST_LENGTH);
    NSData* passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    
    CC_MD5_CTX ctx;
    CC_MD5_Init(&ctx);
    CC_MD5_Update(&ctx, [passwordData bytes], (unsigned int)[passwordData length]);
    CC_MD5_Update(&ctx, [salt bytes], (unsigned int)[salt length]);
    CC_MD5_Final(md5, &ctx);
    
    for (int i=1; i<numIterations; i++) {
        CC_MD5(md5, CC_MD5_DIGEST_LENGTH, md5);
    }
    
    size_t cryptoResultDataBufferSize = [data length] + kCCBlockSizeDES;//
    unsigned char cryptoResultDataBuffer[cryptoResultDataBufferSize];
    size_t dataMoved = 0;
    
    unsigned char iv[kCCBlockSizeDES];
    memcpy(iv, md5 + (CC_MD5_DIGEST_LENGTH/2), sizeof(iv)); //iv is the second half of the MD5 from building the key
    
    CCCryptorStatus status = CCCrypt(op, kCCAlgorithm3DES, kCCOptionPKCS7Padding, md5, (CC_MD5_DIGEST_LENGTH/2), iv, [data bytes], [data length],cryptoResultDataBuffer, cryptoResultDataBufferSize, &dataMoved);
    
    if(0 == status)
    {
        NSLog(@"rsult===%@", [NSData dataWithBytes:cryptoResultDataBuffer length:dataMoved]);
        return [NSData dataWithBytes:cryptoResultDataBuffer length:dataMoved];
    } else {
        return NULL;
    }
}

+ (NSString*) encrypt:(NSString *)str password:(NSString *)pwd
{
    NSAssert(str, @"encrypt:str is nil");
    
    if ([pwd isEqualToString:@""] || pwd == nil) {
       // pwd = defaultPwd;
        NSLog(@"encrypt:pwd = %@", pwd);
    }
    
    NSData *dataSalt = [[NSData alloc] initWithBytes:salt length:8] ;
    NSData *dataStr = [SecurityUtility UTF8StringToData:str];
    NSData *dataResult = [PBEWithMD5AndDES cryptPBEWithMD5AndDES:kCCEncrypt
                                                       usingData:dataStr
                                                    withPassword:pwd
                                                         andSalt:dataSalt
                                                    andIterating:numIterations];
    
   // NSString *strResult = [UtilityClass bytesToHexStr:dataResult];
    NSString *strResult = [SecurityUtility bytesToBase64Data:dataResult];
    return strResult;
}

+ (NSString*) decrypt:(NSString *)str password:(NSString *)pwd
{
    NSAssert(str, @"decrypt:str is nil");
    
    if ([pwd isEqualToString:@""] || pwd == nil) {
        pwd = defaultPwd;
        NSLog(@"decrypt:pwd = %@", pwd);
    }
    
    NSData *dataSalt = [[NSData alloc] initWithBytes:salt length:8];
    
    NSData *dataStr = [SecurityUtility Base64DatatoBytes:str];
    
    NSData *dataResult = [PBEWithMD5AndDES cryptPBEWithMD5AndDES:kCCDecrypt
                                                       usingData:dataStr
                                                    withPassword:pwd
                                                         andSalt:dataSalt
                                                    andIterating:numIterations];
    
    NSString *strResult = [SecurityUtility DataToUTF8String:dataResult];
    return strResult;
}



#pragma mark - more implementation
+ (NSString *)encrypt:(NSString *)encryptValue KEY:(NSString*)key
{
    // first of all we need to prepare key with md5
    // setup md5 context with salt and key
    //NSString *key = @"1234";
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    memset(md5Buffer, 0, CC_MD5_DIGEST_LENGTH);
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    CC_MD5_CTX md5Ctx;
    CC_MD5_Init(&md5Ctx);
    CC_MD5_Update(&md5Ctx, [keyData bytes], (unsigned int)[keyData length]);
    
    //		byte[] salt = { (byte) 0xA8/168, (byte) 0x9B//155, (byte) 0xC8, (byte) 0x32,(byte) 0x56, (byte) 0x34, (byte) 0xE3, (byte) 0x03 };

    unsigned char salt[] =  {0xA8,0x9B,0xC8,0x32,0x56,0x34,0xE3,0x03};
    CC_MD5_Update(&md5Ctx, salt, 8);
    CC_MD5_Final(md5Buffer, &md5Ctx);
    
    // do md5 hashing
    for (int i=1; i<numIterations; i++) {
        CC_MD5(md5Buffer, CC_MD5_DIGEST_LENGTH, md5Buffer);
    }

    
    // our key is ready, let's prepare other buffers and moved bytes length
    NSData *encryptData = [encryptValue dataUsingEncoding:NSUTF8StringEncoding];
    size_t resultBufferSize = [encryptData length] + kCCBlockSizeDES;
    unsigned char resultBuffer[resultBufferSize];
    size_t moved = 0;
    
    // DES-CBC requires an explicit Initialization Vector (IV)
    // IV - second half of md5 key
    unsigned char IV[kCCBlockSizeDES];
    memcpy(IV, md5Buffer + CC_MD5_DIGEST_LENGTH / 2, sizeof(IV));
    
    CCCryptorStatus cryptorStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                            kCCOptionPKCS7Padding, md5Buffer,
                                            CC_MD5_DIGEST_LENGTH/2, IV,
                                            [encryptData bytes], [encryptData length],
                                            resultBuffer, resultBufferSize, &moved);
    
    if (cryptorStatus == kCCSuccess) {
        return [[NSData dataWithBytes:resultBuffer length:moved] base64EncodedStringWithOptions:0];
    } else {
        return nil;
    }
}

@end