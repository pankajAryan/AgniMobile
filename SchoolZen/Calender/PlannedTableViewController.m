//
//  PlannedTableViewController.m
//  SchoolZen
//
//  Created by Jatin on 7/23/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "PlannedTableViewController.h"
#import "CalendarCell.h"
#import "MediaTableViewCell.h"
#import "CircularTableViewCell.h"
#import "GlobalDataPersistence.h"
#import "HomeworkTableViewCell.h"
#import "ShowmsgTableViewCell.h"

@interface PlannedTableViewController ()

@end

@implementation PlannedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
    
    self.dictPlanCommon=obj_GlobalDataPersistence.arrPlan;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    if([self.strCateg isEqualToString:@"Cir"]|| [self.strCateg isEqualToString:@"Me"] || [self.strCateg isEqualToString:@"wo"])
    {
        
        return 1;
    }
    else
    {
    return [self.dictPlanCommon count];
    }
    
    return 0;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if([self.strCateg isEqualToString:@"Cir"]|| [self.strCateg isEqualToString:@"Me"] || [self.strCateg isEqualToString:@"wo"])
    {
        
        return [self.dictPlanCommon count];
    }
    else
    {
    // Return the number of rows in the section.
    NSArray *arr= [[self.dictPlanCommon objectAtIndex:section] objectForKey:@"holidays"];
    return [arr count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    if([self.strCateg isEqualToString:@"Cir"] || [self.strCateg isEqualToString:@"Feed"])
    {
        
        CalendarCell*   cell = (CalendarCell *)[tblPlanned dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            UIViewController *view = [[UIViewController alloc]initWithNibName:@"CalendarCell" bundle:nil];
            cell = (CalendarCell *)view.view;
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        }
        
        cell.lblMainHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"title"] objectAtIndex:indexPath.row]];
        
        cell.lblSubHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"message"] objectAtIndex:indexPath.row]];
        cell.imgDate.layer.cornerRadius=cell.imgDate.frame.size.width/2;
        cell.imgDate.clipsToBounds=YES;
        NSString *dateString =[[self.dictPlanCommon valueForKey:@"dateOf"] objectAtIndex:indexPath.row];
        NSArray* dateArray = [dateString componentsSeparatedByString: @" "];
        
        cell.lblboxdate.text=[dateArray objectAtIndex:0];
        cell.lbldate.text=[NSString stringWithFormat:@"%@%@",[dateArray objectAtIndex:1],[dateArray objectAtIndex:2]];
        
        return cell;
        
    }
    else if([self.strCateg isEqualToString:@"Me"])
    {
        
        MediaTableViewCell*   cell = (MediaTableViewCell *)[tblPlanned dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            UIViewController *view = [[UIViewController alloc]initWithNibName:@"MediaTableViewCell" bundle:nil];
            cell = (MediaTableViewCell *)view.view;
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        }
        
        cell.lblMainHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"caption"] objectAtIndex:indexPath.row]];
        
        
         cell.lblSubHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"message"] objectAtIndex:indexPath.row]];
        cell.imgcircle.layer.cornerRadius=cell.imgcircle.frame.size.width/2;
        cell.imgcircle.clipsToBounds=YES;
        [cell.btnLink setTitle:[NSString stringWithFormat:@"%@",[[[self.dictPlanCommon objectAtIndex:0] valueForKey:@"mediaURLs"] objectAtIndex:0]] forState:UIControlStateNormal];
          [cell.btnLink addTarget:self action:@selector(Link:) forControlEvents:UIControlEventTouchUpInside];
        NSArray *images = [[self.dictPlanCommon objectAtIndex:0] valueForKey:@"mediaFiles"];
        if (images.count) {
            [cell.imgfirst setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[images objectAtIndex:0]]]];
            if (images.count>1) {
                [cell.imgSec setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[images objectAtIndex:0]]]];
                if (images.count>2)
                    [cell.imgthird setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[images objectAtIndex:0]]]];
            }
        }
        
        NSString *dateString =[[self.dictPlanCommon valueForKey:@"addedOn"] objectAtIndex:indexPath.row];
        NSArray* dateArray = [dateString componentsSeparatedByString: @" "];
        
        cell.lblboxdate.text=[dateArray objectAtIndex:0];
        cell.lbldate.text=[NSString stringWithFormat:@"%@%@",[dateArray objectAtIndex:1],[dateArray objectAtIndex:2]];
        
        return cell;
    }
    else if ([self.strCateg isEqualToString:@"wo"])
    {
    
        HomeworkTableViewCell*   cell = (HomeworkTableViewCell *)[tblPlanned dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            UIViewController *view = [[UIViewController alloc]initWithNibName:@"HomeworkTableViewCell" bundle:nil];
            cell = (HomeworkTableViewCell *)view.view;
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        }
        
        cell.lblMainHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"title"] objectAtIndex:indexPath.row]];
        
        cell.lblSubHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"description"] objectAtIndex:indexPath.row]];
        
        cell.imgcircle.layer.cornerRadius=cell.imgcircle.frame.size.width/2;
        cell.imgcircle.clipsToBounds=YES;
        
        if (([[self.dictPlanCommon valueForKey:@"attachment"] objectAtIndex:indexPath.row] != [NSNull null])
            && ([[self.dictPlanCommon valueForKey:@"attachment"] objectAtIndex:indexPath.row] != nil)
            && ([[[self.dictPlanCommon valueForKey:@"attachment"] objectAtIndex:indexPath.row] length])) {
            [cell.btnLink setTitle:[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"attachment"] objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
        }
        else {
            [cell.btnLink setTitle:@"" forState:UIControlStateNormal];
            cell.imageLink.hidden = YES;
            
            CGRect frame = cell.lblLastHeading.frame;
            frame.origin.y = cell.btnLink.frame.origin.y;
            
            cell.lblLastHeading.frame = frame;
        }

        
        cell.lblLastHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"subject"] objectAtIndex:indexPath.row]];
        
        NSString *dateString =[[self.dictPlanCommon valueForKey:@"addedOn"] objectAtIndex:indexPath.row];
        
        NSArray* dateArray = [dateString componentsSeparatedByString: @" "];
        
        cell.lblboxdate.text=[dateArray objectAtIndex:0];
        cell.lbldate.text=[NSString stringWithFormat:@"%@%@",[dateArray objectAtIndex:1],[dateArray objectAtIndex:2]];
          [cell.btnLink addTarget:self action:@selector(Link:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    
    
    
    }
    else if([self.strCateg isEqualToString:@"send"])
    {
        
        ShowmsgTableViewCell*   cell = (ShowmsgTableViewCell *)[tblPlanned dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            UIViewController *view = [[UIViewController alloc]initWithNibName:@"ShowmsgTableViewCell" bundle:nil];
            cell = (ShowmsgTableViewCell *)view.view;
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        }
        
        return cell;
    }
    else
    {
        
        CircularTableViewCell*   cell1 = (CircularTableViewCell *)[tblPlanned dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell1 == nil)
        {
            UIViewController *view = [[UIViewController alloc]initWithNibName:@"CircularTableViewCell" bundle:nil];
            cell1 = (CircularTableViewCell *)view.view;
            cell1.selectedBackgroundView.backgroundColor = [UIColor clearColor];
            NSArray *arr= [[self.dictPlanCommon objectAtIndex:indexPath.section] objectForKey:@"holidays"];
            cell1.lblSubHeading.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row] valueForKey:@"reason"]];
            cell1.lblHeading.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row] valueForKey:@"date"]];
            
            return cell1;
        }
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if([self.strCateg isEqualToString:@"Cir"]|| [self.strCateg isEqualToString:@"Me"])
    {
        
        UILabel *myLabel = [[UILabel alloc] init];
        myLabel.frame = CGRectMake(10,0, 320, 25);
        myLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        myLabel.text = [self tableView:tableView titleForHeaderInSection:section]  ;
        myLabel.font=[UIFont fontWithName:@"arial-Bold" size:15.0];
        myLabel.textColor=[UIColor colorWithRed:7/255.0 green:42/255.0 blue:33/255.0 alpha:1.0f];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        
        
        [headerView addSubview:myLabel];
        
        return headerView;
        
    }
    return nil;}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if([self.strCateg isEqualToString:@"cal"])
    {
        return [[self.dictPlanCommon valueForKey:@"month"] objectAtIndex:section];
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.strCateg isEqualToString:@"Cir"])
    {
        return 90.0;
    }
    else if ([self.strCateg isEqualToString:@"Me"])
    {
        return 170.0;
    }
    else if ([self.strCateg isEqualToString:@"wo"])
    {
        if (!(([[self.dictPlanCommon valueForKey:@"attachment"] objectAtIndex:indexPath.row] != [NSNull null])
            && ([[self.dictPlanCommon valueForKey:@"attachment"] objectAtIndex:indexPath.row] != nil)
            && ([[[self.dictPlanCommon valueForKey:@"attachment"] objectAtIndex:indexPath.row] length])))
        {
            return 110;
        }

        return 142.0;
    }
    else
    {
        return 100.0;
    }
    
    
}
-(void)Link:(UIButton*)sender
{
    if(![self.strCateg isEqualToString:@"wo"])
    {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [[[self.dictPlanCommon objectAtIndex:sender.tag] valueForKey:@"mediaURLs"] objectAtIndex:0]]];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[self.dictPlanCommon objectAtIndex:sender.tag] valueForKey:@"attachment"]]];
    }

}
@end
