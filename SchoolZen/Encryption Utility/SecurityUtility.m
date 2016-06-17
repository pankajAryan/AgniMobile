//
//  SecurityUtility.m
//  PBEWithMD5andDES-Sample
//
//  Created by Ashish Singal on 03/11/14.
//  Copyright (c) 2014 Ashish Singal. All rights reserved.
//

#import "SecurityUtility.h"
#import <CommonCrypto/CommonDigest.h>
@implementation SecurityUtility

+ (NSData*) UTF8StringToData:(NSString*)str{
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)bytesToHexStr:(NSData *)data
{
    NSMutableString *hexStr = [NSMutableString string];
    unsigned char *bytes = (unsigned char *)[data bytes];
    
    char temp[3];
    int i = 0;
    
    for (i = 0; i < [data length]; i++) {
        temp[0] = temp[1] = temp[2] = 0;
        (void)sprintf(temp, "%02x", bytes[i]);
        [hexStr appendString:[NSString stringWithUTF8String:temp]];
    }
    return hexStr;
}
+ (NSData*) hexStrToBytes:(NSString*)strHex
{
    NSMutableData* data = [[NSMutableData alloc] init] ;
    int idx;
    for (idx = 0; idx+2 <= strHex.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [strHex substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
+ (NSString *)bytesToBase64Data:(NSData *)data
{
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    return base64String;
}
+ (NSData*) Base64DatatoBytes:(NSString*)base64String
{
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    return decodedData;
}

+ (NSString*) DataToUTF8String:(NSData*)data{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
}

/*
 Encryption logic with rsa
 */
+(NSString *)encryptRSA:(NSString *)plainTextString key:(SecKeyRef)publicKey
{
    size_t cipherBufferSize = SecKeyGetBlockSize(publicKey);
    uint8_t *cipherBuffer = malloc(cipherBufferSize);
    uint8_t *nonce = (uint8_t *)[plainTextString UTF8String];
    SecKeyEncrypt(publicKey,
                  kSecPaddingOAEP,
                  nonce,
                  strlen( (char*)nonce ),
                  &cipherBuffer[0],
                  &cipherBufferSize);
    NSData *encryptedData = [NSData dataWithBytes:cipherBuffer length:cipherBufferSize];
    return [self bytesToBase64Data:encryptedData];
}

@end