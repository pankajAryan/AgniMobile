//
//  MyProfileViewController.h
//  SchoolZen
//
//  Created by Jatin on 7/31/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface MyProfileViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UILabel *lblMainHeading;
    IBOutlet UITextField *lblName;
        IBOutlet UITextField *lblEmail;
        IBOutlet UITextField *lblcontact;
    IBOutlet UIImageView *imgprofile;
}

@property (weak, nonatomic) IBOutlet UITextField *txtField_newPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtField_confirmPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblNewpass;
@property (weak, nonatomic) IBOutlet UILabel *lblConfirmpass;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageNewpass;
@property (weak, nonatomic) IBOutlet UIImageView *bgimageConfirmpass;

@property (weak, nonatomic) IBOutlet UIButton *buttonSave;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scroll_inputFieldsCOntainer;

@end
