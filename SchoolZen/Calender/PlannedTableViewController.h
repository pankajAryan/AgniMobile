//
//  PlannedTableViewController.h
//  SchoolZen
//
//  Created by Jatin on 7/23/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlannedTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblPlanned;

}
@property(nonatomic,strong)NSString *strCateg;
@property(nonatomic,strong)NSArray *dictPlanCommon;

@property (assign) NSInteger selectedTabIndex;
@property(assign) BOOL isCommonType;

@property(nonatomic,strong) NSString *strMonthIndex;

@property (weak, nonatomic) IBOutlet UILabel *label_noInfo;


@end
