//
//  DashBoradViewController.m
//  SchoolZen
//
//  Created by Jatin on 7/20/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "DashBoradViewController.h"
#import "CustomNavigation.h"
#import "CommonHeader.h"
#import "MFSideMenu.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
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

@interface DashBoradViewController ()
{
    CalendarViewController *parentController;
    AddFeedbackViewController *obj_AddFeedbackViewController;
   
}

@end

@implementation DashBoradViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];

    WebCommunicationClass *obj_web=[WebCommunicationClass new];
    
    [obj_web setACaller:self];
    
    [obj_web getTicker:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"]];
    
    
    CGRect frame = sclParent.frame;
    frame.size.height = ([UIScreen mainScreen].bounds.size.height - 120);
    sclParent.frame = frame;

    // vwMarquee.frame=CGRectMake(0, 400, [UIScreen mainScreen].applicationFrame.size.width,34);
    // Continuous Type
    self.demoLabel1.tag = 101;
    self.demoLabel1.marqueeType = MLContinuous;
    self.demoLabel1.scrollDuration = 15.0;
    self.demoLabel1.animationCurve = UIViewAnimationOptionCurveEaseInOut;
    self.demoLabel1.fadeLength = 10.0f;
    self.demoLabel1.leadingBuffer = 30.0f;
    self.demoLabel1.trailingBuffer = 20.0f;
    
    [CustomNavigation addTarget:self backRequired:NO title:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolName"]];
    
    for (UIView *v1 in self.view.subviews)
    {
        if ([v1 isKindOfClass:[CommonHeader class]])
        {
            for (UIView *view in v1.subviews)
            {
                if ([view isKindOfClass:[UIButton class]])
                {
                    if (view.tag==0)
                    {
                        [(UIButton*)view addTarget:self action:@selector(revealLeftSidebar:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    else if(view.tag==1)
                    {
                        view.hidden=YES;
                    }
                }
            }
        }
    }
    
    GlobalDataPersistence *obj_global=[GlobalDataPersistence sharedGlobalDataPersistence];

    if([obj_global.strUserType isEqualToString:@"T"])
    {
      
        GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
        
        WebCommunicationClass *obj_web=[WebCommunicationClass new];
        
        [obj_web setACaller:self];
        
        [obj_web GetStaffClassSectionSubjectStructure:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] staffId:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"userId"] ];
        // btnAddFeedback.hidden=YES;
       // lblAddFeedback.hidden=YES;
        lblFeedback.text=@"Give a Feedback";
        
        sclParent.contentSize = CGSizeMake(self.view.frame.size.width,500);

    }
    else
    {
        sclParent.contentSize = CGSizeMake(self.view.frame.size.width,624);
    }
    
    lblUserName.text=[NSString stringWithFormat:@"Hi, %@",[obj_global.dictUserInfo valueForKey:@"userName"]];
    [self sendDeviceTokenToserver:[ALUtilityClass RetrieveDataFromUserDefault:@"deviceToken"]];
}


#pragma mark MFSidebarDelegate
- (void)leftSideMenuButtonPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}

- (void)revealLeftSidebar:(id)sender
{
    [self leftSideMenuButtonPressed:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Select_Option:(id)sender
{
     GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];

    switch ([sender tag])
    {
        case 0:
          
            parentController = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
            parentController.strCat=@"Calendar";
            CGRect rect = parentController.view.frame;
            rect.origin.y = 64;
            parentController.view.frame = rect;
         //   [self.view addSubview:parentController.view];
            [self.navigationController pushViewController:parentController animated:YES];
          
            
            break;
        case 1:
            parentController = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
            parentController.strCat=@"Circular";
            CGRect rect1 = parentController.view.frame;
            rect1.origin.y = 64;
            parentController.view.frame = rect1;
            [self.navigationController pushViewController:parentController animated:YES];
            break;
            
           case 2:
           
            

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
            break;
            
        case 3:
            parentController = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
            parentController.strCat=@"Media";
            CGRect rect3 = parentController.view.frame;
            rect3.origin.y = 64;
            parentController.view.frame = rect3;
            [self.navigationController pushViewController:parentController animated:YES];
            break;
            
            
        case 4:
            
            
            if([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"])
            {
                HomeWorkViewController *obj_HomeWorkViewController=[HomeWorkViewController new];
                
                [self.navigationController pushViewController:obj_HomeWorkViewController animated:YES];
            }
            else
            {
            obj_AddFeedbackViewController=[AddFeedbackViewController new];
            
            [self.navigationController pushViewController:obj_AddFeedbackViewController animated:YES];
                
            }
            break;
            
            case 5:
            
            if([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"])
            {
                SendMessage *objsend=[SendMessage new];
                [self.navigationController pushViewController:objsend animated:YES];
            }
            else
            {
    
            
            parentController = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
            parentController.strCat=@"Homework";
            CGRect rect4 = parentController.view.frame;
            rect3.origin.y = 64;
            parentController.view.frame = rect4;
            [self.navigationController pushViewController:parentController animated:YES];
            }
             break;
        case 6:
            
            
            parentController = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
            parentController.strCat=@"timetable";
            CGRect rect5 = parentController.view.frame;
            rect3.origin.y = 64;
            parentController.view.frame = rect5;
            [self.navigationController pushViewController:parentController animated:YES];
            
            break;
            
       
    
    case 7:
    
    
    parentController = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
    parentController.strCat=@"Message";
    CGRect rect6 = parentController.view.frame;
    rect3.origin.y = 64;
    parentController.view.frame = rect6;
    [self.navigationController pushViewController:parentController animated:YES];
    
    break;
    
}

}
/*-(void)Logout
{
    AppDelegate *appdel=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    LoginViewController *LoginViewObj=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
    
    appdel.navigationController= [[UINavigationController alloc]initWithRootViewController:LoginViewObj];
    [appdel.navigationController setNavigationBarHidden:YES];
    [appdel.window setRootViewController:appdel.navigationController];
}*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark- Webservice request

-(void)sendDeviceTokenToserver:(NSString *)token {
    
    //    registerPushNotificationId(@FormParam("userId") String userId,@FormParam("userType") String userType,@FormParam("pushNotificationId") String pushNotificationId)
    
    if ([ALUtilityClass isNetworkAvailable])
    {
        GlobalDataPersistence *obj_global=[GlobalDataPersistence sharedGlobalDataPersistence];

        // ********* Initialise Request ******** //
        NSURL *url = [NSURL URLWithString:[BASE_URL_STRING stringByAppendingString:kAPNS_WEBSERVICE]];
        
        ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
        
        [request addPostValue:[obj_global.dictUserInfo objectForKey:@"userId"] forKey:@"userId"];
        [request addPostValue:obj_global.strUserType forKey:@"userType"];
        [request addPostValue:token forKey:@"pushNotificationId"];
        
        //        [request addPostValue:[ALUtilityClass getDeviceIdentifier] forKey:@"deviceId"];
        
        
        __weak typeof(request) weakRequest = request;
        
        [request setCompletionBlock:^{
            
            __strong typeof(request) strongRequest = weakRequest;
            
            switch(strongRequest.responseStatusCode)
            {
                case 200:
                {
                    NSError *error = nil;
                    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:strongRequest.responseData options:NSJSONReadingMutableLeaves error:&error];
                    
                    if (error == nil && responseDict != nil)
                    {
                        NSLog(@"API service Response: %@",strongRequest.responseString);
                    }
                    else
                    { // Error scenarios covered.
                        
                        NSLog(@"API failed to save APNS token");
                    }
                    
                    break;
                }
                    
                default:
                {
                    NSLog(@"failed: server error code: %i",strongRequest.responseStatusCode);
                    
                    break;
                }
            }
            
        }];
        
        
        [request setFailedBlock:^{ // Some error b/w the server-client communication
            
            __strong typeof(request) strongRequest = weakRequest;
            
            NSLog(@"failed: server error code: %i",strongRequest.responseStatusCode);
            
        }];
        
        request.timeOutSeconds = 30;
        [request setShouldAttemptPersistentConnection:NO];
        [request startAsynchronous];
    }
}

#pragma mark- Webservice callback
#pragma mark-
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSNumber * isSuccessNumber = (NSNumber *)[result valueForKey:@"errorCode"];
    
    if(isSuccessNumber)
    {
        if (aReq.tag == 41) {
            self.demoLabel1.text = [result valueForKey:@"responseObject"];
        }
        else {
            GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
            
            obj_GlobalDataPersistence.arrTeacher = [result valueForKey:@"responseObject"];
            NSLog(@"%@",obj_GlobalDataPersistence.arrTeacher);
        }
    }
    else
        
    {
        if (aReq.tag != 41)
        {
            UIAlertView *alert = KALERT(KApplicationName, [result valueForKey:@"errorMessage"], self);
            
            [alert show];
        }
        
    }
}

-(IBAction)Click_Calendar:(id)sender
{
    CalenderNewViewController *obj_HomeWorkViewController=[CalenderNewViewController new];
    
    [self.navigationController pushViewController:obj_HomeWorkViewController animated:YES];


}
@end
