//
//  AppDelegate.m
//  SchoolZen
//
//  Created by Jatin on 7/24/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

#import "Config.h"
#import "ALUtilityClass.h"
#import "GlobalDataPersistence.h"
#import "DashBoradViewController.h"
#import "SideViewController.h"
#import "CalendarViewController.h"
#import "GlobalDataPersistence.h"
#import "TeacherFeedbackViewController.h"
#import "AddFeedbackViewController.h"
#import "WebCommunicationClass.h"
#import "ALUtilityClass.h"
#import "ALServiceInvoker.h"
#import "Config.h"
#import "HomeWorkViewController.h"
#import "CalenderNewViewController.h"
#import "SendMessage.h"
#import "TimeTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    LoginViewController *masterViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    
    if([[ALUtilityClass RetrieveDataFromUserDefault:@"isLoggedIn"] boolValue])
    {
        NSDictionary *loggedInUserData = [ALUtilityClass RetrieveDataFromUserDefault:@"userDataPersistence"];
        
        GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
        obj_GlobalDataPersistence.dictUserInfo=[[loggedInUserData valueForKey:@"responseObject"] mutableCopy];
        obj_GlobalDataPersistence.arrChild=[[loggedInUserData valueForKey:@"responseObject"] valueForKey:@"childList"];
        obj_GlobalDataPersistence.strUserType = [ALUtilityClass RetrieveDataFromUserDefault:@"loggedInUserType"];
        
        NSLog(@"%@",obj_GlobalDataPersistence.arrChild);
        NSLog(@"%@",obj_GlobalDataPersistence.dictUserInfo);
        
        
        DashBoradViewController *obj_dash=[[DashBoradViewController alloc] initWithNibName:([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"])?@"DashBoradViewController_":@"DashBoradViewController" bundle:nil];
        
        UINavigationController *nav = [[UINavigationController alloc ] initWithRootViewController:obj_dash];
        
        nav.navigationBarHidden  = YES;
        SideViewController *leftMenuViewController = [[SideViewController alloc] init];
        MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                        containerWithCenterViewController:nav leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
        
        [self.navigationController pushViewController:container animated:YES];
    }
    
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

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler
{
    /* // Payload JSON structure //
     
     {
     aps =     {
     alert =         {
     body = "msg push";
     title = "push title for ios";
     };
     sound = default;
     type = cart;
     };
     }
     */
    
    NSString *layoutType =[[userInfo objectForKey:@"aps"] objectForKey:@"type"];
    
    switch (application.applicationState) {
            
        case UIApplicationStateActive:
            
            NSLog(@"Application state = UIApplicationStateActive");
            
            break;
            
        case UIApplicationStateInactive: // app is launched by clicking a notification
            
            NSLog(@"Application state = UIApplicationStateInactive");
            
            if([[ALUtilityClass RetrieveDataFromUserDefault:@"isLoggedIn"] boolValue])
            {
                self.pushLayoutType = layoutType;
                //[self handleScreenPushForNotification];
                if (_isAppLaunchedFromBackground) {
                    // call the method to push the destined page layout
                    [self pushViewControllerForNotificationAction];
                }

            }
            
            break;
            
        case UIApplicationStateBackground:
            
            NSLog(@"Application state = UIApplicationStateBackground");
            
            break;
            
        default:
            break;
    }
}


//- (void)handleScreenPushForNotification {
//    
//    // check if app is launched from Background state
//    if (_isAppLaunchedFromBackground) {
//        // call the method to push the destined page layout
//        [self pushViewControllerForNotificationAction];
//    }
//    else {
//        // launched from not running state so add observer which later on at HomeViewController invoke the action  to push the destined page layout
//        [[NSNotificationCenter defaultCenter]addObserver:self
//                                                selector:@selector(pushViewControllerForNotificationAction)
//                                                    name:@"handlePushAction"
//                                                  object:nil];
//    }
//}


- (void)pushViewControllerForNotificationAction {
    
    GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];

    CalendarViewController *parentController;
    
    if([self.pushLayoutType isEqualToString:@"media"])
    {
        parentController = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
        parentController.strCat=@"Media";
        CGRect rect3 = parentController.view.frame;
        rect3.origin.y = 64;
        parentController.view.frame = rect3;
        [self.navigationController pushViewController:parentController animated:YES];
    }
    else if([self.pushLayoutType isEqualToString:@"circular"])
    {
        parentController = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
        parentController.strCat=@"Circular";
        CGRect rect1 = parentController.view.frame;
        rect1.origin.y = 64;
        parentController.view.frame = rect1;
        [self.navigationController pushViewController:parentController animated:YES];
    }
    else if([self.pushLayoutType isEqualToString:@"homework"])
    {
        if([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"])
        {
            HomeWorkViewController *obj_HomeWorkViewController=[HomeWorkViewController new];
            
            [self.navigationController pushViewController:obj_HomeWorkViewController animated:YES];
        }
        else
        {
            parentController = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
            parentController.strCat=@"Homework";
            CGRect rect4 = parentController.view.frame;
            rect4.origin.y = 64;
            parentController.view.frame = rect4;
            [self.navigationController pushViewController:parentController animated:YES];
        }
    }
    else if([self.pushLayoutType isEqualToString:@"holiday"])
    {
        parentController = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
        parentController.strCat=@"Calendar";
        CGRect rect = parentController.view.frame;
        rect.origin.y = 64;
        parentController.view.frame = rect;
        //   [self.view addSubview:parentController.view];
        [self.navigationController pushViewController:parentController animated:YES];
    }
    else if([self.pushLayoutType isEqualToString:@"feedback"])
    {
        if([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"])
        {
            TeacherFeedbackViewController *obj_TeacherFeedbackViewController=[TeacherFeedbackViewController new];
            
            [self.navigationController pushViewController:obj_TeacherFeedbackViewController animated:YES];
        }
        else
        {
            parentController = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
            parentController.strCat=@"Feedback";
            CGRect rect2 = parentController.view.frame;
            rect2.origin.y = 64;
            parentController.view.frame = rect2;
            [self.navigationController pushViewController:parentController animated:YES];
        }
    }
    else if([self.pushLayoutType isEqualToString:@"general"])
    {
        
    }
    
    self.pushLayoutType = nil;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    self.isAppLaunchedFromBackground = YES;
}





@end
