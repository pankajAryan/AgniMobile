//
//  ContactViewController.h
//  SchoolZen
//
//  Created by Jatin on 7/29/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface ContactViewController : UIViewController
{
    IBOutlet UILabel *lblAddress;
    IBOutlet UILabel *lblcontact;
    IBOutlet UITextView *lblEmail;
    IBOutlet UITextView *lblURL;

    IBOutlet EGOImageView *img;

}


@end
