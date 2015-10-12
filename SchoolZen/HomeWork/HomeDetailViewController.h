//
//  HomeDetailViewController.h
//  SchoolZen
//
//  Created by Jatin on 8/19/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDetailViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *txttitle;

    IBOutlet UITextField *txtHomeWork;
    
}

- (IBAction)Click_Attached:(id)sender;
- (IBAction)Click_send:(id)sender;
- (IBAction)Click_Back:(id)sender;
@property(nonatomic,assign)NSString *strclassId;
@property(nonatomic,assign)NSString *strsectionId;
@property(nonatomic,assign)NSString *strsubjectId;
@property (nonatomic, strong) NSString *attachementUrl;

@end
