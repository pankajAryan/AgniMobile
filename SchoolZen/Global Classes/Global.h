//
//  Global.h
//  Letterz
//
//  Created by Sheetal on 26/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+HTML.h"


@interface Global : NSObject {
	

}
//+ (int)getHeightForText :(NSString*)text andWidth :(int)width ;
//+ (void)resignSubviews :(UIView*)view;
//+ (CGFloat) getCellHeight :(NSString*) string withfont :(UIFont*)font;
//+ (NSArray*) structuredIngredients:(NSArray*)arrIngredients ;
//+(void) saveImageToDocumentFolder:(UIImage *)image withName:(NSString *)ImageName;
//+ (NSString *)uniqueString;
//
//+ (NSArray*)sortArray:(NSArray*)toBeSorted keyForSorting:(NSString*)keyForSorting ascending:(BOOL)isAsc Number:(BOOL)isNumber ;
//
+(void)SaveUserEmailToDefaults :(NSString*)email;
+(BOOL)GetRememberMeFlag;
+(void)SaveRememberMeFlag:(BOOL)flag;
+(NSString*)GetUserPassword;
+(void)SaveUserPassword:(NSString*)password;
+(void)SaveLoginResponse:(NSMutableDictionary*)dictLoginResponse;
+(void)DeleteLoginResponse;
+(NSString*)GetUserEmailFromDefaults;
+(GlobalDataPersistence *)restartGlobalDataPersistence;
+ (void)roundCornersRadius:(UIView *)subView byRoundingCorners:(UIRectCorner)corners;
+ (void)AnimateView:(UIView *)subview onHostViewController:(UIViewController *)controller;
+ (void)RemoveView:(UIView *)subview;
+ (void)CallToCompany;
+ (NSMutableAttributedString *)getCartTotalQuantity;
+ (NSMutableAttributedString *)getCartTotalPrice;
+ (id)createHexagonalView:(UIView *)view;
+ (id)createHexagonalView:(UIView *)view border:(UIColor *)borderColor lineWidth:(CGFloat)lineWidth;
+(BOOL)isBase64Data:(NSString *)input;

#pragma mark
#pragma mark CREATED BY AMIT
+(NSString *)getDecodedBase: (NSString *)encodedStr;
+(NSString *)getDecodedBaseWithHtml: (NSString *)encodedStr;
//
//+(NSString*)convertToTimeString:(NSString*)strTime;
//+(void)setSubDocumentsToNonBackedUp:(NSString*)itemURLSTR;
//+(BOOL)GetAppPurchaseStatus;
//+(void)SetAppPurchaseStatus:(BOOL)status;

@end
