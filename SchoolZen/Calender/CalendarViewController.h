//
//  CalendarViewController.h
//  SchoolZen
//
//  Created by Jatin on 7/21/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CalendarViewController.h"
#import "CAPSPageMenu.h"

@interface CalendarViewController : UIViewController <CAPSPageMenuDelegate>
{
    NSArray *controllerArray;
    
    IBOutlet UILabel *lblHeader;
    IBOutlet UIImageView *imgHeader;
}
@property(nonatomic,strong)NSString *strCat;
@property(nonatomic,strong)NSString *strMonthIndex;

@property (weak, nonatomic) IBOutlet UIButton *buttonBack;

-(IBAction)Click_Back:(id)sender;

@end
