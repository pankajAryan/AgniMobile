//
//  CommonHeader.m
//  Fnight Frank
//
//  Created by Sheetal on 11/25/14.
//  Copyright (c) 2014 Mobiquel. All rights reserved.
//

#import "CommonHeader.h"
#import "AppDelegate.h"

@implementation CommonHeader
@synthesize btnMenu,btnSearch,lblTitle,imgBackground;
//@synthesize commonDelegate;

- (id)initWithFrame:(CGRect)frame strTitle:(NSString*)strTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        imgBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
        imgBackground.image = [UIImage imageNamed:@"top-red-strip.png"];
        [self addSubview:imgBackground];
                             
//        if ([AppDelegate sharedDelegate].boolSelectYear) {
//            
//        }
//        else
//        {
            btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
            btnMenu.frame = CGRectMake(0, 20, 44, 44);
            [btnMenu setImage:[UIImage imageNamed:@"menu_icon.png"] forState:UIControlStateNormal];
          //  [btnMenu addTarget:self action:@selector(popToView) forControlEvents:UIControlEventTouchDragInside];
            [self addSubview:btnMenu];
            
            lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 241, 24)];
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.text = strTitle;
            lblTitle.font = [UIFont fontWithName:@"Arial" size:17.0];
            [self addSubview:lblTitle];
            
            btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
            btnSearch.frame = CGRectMake(276, 20, 44, 44);
            [btnSearch setImage:[UIImage imageNamed:@"top-right-search.png"] forState:UIControlStateNormal];
          //  [btnMenu addTarget:self action:@selector(popToView) forControlEvents:UIControlEventTouchDragInside];
            [self addSubview:btnSearch];

        //}
    }
    return self;
}

//-(void)popToView
//{
//    if([self.commonDelegate respondsToSelector:@selector(btnMenu_clicked)])
//    {
//        [self.commonDelegate btnMenu_clicked];
//    }
//}


-(IBAction)btnSearchClicked
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
