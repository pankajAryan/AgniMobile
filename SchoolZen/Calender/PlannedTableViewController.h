//
//  PlannedTableViewController.h
//  SchoolZen
//
//  Created by Jatin on 7/23/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlannedTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblPlanned;

}
@property(nonatomic,assign)NSString *strCateg;
@property(nonatomic,strong)NSArray *dictPlanCommon;


@end