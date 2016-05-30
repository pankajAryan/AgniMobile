//
//  HomeworkTableViewCell.h
//  SchoolZen
//
//  Created by Jatin on 8/10/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeworkTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *lblMainHeading;
@property(nonatomic,weak)IBOutlet UILabel *lblSubHeading;
@property(nonatomic,weak)IBOutlet UILabel *lbldate;
@property(nonatomic,weak)IBOutlet UILabel *lblboxdate;
@property(nonatomic,weak)IBOutlet UILabel *lblLastHeading;
@property(nonatomic,weak)IBOutlet UIButton *btnLink;
@property(nonatomic,weak)IBOutlet UIImageView *imgcircle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subjectTopSpaceToButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageLink;


@end
