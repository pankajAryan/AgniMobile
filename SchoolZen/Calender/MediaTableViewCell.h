//
//  MediaTableViewCell.h
//  SchoolZen
//
//  Created by Jatin on 7/26/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface MediaTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *lblMainHeading;
@property(nonatomic,weak)IBOutlet UILabel *lblSubHeading;
@property(nonatomic,weak)IBOutlet UILabel *lbldate;
@property(nonatomic,weak)IBOutlet UILabel *lblboxdate;
@property(nonatomic,weak)IBOutlet EGOImageView *imgfirst;
@property(nonatomic,weak)IBOutlet EGOImageView *imgSec;
@property(nonatomic,weak)IBOutlet EGOImageView *imgthird;
@property(nonatomic,weak)IBOutlet UIButton *btnLink;
@property(nonatomic,weak)IBOutlet UIImageView *imgcircle;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage1;
@property (weak, nonatomic) IBOutlet UIButton *buttonIMAGE2;
@property (weak, nonatomic) IBOutlet UIButton *buttonImage3;


@end
