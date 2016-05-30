//
//  MyProfileViewController.m
//  SchoolZen
//
//  Created by Jatin on 7/31/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import "MyProfileViewController.h"
#import "GlobalDataPersistence.h"
#import "DashBoradViewController.h"
#import "SideViewController.h"
#import "WebCommunicationClass.h"
#import "Config.h"
#import "ALUtilityClass.h"
//#import "NSString+MD5.h"

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
    
    NSString *userLoginType = [ALUtilityClass RetrieveDataFromUserDefault:@"loginType"];
    
    if (userLoginType && userLoginType.length)
    {
        if ([userLoginType isEqualToString:@"Mobile"]) {
            
            _scroll_inputFieldsCOntainer.contentSize = CGSizeMake(_scroll_inputFieldsCOntainer.frame.size.width, 488);
        }
        else { // G+ type
            
            _scroll_inputFieldsCOntainer.contentSize = CGSizeMake(_scroll_inputFieldsCOntainer.frame.size.width, 346);
            _lblConfirmpass.hidden = _lblNewpass.hidden = YES;
            _txtField_confirmPassword.hidden = _txtField_newPassword.hidden = YES;
            _bgImageNewpass.hidden = _bgimageConfirmpass.hidden = YES;
            
            CGRect rect = _buttonSave.frame;
            rect.origin.y = _bgImageNewpass.frame.origin.y;
            _buttonSave.frame = rect;
        }
    }
    else {
        _scroll_inputFieldsCOntainer.contentSize = CGSizeMake(_scroll_inputFieldsCOntainer.frame.size.width, 346);
        _lblConfirmpass.hidden = _lblNewpass.hidden = YES;
        _txtField_confirmPassword.hidden = _txtField_newPassword.hidden = YES;
        _bgImageNewpass.hidden = _bgimageConfirmpass.hidden = YES;
        
        CGRect rect = _buttonSave.frame;
        rect.origin.y = _bgImageNewpass.frame.origin.y;
        _buttonSave.frame = rect;
    }
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
    BOOL isValid = YES;
    UIAlertView *alert;
    
    if (!lblName.text.length) {
       alert = KALERT(KApplicationName, @"Name can't be left empty!", nil);
        isValid = NO;
    }
    else if (lblcontact.text.length != 10) {
        alert = KALERT(KApplicationName, @"Please enter a valid mobile number!", nil);
        isValid = NO;
    }
    else if ((_txtField_newPassword.text.length > 0)
             && _txtField_newPassword.text.length < 6)
    {
        alert = KALERT(KApplicationName, @"New password must have at least 6 characters!", nil);
        isValid = NO;

    }
    else if (![_txtField_newPassword.text isEqualToString:_txtField_confirmPassword.text])
    {
        alert = KALERT(KApplicationName, @"Passwords should match!", nil);
        isValid = NO;
    }
    
    if (isValid) {
        
        alert = KALERT_YN(KApplicationName, @"Would you like to save you profile detail?", self);
    }
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSString *userLoginType = [ALUtilityClass RetrieveDataFromUserDefault:@"loginType"];
        
        NSString *password = @"";
        
        if (userLoginType && userLoginType.length)
        {
            if ([userLoginType isEqualToString:@"Mobile"])
            {
                if (_txtField_newPassword.text.length) {
                    password = _txtField_newPassword.text;
                }
                else
                    password = [ALUtilityClass RetrieveDataFromUserDefault:@"pass"];
            }
            else { // G+ type
                password = @"";
            }
        }
        
        
        WebCommunicationClass *obj_web=[WebCommunicationClass new];
        
        [obj_web setACaller:self];
        GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
        
        [obj_web updateProfile:[obj_glob.dictUserInfo valueForKey:@"userId"] userType:obj_glob.strUserType userName:lblName.text userEmail:lblEmail.text userMobile:lblcontact.text newPassword:password]; //@"e6053eb8d35e02ae40beeeacef203c1a"] = newpass
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
    
    GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];

    if(isSuccessNumber)
    {
        [obj_glob.dictUserInfo setValue:lblName.text forKey:@"userName"];
        [obj_glob.dictUserInfo setValue:lblcontact.text forKey:@"userMobile"];
        
        UIAlertView *alert = KALERT(KApplicationName, @"Your profile has been updated.", self);
        
        [alert show];
    }
    else
    {
        
        UIAlertView *alert = KALERT(KApplicationName, [strResult valueForKey:@"errorMessage"], self);
        
        [alert show];
//        lblName.text = [obj_glob.dictUserInfo valueForKey:@"userName"];
//        lblcontact.text = [obj_glob.dictUserInfo valueForKey:@"userMobile"];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}


@end
