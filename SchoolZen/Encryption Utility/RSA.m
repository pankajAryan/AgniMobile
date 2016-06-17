//  RSA.m
//   
//
//  Created by Ashish Singal on 04/11/14.
//  Copyright (c) 2014 Mobiquel. All rights reserved.
//
#import "RSA.h"

uint8_t *plainBuffer;
uint8_t *cipherBuffer;
uint8_t *decryptedBuffer;

const size_t BUFFER_SIZE = 64;
const size_t CIPHER_BUFFER_SIZE = 1024;
const uint32_t PADDING = kSecPaddingPKCS1;
const size_t kSecAttrKeySizeInBitsLength = 2024;


#if DEBUG
    #define LOGGING_FACILITY(X, Y)	\
    NSAssert(X, Y);

    #define LOGGING_FACILITY1(X, Y, Z)	\
    NSAssert1(X, Y, Z);
#else
    #define LOGGING_FACILITY(X, Y)	\
    if (!(X)) {			\
        NSLog(Y);		\
    }

    #define LOGGING_FACILITY1(X, Y, Z)	\
    if (!(X)) {				\
        NSLog(Y, Z);		\
    }
#endif

@implementation RSA
@synthesize publicKeyRef,privateKeyRef;
@synthesize publicKeyBits,privateKeyBits;

#pragma mark - INITIALIZATION

- (id)init{
    if (self = [super init]) {
        cryptoQueue = [[NSOperationQueue alloc] init];
    }return self;
}

+ (id)shareInstance{
    static RSA *_rsa = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _rsa = [[self alloc] init];
    });
    return _rsa;
}
#pragma mark - ENCRYPTION

