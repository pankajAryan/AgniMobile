//
//  CommonHeader.h
//  Fnight Frank
//
//  Created by Sheetal on 11/25/14.
//  Copyright (c) 2014 Dotsquares. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol CommenHeaderDelegate <NSObject>
//-(void)btnMenu_clicked;
//@end

@interface CommonHeader : UIView

@property (strong, nonatomic) UIButton *btnMenu;
@property (strong, nonatomic) UIButton *btnSearch;
@property (strong, nonatomic) UILabel *lblTitle;
@property (strong, nonatomic) UIImageView *imgBackground;

- (id)initWithFrame:(CGRect)frame strTitle:(NSString*)strTitle;

//@property(weak,nonatomic)id<CommenHeaderDelegate> commonDelegate;

@end
