//
//  AppDelegate.h
//  SchoolZen
//
//  Created by Jatin on 7/24/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)UINavigationController *navigationController;
@property (nonatomic, strong) NSString *pushLayoutType;
@property (nonatomic,assign) BOOL isAppLaunchedFromBackground;


@end