- (NSData*)rsaEncryptWithData:(NSData*)data
{
    SecKeyRef key = [self getKeyFromBundleIBM];
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    memset((void *)cipherBuffer, 0*0, cipherBufferSize);
    
    NSData *plainTextBytes = data;
    size_t blockSize = cipherBufferSize - 11;
    size_t blockCount = (size_t)ceil([plainTextBytes length] / (double)blockSize);
    NSMutableData *encryptedData = [NSMutableData dataWithCapacity:0];
    
    for (int i=0; i<blockCount; i++) {
        
        NSInteger bufferSize = MIN(blockSize,[plainTextBytes length] - i * blockSize);
        NSData *buffer = [plainTextBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        
        //encryption with padding
        OSStatus status = SecKeyEncrypt(key,
                                        kSecPaddingPKCS1,
                                        (const uint8_t *)[buffer bytes],
                                        [buffer length],
                                        cipherBuffer,
                                        &cipherBufferSize);
        
        
        /*
         //encryption with none padding.
         OSStatus status = SecKeyEncrypt(key,
         kSecPaddingNone,
         (const uint8_t *)[buffer bytes],
         [buffer length],
         cipherBuffer,
         &cipherBufferSize);
         
         */
        
        if (status == noErr){
            NSData *encryptedBytes = [NSData dataWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
            
        }else{
            
            if (cipherBuffer) {
                free(cipherBuffer);
            }
            return nil;
        }
    }
    if (cipherBuffer) free(cipherBuffer);
    //  NSLog(@"Encrypted text (%d bytes): %@", [encryptedData length], [encryptedData description]);
    //  NSLog(@"Encrypted text base64: %@", [Base64 encode:encryptedData]);
    return encryptedData;
}

- (NSData *)rsaEncryptWithData:(NSData*)data withAsIsKey:(SecKeyRef)key
{    
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    memset((void *)cipherBuffer, 0*0, cipherBufferSize);
    
    NSData *plainTextBytes = data;
    size_t blockSize = cipherBufferSize - 11;
    size_t blockCount = (size_t)ceil([plainTextBytes length] / (double)blockSize);
    NSMutableData *encryptedData = [NSMutableData dataWithCapacity:0];
    
    for (int i=0; i<blockCount; i++) {
        
        NSInteger bufferSize = MIN(blockSize,[plainTextBytes length] - i * blockSize);
        NSData *buffer = [plainTextBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        
        //encryption with padding
        OSStatus status = SecKeyEncrypt(key,
                                        kSecPaddingPKCS1,
                                        (const uint8_t *)[buffer bytes],
                                        [buffer length],
                                        cipherBuffer,
                                        &cipherBufferSize);
        
        
        /*
         //encryption with none padding.
         OSStatus status = SecKeyEncrypt(key,
         kSecPaddingNone,
         (const uint8_t *)[buffer bytes],
         [buffer length],
         cipherBuffer,
         &cipherBufferSize);
         
         */
        
        if (status == noErr){
            NSData *encryptedBytes = [NSData dataWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
            
        }else{
            
            if (cipherBuffer) {
                free(cipherBuffer);
            }
            return nil;
        }
    }
    if (cipherBuffer) free(cipherBuffer);
    //  NSLog(@"Encrypted text (%d bytes): %@", [encryptedData length], [encryptedData description]);
    //  NSLog(@"Encrypted text base64: %@", [Base64 encode:encryptedData]);
    return encryptedData;
}

- (NSData *)rsaEncryptWithData:(NSData*)data usingPublicKey:(BOOL)yes
{
    SecKeyRef key = yes?[self getKeyFromBundle]:self.privateKeyRef;
    
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    memset((void *)cipherBuffer, 0*0, cipherBufferSize);
    
    NSData *plainTextBytes = data;
    size_t blockSize = cipherBufferSize - 11;
    size_t blockCount = (size_t)ceil([plainTextBytes length] / (double)blockSize);
    NSMutableData *encryptedData = [NSMutableData dataWithCapacity:0];
    
    for (int i=0; i<blockCount; i++) {
        
        NSInteger bufferSize = MIN(blockSize,[plainTextBytes length] - i * blockSize);
        NSData *buffer = [plainTextBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        
        //encryption with padding
        OSStatus status = SecKeyEncrypt(key,
                                        kSecPaddingPKCS1,
                                        (const uint8_t *)[buffer bytes],
                                        [buffer length],
                                        cipherBuffer,
                                        &cipherBufferSize);
         
        
        /*
        //encryption with none padding.
        OSStatus status = SecKeyEncrypt(key,
                                        kSecPaddingNone,
                                        (const uint8_t *)[buffer bytes],
                                        [buffer length],
                                        cipherBuffer,
                                        &cipherBufferSize);

        */
        
        if (status == noErr){
            NSData *encryptedBytes = [NSData dataWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
            
        }else{
            
            if (cipherBuffer) {
                free(cipherBuffer);
            }
            return nil;
        }
    }
    if (cipherBuffer) free(cipherBuffer);
    //  NSLog(@"Encrypted text (%d bytes): %@", [encryptedData length], [encryptedData description]);
    //  NSLog(@"Encrypted text base64: %@", [Base64 encode:encryptedData]);
    return encryptedData;
}

- (NSData *) RSA_EncryptUsingPublicKeyWithData:(NSData *)data{
    return [self rsaEncryptWithData:data usingPublicKey:YES];
}

#pragma mark - DECRYPTION

- (NSData *) RSA_DecryptUsingPrivateKeyWithData:(NSData*)data{
    return [self rsaDecryptWithData:data usingPublicKey:NO];
}

- (NSData*)rsaDecryptWithData:(NSData*)data usingPublicKey:(BOOL)yes{
    NSData *wrappedSymmetricKey = data;
    SecKeyRef key = yes?self.publicKeyRef:self.privateKeyRef;
    
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    size_t keyBufferSize = [wrappedSymmetricKey length];
    
    NSMutableData *bits = [NSMutableData dataWithLength:keyBufferSize];
    OSStatus sanityCheck = SecKeyDecrypt(key,
                                         kSecPaddingPKCS1,
                                         (const uint8_t *) [wrappedSymmetricKey bytes],
                                         cipherBufferSize,
                                         [bits mutableBytes],
                                         &keyBufferSize);
    NSAssert(sanityCheck == noErr, @"Error decrypting, OSStatus == %i.", (int)sanityCheck);
    
    [bits setLength:keyBufferSize];
    return bits;
}

#pragma mark - GET PUBLIC KEY FROM BUNDLE

- (SecKeyRef)getKeyFromBundleIBM
{
    SecCertificateRef certificate;
    SecPolicyRef policy;
    SecTrustRef trust;
    SecKeyRef publicKey;
    
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public" ofType:@"der"];
    
    if (publicKeyPath == nil) {
        NSLog(@"Can not find pub.der");
        return nil;
    }
    
    NSData *publicKeyFileContent = [NSData dataWithContentsOfFile:publicKeyPath];
    if (publicKeyFileContent == nil) {
        NSLog(@"Can not read from pub.der");
        return nil;
    }
    
    certificate = SecCertificateCreateWithData(kCFAllocatorDefault, ( __bridge CFDataRef)publicKeyFileContent);
    if (certificate == nil) {
        NSLog(@"Can not read certificate from pub.der");
        return nil;
    }
    
    policy = SecPolicyCreateBasicX509();
    OSStatus returnCode = SecTrustCreateWithCertificates(certificate, policy, &trust);
    if (returnCode != 0) {
        // NSLog(@"SecTrustCreateWithCertificates fail. Error Code: %ld", returnCode);
        return nil;
    }
    
    SecTrustResultType trustResultType;
    returnCode = SecTrustEvaluate(trust, &trustResultType);
    if (returnCode != 0) {
        return nil;
    }
    
    publicKey = SecTrustCopyPublicKey(trust);
    if (publicKey == nil) {
        NSLog(@"SecTrustCopyPublicKey fail");
        return nil;
    }
    return publicKey;
}

- (SecKeyRef)getKeyFromBundle
{
    SecCertificateRef certificate;
    SecPolicyRef policy;
    SecTrustRef trust;
    SecKeyRef publicKey;


    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_new" ofType:@"der"];
    
    if (publicKeyPath == nil) {
        NSLog(@"Can not find pub.der");
        return nil;
    }
    
    NSData *publicKeyFileContent = [NSData dataWithContentsOfFile:publicKeyPath];
    if (publicKeyFileContent == nil) {
        NSLog(@"Can not read from pub.der");
        return nil;
    }
    
    certificate = SecCertificateCreateWithData(kCFAllocatorDefault, ( __bridge CFDataRef)publicKeyFileContent);
    if (certificate == nil) {
        NSLog(@"Can not read certificate from pub.der");
        return nil;
    }
    
    policy = SecPolicyCreateBasicX509();
    OSStatus returnCode = SecTrustCreateWithCertificates(certificate, policy, &trust);
    if (returnCode != 0) {
        // NSLog(@"SecTrustCreateWithCertificates fail. Error Code: %ld", returnCode);
        return nil;
    }
    
    SecTrustResultType trustResultType;
    returnCode = SecTrustEvaluate(trust, &trustResultType);
    if (returnCode != 0) {
        return nil;
    }
    
    publicKey = SecTrustCopyPublicKey(trust);
    if (publicKey == nil) {
        NSLog(@"SecTrustCopyPublicKey fail");
        return nil;
    }
    return publicKey;
}

@end
