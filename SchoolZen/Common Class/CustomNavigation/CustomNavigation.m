//
//  CustomNavigation.m
//  Fnight Frank
//
//  Created by Sheetal on 11/25/14.
//  Copyright (c) 2014 Dotsquares. All rights reserved.
//

#import "CustomNavigation.h"
#import "AppDelegate.h"
#import "CommonHeader.h"
#import "MFSideMenu.h"
#import "AppDelegate.h"




@implementation CustomNavigation

+ (void)addTarget:(UIViewController *)hostview backRequired:(BOOL)backRequired title:(NSString *)title
{
    
    
   // AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    CommonHeader  *header;
    NSString *nibname = @"CommonHeader";
    NSArray *arrItems = [[NSBundle mainBundle]loadNibNamed:nibname owner:nil options:nil ];
    for (id object in arrItems)
    {
        if([object isKindOfClass:[CommonHeader class]])
        {
            header = (CommonHeader *)object;
            break;
        }
    }
    if ([[UIDevice currentDevice].systemVersion integerValue] >=7)
    {
        [header setFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 64)];
    }
    else
    {
        [header setFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 44)];
    }
    
   
    [header.btnMenu setImage:[UIImage  imageNamed:@"left_menu.png"] forState:UIControlStateNormal];
    header.btnMenu.tag=0;
    [header.btnSearch setImage:[UIImage  imageNamed:@"top-right-search.png"] forState:UIControlStateNormal];
    //[header.btnMenu addTarget:hostview action:@selector(revealLeftSidebar:) forControlEvents:UIControlEventTouchUpInside];
    header.btnSearch.tag=1;

    
    [header.lblTitle setText:title];
    NSLog(@"%@",NSStringFromCGRect(header.frame));
    [hostview.view addSubview:header];
}

//- (void)revealLeftSidebar:(id)sender
//{
//    
//}




+ (void)addView:(UIViewController *)hostview backRequired:(BOOL)backRequired title:(NSString *)title
{
    CommonHeader  *header;
    NSString *nibname = @"CommonHeader";
    NSArray *arrItems = [[NSBundle mainBundle]loadNibNamed:nibname owner:nil options:nil ];
    for (id object in arrItems)
    {
        if([object isKindOfClass:[CommonHeader class]])
        {
            header = (CommonHeader *)object;
            header.btnSearch.hidden=YES;
            header.btnMenu.hidden=YES;
            break;
        }
    }
    if ([[UIDevice currentDevice].systemVersion integerValue] >=7)
    {
        [header setFrame:CGRectMake(0, 0, 320, 64)];
    }
    else
    {
        [header setFrame:CGRectMake(0, 0, 320, 44)];
    }
    [hostview.view addSubview:header];
}



@end
