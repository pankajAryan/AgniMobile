//
//  ShowmsgTableViewCell.h
//  SchoolZen
//
//  Created by Jatin on 10/12/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowmsgTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *lblMainHeading;
@property(nonatomic,weak)IBOutlet UILabel *lblSubHeading;
@property(nonatomic,weak)IBOutlet UILabel *lbldate;
@property(nonatomic,weak)IBOutlet UILabel *lblboxdate;
@property(nonatomic,weak)IBOutlet UIImageView *imgDate;
@property(nonatomic,weak)IBOutlet UILabel *lblsubheadingvalue;

@end
