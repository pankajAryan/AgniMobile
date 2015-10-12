//
//  MyProfileViewController.m
//  SchoolZen
//
//  Created by Jatin on 7/31/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "MyProfileViewController.h"
#import "GlobalDataPersistence.h"
#import "DashBoradViewController.h"
#import "SideViewController.h"
#import "WebCommunicationClass.h"
#import "Config.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
    
    lblMainHeading.text=[NSString stringWithFormat:@"%@",[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"userName"]];
        lblName.text=[NSString stringWithFormat:@"%@",[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"userName"]];
    
        lblEmail.text=[NSString stringWithFormat:@"%@",[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"userEmail"]];
    
            lblcontact.text=[NSString stringWithFormat:@"%@",[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"userMobile"]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Click_Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)UpdateProfile:(id)sender
{
    
     UIAlertView *alert = KALERT(KApplicationName, @"Would you like to save you profile detail", self);
    
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
if(buttonIndex==0)
{
    WebCommunicationClass *obj_web=[WebCommunicationClass new];
    
    [obj_web setACaller:self];
    GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
    [obj_web updateProfile:[obj_glob.dictUserInfo valueForKey:@"userId"] userType:obj_glob.strUserType userName:lblName.text userEmail:lblEmail.text userMobile:lblcontact.text];
   
   
}

}
#pragma mark- Webservice callback
#pragma mark-
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    NSString *strResult=[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSLog(@"%@",[strResult valueForKey:@"errorCode"]);
    NSNumber * isSuccessNumber = (NSNumber *)[strResult valueForKey:@"errorCode"];
    
    if(isSuccessNumber)
    {
        
        UIAlertView *alert = KALERT(KApplicationName, [strResult valueForKey:@"errorMessage"], self);
        
        
        
        [alert show];
        
    }
    else
        
    {
        
        UIAlertView *alert = KALERT(KApplicationName, [strResult valueForKey:@"errorMessage"], self);
        
        
        
        [alert show];
        
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
