//
//  CustomNavigation.h
//  Fnight Frank
//
//  Created by Sheetal on 11/25/14.
//  Copyright (c) 2014 Mobiquel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CustomNavigation : NSObject



+(void)addTarget:(UIViewController *)hostview backRequired:(BOOL)backRequired title:(NSString *)title;
+(void)addView:(UIViewController *)hostview backRequired:(BOOL)backRequired title:(NSString *)title;
+ (void)addTargetTop:(UIViewController *)hostview backRequired:(BOOL)backRequired title:(NSString *)title;
+ (void)addTargetFooter:(UIViewController *)hostview backRequired:(BOOL)backRequired title:(NSString *)title;

@end
