//
//  LoginViewController.m
//  SchoolZen
//
//  Created by Jatin on 7/19/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "LoginViewController.h"
#import "SideViewController.h"
#import "DashBoradViewController.h"
#import "WebCommunicationClass.h"
#import "Config.h"

#import "GTMOAuth2SignIn.h"
#import "GTMOAuth2Authentication.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GlobalDataPersistence.h"


#define kClientsecret   @"LK47EdtWBnpKKC10gid2jwRb" //Google Secret key.
#define kClientID       @"595810708680.apps.googleusercontent.com" //Google Client ID


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
    obj_glob.strUserType=@"P";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)googleSignInDidTap:(id)sender {
    
    NSString *scope = @"https://www.googleapis.com/auth/userinfo.profile"; // scope for getting user info.
    
    // ****** Show activity Indicator ******** //
//    [ALUtilityClass showSpinnerWithMessage:@"Loading..." onView:self.view];
    
    //To display a sign-in view
    GTMOAuth2ViewControllerTouch *controller = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:scope clientID:kClientID clientSecret:kClientsecret keychainItemName:@"OAuth2 Sample: Google" delegate:self finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)Click_Login:(id)sender
{
    GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
   if( [obj_glob.strUserType isEqualToString:@"T"])
    {
        WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
        [aCommunication setACaller:self];
        [aCommunication loginUserName:@"demo@demo.com" withpassword:@"e6053eb8d35e02ae40beeeacef203c1a" UserType:@"T"];
   /* WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
    [aCommunication setACaller:self];
    [aCommunication loginUserName:@"aasdasd@asd.com" withpassword:@"101193d7181cc88340ae5b2b17bba8a1" UserType:@"T"];*/
    }
    else
    {
        WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
        [aCommunication setACaller:self];
        [aCommunication loginUserName:@"abc@gmail.com" withpassword:@"" UserType:@"P"];
    
    }

}
- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
        obj_glob.strUserType=@"P";
    }
    else{
        
        GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
        obj_glob.strUserType=@"T";
       

    }
}

#pragma mark - Google Api Delegate Methods
#pragma mark -

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    if (error != nil)
    {
//        [ALUtilityClass removeHudFromView:self.view afterDelay:0.0];
        
        // Authentication failed
        if ([error code]<-1000)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Google Error"
                                                            message:@"The operation couldn't be completed !"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        // Authentication succeeded
        
        NSString *strURL = @"https://www.googleapis.com/oauth2/v1/userinfo?alt=json";
        
        NSURL *url = [NSURL URLWithString:strURL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [auth authorizeRequest:request
             completionHandler:^(NSError *error)
         {
             // If there was an error making the request, display a message to the user
             if(error != nil)
             {
//                 [ALUtilityClass removeHudFromView:self.view afterDelay:0.0];
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Google Error"
                                                                 message:@"There was an error talking to Google. Please try again later."
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 return;
             }
             
             
             // getting user profile info.
             NSURLResponse *response = nil;
             NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                  returningResponse:&response
                                                              error:&error];
             if (data)
             {
                 // API fetch succeeded. Parse the JSON response
                 NSError *jsonError = nil;
                 id resp = [NSJSONSerialization JSONObjectWithData:data
                                                           options:0
                                                             error:&jsonError];
                 
                 
                 // If there was an error decoding the JSON, display a message to the user
                 if(jsonError != nil)
                 {
//                     [ALUtilityClass removeHudFromView:self.view afterDelay:0.0];
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Google Error"
                                                                     message:@"Google authentication is not acting properly right now. Please try again later."
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     return;
                 }
                 
                 
                 // Do something with the fetched data
                 if ([resp isKindOfClass:[NSDictionary class]])
                 {
                     NSLog(@"%@",[resp valueForKey:@"email"]);
                     WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
                     [aCommunication setACaller:self];
                     
                     GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
                     if( [obj_glob.strUserType isEqualToString:@"T"]) {
                         [aCommunication loginUserName:@"abc@gmail.com" withpassword:@"" UserType:@"T"];
                     }
                     else {
                         [aCommunication loginUserName:@"abc@gmail.com" withpassword:@"" UserType:@"P"];
                     }

/*                     email = [resp valueForKey:@"email"];
                     fName = [resp valueForKey:@"given_name"];
                     lName = [resp valueForKey:@"family_name"];
                     
                     // ****** Show activity Indicator ******** //
                     //                     [ALUtilityClass showSpinnerWithMessage:@"Loading..." onView:self.view];
                     
                     [[ALServiceInvoker sharedInstance] makeUserApiRequestWithParams:@{@"firstName": [NSString stringWithFormat:@"%@ %@",fName,lName], @"mobileNo": @"", @"email": email, @"password": @"", @"loginType": @"G",@"notificationId": [ALUtilityClass RetrieveDataFromUserDefault:@"deviceToken"],@"deviceType":@"iOS"} requestAPI:API_LOGIN reqTag:3 delegate:self];
 */
                 }
                 else {
//                     [ALUtilityClass removeHudFromView:self.view afterDelay:0.0];
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Google Error"
                                                                     message:@"Google authentication is not acting properly right now. Please try again later."
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     
                 }
             }
             else {
                 
//                 [ALUtilityClass removeHudFromView:self.view afterDelay:0.0];
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Google Error"
                                                                 message:@"Google authentication is not acting properly right now. Please try again later."
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
             }
         }];
    }
    
    [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:@"OAuth2 Sample: Google"];
    [GTMOAuth2ViewControllerTouch revokeTokenForGoogleAuthentication:auth];
}

