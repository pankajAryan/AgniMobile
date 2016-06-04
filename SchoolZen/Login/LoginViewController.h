//
//  LoginViewController.h
//  SchoolZen
//
//  Created by Jatin on 7/19/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UIButton *btnLogin;
    IBOutlet UITextField *txtEmail;
        IBOutlet UITextField *txtPassword;
    IBOutlet UIView *vwForgotPassword;
    IBOutlet UITextField *txtpasswordFeild;

}

@property (weak, nonatomic) IBOutlet UISegmentedControl *switch_userType;

- (IBAction)googleSignInDidTap:(id)sender;
-(IBAction)Click_Login:(id)sender;
-(IBAction)Click_ForgetPassword:(id)sender;
-(IBAction)Click_Cancel:(id)sender;
-(IBAction)Click_Okay:(id)sender;
@end
