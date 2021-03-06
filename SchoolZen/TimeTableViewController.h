//
//  TimeTableViewController.h
//  SchoolZen
//
//  Created by Pankaj Yadav on 12/10/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface TimeTableViewController : UIViewController <UIScrollViewDelegate>

@property (strong) NSDictionary *dictChild;

@property (weak, nonatomic) IBOutlet EGOImageView *imageView_Timetable;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *label_noInfo;


@end
