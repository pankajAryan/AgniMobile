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
#import "FFZoomImageCollectionView.h"
#import "WebCommunicationClass.h"

@interface PlannedTableViewController () <WebCommunicationClassDelegate>

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
    
    if([self.strCateg isEqualToString:@"Circular"]
       || [self.strCateg isEqualToString:@"Feedback"]
       || [self.strCateg isEqualToString:@"Homework"]
       || [self.strCateg isEqualToString:@"Message"]
       || [self.strCateg isEqualToString:@"Media"])
    {
//        tblPlanned.estimatedRowHeight = 86;

        tblPlanned.rowHeight = UITableViewAutomaticDimension;
    }

    
// ******************** || PANKAJ ||**************************************//
    
    WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
    [aCommunication setACaller:self];

    if([self.strCateg isEqualToString:@"Calendar"])
    {
        if([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"] || _isCommonType)
        {
            [aCommunication Get_PlannedHoliday:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] month:_strMonthIndex];
        }
        else
        {
            [aCommunication GetgetUnPlannedHolidays:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childClass"] objectAtIndex:_selectedTabIndex] childsetion:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childSection"] objectAtIndex:_selectedTabIndex] month:_strMonthIndex];
        }
    }
    
    else if ([_strCateg isEqualToString:@"Circular"])
    {
        if([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"] || _isCommonType)
        {
            [aCommunication Get_commonCircular:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"]];
        }
        else
        {
            [aCommunication GetCircular:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childClass"] objectAtIndex:_selectedTabIndex] childsetion:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childSection"] objectAtIndex:_selectedTabIndex]];
        }
    }
    
    else if ([_strCateg isEqualToString:@"Feedback"])
    {
        [aCommunication Getfeedback:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childClass"] objectAtIndex:_selectedTabIndex] childsetion:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childSection"] objectAtIndex:_selectedTabIndex] childId:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childId"] objectAtIndex:_selectedTabIndex]];
    }
    
    else if ([_strCateg isEqualToString:@"Media"])
    {
        if([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"] || _isCommonType)
        {
            [aCommunication Get_commonMedia:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"]];
        }
        else
        {
            [aCommunication Getmedia:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childClass"] objectAtIndex:_selectedTabIndex] childsetion:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childSection"] objectAtIndex:_selectedTabIndex]];
        }
    }
    
    else if ([_strCateg isEqualToString:@"Homework"])
    {
        [aCommunication GetHomeWork:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childClass"] objectAtIndex:_selectedTabIndex] childsetion:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childSection"] objectAtIndex:_selectedTabIndex]];
        
    }
    else if ([_strCateg isEqualToString:@"Message"])
    {
        [aCommunication GetMessage:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childClass"] objectAtIndex:_selectedTabIndex] childsetion:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childSection"] objectAtIndex:_selectedTabIndex]];
    }
}