#pragma mark- Webservice callback
#pragma mark-
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;

    NSString *strResult=[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSLog(@"%@",[strResult valueForKey:@"errorCode"]);
    NSNumber * isSuccessNumber = (NSNumber *)[strResult valueForKey:@"errorCode"];

    
    
    if(aReq.tag==20)
    {
        if(isSuccessNumber)
        {
            UIAlertView *alert =KALERT(KApplicationName, [strResult valueForKey:@"errorMessage"], self);
            
            
            
            [alert show];

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        CGRect mainScreenBound = [[UIScreen mainScreen] bounds];
        
        
        if (mainScreenBound.size.height==568)
        {
            vwForgotPassword.frame = CGRectMake(0,870,320,568);
        }
        else
        {
            vwForgotPassword.frame = CGRectMake(0,850, 320, 480);
        }
        
        [self.view addSubview:vwForgotPassword];
        [UIView commitAnimations];
        }
    }
    
else
{

    if(isSuccessNumber)
    {
        
        GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
        
        obj_GlobalDataPersistence.dictUserInfo=[strResult valueForKey:@"responseObject"];
        obj_GlobalDataPersistence.arrChild=[[strResult valueForKey:@"responseObject"] valueForKey:@"childList"];
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
    else
        
    {
        
        UIAlertView *alert =KALERT(KApplicationName, [strResult valueForKey:@"errorMessage"], self);
        
        
        
        [alert show];
        
        
    }
    
    
}
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];

    return true;
}
-(IBAction)Click_ForgetPassword:(id)sender
{

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect mainScreenBound = [[UIScreen mainScreen] bounds];
    
  
        if (mainScreenBound.size.height==568)
        {
            vwForgotPassword.frame = CGRectMake(0,0,320,568);
        }
        else
        {
            vwForgotPassword.frame = CGRectMake(0,0, 320, 480);
        }
    
    [self.view addSubview:vwForgotPassword];
    [UIView commitAnimations];

}
-(IBAction)Click_Cancel:(id)sender
{

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect mainScreenBound = [[UIScreen mainScreen] bounds];
    
    
    if (mainScreenBound.size.height==568)
    {
        vwForgotPassword.frame = CGRectMake(0,850,320,568);
    }
    else
    {
        vwForgotPassword.frame = CGRectMake(0,850, 320, 480);
    }
    
    [self.view addSubview:vwForgotPassword];
    [UIView commitAnimations];


}
-(IBAction)Click_Okay:(id)sender
{
    GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
    
    WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
    [aCommunication setACaller:self];
    [aCommunication ForgotPassword:txtpasswordFeild.text :obj_glob.strUserType];
    
   

}
@end
