//
//  AboutViewController.h
//  SchoolZen
//
//  Created by Jatin on 7/20/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface AboutViewController : UIViewController
{
    IBOutlet UIButton *btnBack;
    
    IBOutlet EGOImageView *imgschool;

    IBOutlet UIWebView *webAbout;
}
-(IBAction)Click_Back:(id)sender;

@end