#pragma mark- Webservice callback
#pragma mark-
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    id responseDict =[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSNumber * isSuccessNumber = (NSNumber *)[responseDict valueForKey:@"errorCode"];
    
    if(isSuccessNumber)
    {
        self.dictPlanCommon = [responseDict valueForKey:@"responseObject"];
        [tblPlanned reloadData];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
//    if([self.strCateg isEqualToString:@"Cir"]|| [self.strCateg isEqualToString:@"Me"] || [self.strCateg isEqualToString:@"wo"] || ([self.strCateg isEqualToString:@"Feed"] ||[self.strCateg isEqualToString:@"send"]))
//    {
    
//        return 1;
//    }
//    else
//    {
//        return [self.dictPlanCommon count];
//    }
//    
//    return 0;
//}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if([self.strCateg isEqualToString:@"Cir"]|| [self.strCateg isEqualToString:@"Me"] || [self.strCateg isEqualToString:@"wo"] || ([self.strCateg isEqualToString:@"Feed"] || [self.strCateg isEqualToString:@"send"]))
//    {
    
        return [self.dictPlanCommon count];
//    }
//    else
//    {
//        // Return the number of rows in the section.
//        NSArray *arr= [[self.dictPlanCommon objectAtIndex:section] objectForKey:@"holidays"];
//        return [arr count];
//    }
//    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    if([self.strCateg isEqualToString:@"Circular"] || [self.strCateg isEqualToString:@"Feedback"])
    {
        
        CalendarCell*   cell = (CalendarCell *)[tblPlanned dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            UIViewController *view = [[UIViewController alloc]initWithNibName:@"CalendarCell" bundle:nil];
            cell = (CalendarCell *)view.view;
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        }
        
        if ([self.strCateg isEqualToString:@"Feedback"])
            cell.lblMainHeading.text= nil;
        else
            cell.lblMainHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"title"] objectAtIndex:indexPath.row]];
        
        cell.lblSubHeading.text= [NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"message"] objectAtIndex:indexPath.row]];
        
        cell.imgDate.layer.cornerRadius=cell.imgDate.frame.size.width/2;
        cell.imgDate.clipsToBounds=YES;
        NSString *dateString;
        
        if ([self.strCateg isEqualToString:@"Feedback"])
            dateString =[[self.dictPlanCommon valueForKey:@"addedOn"] objectAtIndex:indexPath.row];
        else
            dateString =[[self.dictPlanCommon valueForKey:@"dateOf"] objectAtIndex:indexPath.row];
        
        NSArray* dateArray = [dateString componentsSeparatedByString: @" "];
        
        cell.lblboxdate.text=[dateArray objectAtIndex:0];
        cell.lbldate.text=[NSString stringWithFormat:@"%@%@",[dateArray objectAtIndex:1],[dateArray objectAtIndex:2]];
        
        return cell;
        
    }
    else if([self.strCateg isEqualToString:@"Media"])
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
        
        int index = 0;
        
        for (NSString *imageUrl in images) {
            
            switch (index)
            {
                case 0:
                    [cell.imgfirst setImageURL:[NSURL URLWithString:imageUrl]];

                    break;
                
                case 1:
                    [cell.imgSec setImageURL:[NSURL URLWithString:imageUrl]];

                    break;

                case 2:
                    [cell.imgthird setImageURL:[NSURL URLWithString:imageUrl]];

                    break;

                default:
                    break;
            }
            
            index++;
        }
        
        NSString *dateString =[[self.dictPlanCommon valueForKey:@"addedOn"] objectAtIndex:indexPath.row];
        NSArray* dateArray = [dateString componentsSeparatedByString: @" "];
        
        cell.lblboxdate.text=[dateArray objectAtIndex:0];
        cell.lbldate.text=[NSString stringWithFormat:@"%@%@",[dateArray objectAtIndex:1],[dateArray objectAtIndex:2]];
        
        [cell.buttonImage1 addTarget:self action:@selector(imageGalleryDidTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttonIMAGE2 addTarget:self action:@selector(imageGalleryDidTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttonImage3 addTarget:self action:@selector(imageGalleryDidTap:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else if ([self.strCateg isEqualToString:@"Homework"])
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
            [cell.btnLink setTitle:nil forState:UIControlStateNormal];
            cell.imageLink.hidden = cell.btnLink.hidden = YES;
            cell.buttonHeightConstraint.constant = 0;
            cell.subjectTopSpaceToButton = 0;
        }

        
        cell.lblLastHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"subject"] objectAtIndex:indexPath.row]];
        
        NSString *dateString =[[self.dictPlanCommon valueForKey:@"addedOn"] objectAtIndex:indexPath.row];
        
        NSArray* dateArray = [dateString componentsSeparatedByString: @" "];
        
        cell.lblboxdate.text=[dateArray objectAtIndex:0];
        cell.lbldate.text=[NSString stringWithFormat:@"%@%@",[dateArray objectAtIndex:1],[dateArray objectAtIndex:2]];
          [cell.btnLink addTarget:self action:@selector(Link:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if([self.strCateg isEqualToString:@"Message"])
    {
        
        ShowmsgTableViewCell*   cell = (ShowmsgTableViewCell *)[tblPlanned dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            UIViewController *view = [[UIViewController alloc]initWithNibName:@"ShowmsgTableViewCell" bundle:nil];
            cell = (ShowmsgTableViewCell *)view.view;
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        }
        cell.lblMainHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"title"] objectAtIndex:indexPath.row]];
        
        cell.lblSubHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"description"] objectAtIndex:indexPath.row]];
        
        cell.lblsubheadingvalue.text=[NSString stringWithFormat:@"Posted by %@",[[self.dictPlanCommon valueForKey:@"teacherName"] objectAtIndex:indexPath.row]];
        
        cell.imgDate.layer.cornerRadius=cell.imgDate.frame.size.width/2;
        cell.imgDate.clipsToBounds=YES;
        
        NSString *dateString =[[self.dictPlanCommon valueForKey:@"addedOn"] objectAtIndex:indexPath.row];
        NSArray* dateArray = [dateString componentsSeparatedByString: @" "];
        
        cell.lblboxdate.text=[dateArray objectAtIndex:0];
        cell.lbldate.text=[NSString stringWithFormat:@"%@%@",[dateArray objectAtIndex:1],[dateArray objectAtIndex:2]];
        return cell;
    }
    
    else //self.strCateg == @"Calendar"
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

/*
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
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if([self.strCateg isEqualToString:@"cal"])
    {
        return [[self.dictPlanCommon valueForKey:@"month"] objectAtIndex:section];
    }
    return nil;
}
*/

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//
//}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([self.strCateg isEqualToString:@"Circular"] || [self.strCateg isEqualToString:@"Feedback"])
    {
        return 86.0;
    }
    else if ([self.strCateg isEqualToString:@"Homework"]) {
        return 119.0;
    }
    else if ([self.strCateg isEqualToString:@"Message"]) {
        return 100.0;
    }
    else if ([self.strCateg isEqualToString:@"Media"]) {
            return 152.0;
    }

    return UITableViewAutomaticDimension;
}


#pragma mark-

-(void)Link:(UIButton*)sender
{
    if(![self.strCateg isEqualToString:@"Homework"])
    {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [[[self.dictPlanCommon objectAtIndex:sender.tag] valueForKey:@"mediaURLs"] objectAtIndex:0]]];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[self.dictPlanCommon objectAtIndex:sender.tag] valueForKey:@"attachment"]]];
    }

}

- (void)imageGalleryDidTap:(UIButton*)sender {
    
    NSArray *images = [[self.dictPlanCommon objectAtIndex:0] valueForKey:@"mediaFiles"];

    if (images.count > 0)
    {
        if (images.count > [sender tag]) {
            
            FFZoomImageCollectionView *zoomCollectionView = [[FFZoomImageCollectionView alloc] initWithDataSource:images andSelectedIndex:[sender tag]];
            [[UIApplication sharedApplication].keyWindow addSubview:zoomCollectionView];
        }
    }
}


@end
