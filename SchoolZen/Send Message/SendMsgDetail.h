//
//  HomeDetailViewController.h
//  SchoolZen
//
//  Created by Jatin on 8/19/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendMsgDetail : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *txttitle;

    IBOutlet UITextField *txtHomeWork;
    
}

- (IBAction)Click_Attached:(id)sender;
- (IBAction)Click_send:(id)sender;
- (IBAction)Click_Back:(id)sender;

@property(nonatomic,strong)NSString *strsubjectId;
@property(nonatomic,strong)NSString *strClassId;
@property(nonatomic,strong)NSString *strSectionId;
@property (nonatomic, strong) NSString *attachementUrl;

@end
