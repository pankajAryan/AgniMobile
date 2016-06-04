//
//  CircularDetailViewController.h
//  SchoolZen
//
//  Created by Pankaj Yadav on 05/06/16.
//  Copyright © 2016 Jatin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularDetailViewController : UIViewController

@property(nonatomic,weak)IBOutlet UILabel *lblMainHeading;
@property(nonatomic,weak)IBOutlet UILabel *lbldate;
@property (weak, nonatomic) IBOutlet UITextView *txtView_circular;

@property (strong) NSString *mainHeading;
@property (strong) NSString *date;
@property (strong) NSString *noticeText;


@end
