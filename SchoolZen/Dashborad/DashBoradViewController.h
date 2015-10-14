//
//  DashBoradViewController.h
//  SchoolZen
//
//  Created by Jatin on 7/20/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DashBoradViewController.h"
#import "MarqueeLabel.h"

@interface DashBoradViewController : UIViewController
{
    IBOutlet UIButton *btnCalendar;
    IBOutlet UIButton *btnCircular;
    IBOutlet UIButton *btnFeedback;
    IBOutlet UIButton *btnMedia;
        IBOutlet UIButton *btnAddFeedback;
IBOutlet UIButton *btnHomeWork;
    IBOutlet UILabel *lblCalendar;
    IBOutlet UILabel *lblCircular;
    IBOutlet UILabel *lblFeedback;
    IBOutlet UILabel *lblMedia;
    IBOutlet UILabel *lblAddFeedback;
     IBOutlet UILabel *lblHomework;
    
    IBOutlet UIView *vwMarquee;
    IBOutlet UIScrollView *sclParent;
    IBOutlet UILabel *lblUserName;
}



-(IBAction)Select_Option:(id)sender;
@property (nonatomic, weak) IBOutlet MarqueeLabel *demoLabel1;
-(IBAction)Click_Calendar:(id)sender;


@end
