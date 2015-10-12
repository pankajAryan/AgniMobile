//
//  AddFeedbackViewController.h
//  SchoolZen
//
//  Created by Jatin on 7/30/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFeedbackViewController : UIViewController
- (IBAction)Click_Back:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txttitle;
@property (strong, nonatomic) IBOutlet UITextField *txtMessage;
@property(strong,nonatomic)IBOutlet UIImageView *imgHeading;
- (IBAction)Click_Send:(id)sender;

@end
