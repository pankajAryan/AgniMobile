//
//  AppDelegate.m
//  SchoolZen
//
//  Created by Jatin on 7/24/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

#import "Config.h"
#import "ALUtilityClass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    
    LoginViewController *masterViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    self.navigationController.navigationBarHidden=YES;
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

    //***********|| APNS ||*************//
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        // iOS 7 & below
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    else {
//#ifdef __IPHONE_8_0
        // iOS 8 & above
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        UIUserNotificationSettings *deviceNotifiSettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:deviceNotifiSettings];
//#endif
    }
    
    return YES;
}


#pragma mark- Push notification registration methods
#pragma mark-

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
        //DDLogDebug(@"notification reception Declined");
    }
    else if ([identifier isEqualToString:@"answerAction"]){
        //DDLogDebug(@"notification reception Accepted");
    }
}

#endif

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString* newToken = [deviceToken description];
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"My token is: %@", newToken);
    [ALUtilityClass SaveDatatoUserDefault:newToken :@"deviceToken"];
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error.description);
//    [SharedUtility saveDatatoUserDefault:@"" :@"deviceToken"];
}






@end
