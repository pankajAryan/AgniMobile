//
//  TestStudentTableViewController.m
//  SchoolZen
//
//  Created by Jatin on 7/23/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "TestStudentTableViewController.h"
#import "CalendarCell.h"
#import "MediaTableViewCell.h"
#import "CircularTableViewCell.h"
#import "GlobalDataPersistence.h"
#import "HomeworkTableViewCell.h"
#import "ShowmsgTableViewCell.h"
#import "FFZoomImageCollectionView.h"
#import "WebCommunicationClass.h"

@interface TestStudentTableViewController ()

@end

@implementation TestStudentTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
    
    self.dictPlanCommon=obj_GlobalDataPersistence.arrPlan;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    // ******************** || PANKAJ ||**************************************//
    
    WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
    [aCommunication setACaller:self];
    
    if ([_strCateg isEqualToString:@"Media"])
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
        
        _label_noInfo.hidden = (self.dictPlanCommon.count ? YES:NO);

        [tblPlanned reloadData];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dictPlanCommon count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    MediaTableViewCell*   cell = (MediaTableViewCell *)[tblPlanned dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if([self.strCateg isEqualToString:@"Media"])
    {
        if (cell == nil)
        {
            UIViewController *view = [[UIViewController alloc]initWithNibName:@"MediaTableViewCell" bundle:nil];
            cell = (MediaTableViewCell *)view.view;
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        }
        
        cell.lblMainHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"caption"] objectAtIndex:indexPath.row]];
        
        cell.lblSubHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"message"] objectAtIndex:indexPath.row]];
        
        [cell.lblMainHeading sizeToFit];
        [cell.lblSubHeading sizeToFit];
        
        cell.imgcircle.layer.cornerRadius=cell.imgcircle.frame.size.width/2;
        cell.imgcircle.clipsToBounds=YES;
        
        CGRect frame = CGRectZero;
        
        NSArray *images = [[self.dictPlanCommon objectAtIndex:0] valueForKey:@"mediaFiles"];
        if (images.count)
        {
            int index = 0;
            
            for (NSString *imageUrl in images) {
                
                switch (index)
                {
                    case 0:
                        [cell.imgfirst setImageURL:[NSURL URLWithString:imageUrl]];
                        [cell.buttonImage1 addTarget:self action:@selector(imageGalleryDidTap:) forControlEvents:UIControlEventTouchUpInside];
                        
                        break;
                        
                    case 1:
                        [cell.imgSec setImageURL:[NSURL URLWithString:imageUrl]];
                        [cell.buttonIMAGE2 addTarget:self action:@selector(imageGalleryDidTap:) forControlEvents:UIControlEventTouchUpInside];
                        
                        break;
                        
                    case 2:
                        [cell.imgthird setImageURL:[NSURL URLWithString:imageUrl]];
                        [cell.buttonImage3 addTarget:self action:@selector(imageGalleryDidTap:) forControlEvents:UIControlEventTouchUpInside];
                        
                        break;
                        
                    default:
                        break;
                }
                
                index++;
            }
        }
        else {
            cell.imgfirst.hidden = cell.buttonImage1.hidden = YES;
            cell.imgSec.hidden = cell.buttonIMAGE2.hidden = YES;
            cell.imgthird.hidden = cell.buttonImage3.hidden = YES;
            
            frame = cell.lblMainHeading.frame;
            frame.origin.y = cell.buttonImage1.frame.origin.y;
            cell.lblMainHeading.frame = frame;
        }
        
        NSString *linkText = [NSString stringWithFormat:@"%@",[[[self.dictPlanCommon objectAtIndex:0] valueForKey:@"mediaURLs"] objectAtIndex:0]];
        if (!linkText) {
            cell.linkIcon.hidden = cell.btnLink.hidden = YES;
        }
        else {
            [cell.btnLink setTitle:[NSString stringWithFormat:@"%@",[[[self.dictPlanCommon objectAtIndex:0] valueForKey:@"mediaURLs"] objectAtIndex:0]] forState:UIControlStateNormal];
            [cell.btnLink addTarget:self action:@selector(Link:) forControlEvents:UIControlEventTouchUpInside];
            
            frame = cell.btnLink.frame;
            frame.origin.y = cell.lblSubHeading.frame.origin.y + cell.lblSubHeading.frame.size.height + 5;
            cell.btnLink.frame = frame;
            
            CGPoint centre = cell.linkIcon.center;
            centre.y = cell.btnLink.center.y;
            cell.linkIcon.center = centre;
        }
        
        
        NSString *dateString =[[self.dictPlanCommon valueForKey:@"addedOn"] objectAtIndex:indexPath.row];
        NSArray* dateArray = [dateString componentsSeparatedByString: @" "];
        
        cell.lblboxdate.text=[dateArray objectAtIndex:0];
        cell.lbldate.text=[NSString stringWithFormat:@"%@%@",[dateArray objectAtIndex:1],[dateArray objectAtIndex:2]];
        
        frame = cell.frame;
        cell.imgBg.frame = CGRectMake(5, 2, frame.size.width -10, frame.size.height -6);
        
        return cell;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self calculateMediaCellHeight:indexPath];
}

- (CGFloat)calculateMediaCellHeight:(NSIndexPath*)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    MediaTableViewCell*   cell = (MediaTableViewCell *)[tblPlanned dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        UIViewController *view = [[UIViewController alloc]initWithNibName:@"MediaTableViewCell" bundle:nil];
        cell = (MediaTableViewCell *)view.view;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    }
    
    cell.lblMainHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"caption"] objectAtIndex:indexPath.row]];
    cell.lblSubHeading.text=[NSString stringWithFormat:@"%@",[[self.dictPlanCommon valueForKey:@"message"] objectAtIndex:indexPath.row]];
    
    CGFloat removedComponentsHeight = 0.0;
    
    NSString *linkText = [NSString stringWithFormat:@"%@",[[[self.dictPlanCommon objectAtIndex:0] valueForKey:@"mediaURLs"] objectAtIndex:0]];
    if (!linkText)
        removedComponentsHeight += 25 ;
    
    NSArray *images = [[self.dictPlanCommon objectAtIndex:0] valueForKey:@"mediaFiles"];
    if (!images.count)
        removedComponentsHeight += (42 + 9) ;
    
    CGFloat defaultCellHeight = 152.0;
    CGFloat defaultTitleHeight = 18.0;
    CGFloat defaultDetailLabelHeight = 16.0;
    
    CGFloat additionalTitlelabelHeight = [self heightForLabel:cell.lblMainHeading] - defaultTitleHeight;
    CGFloat additionalDetailLabelHeight = [self heightForLabel:cell.lblSubHeading] - defaultDetailLabelHeight;
    
    CGFloat calculatedCellHeight = (defaultCellHeight - removedComponentsHeight + additionalTitlelabelHeight + additionalDetailLabelHeight + 5);  // 5 is added for error margin
    
    return calculatedCellHeight;
}

- (CGFloat)heightForLabel:(UILabel*)label {
    
    //   [UIFont systemFontOfSize:label.font.pointSize]
    NSDictionary *attributes = @{NSFontAttributeName:label.font};
    
    CGRect textRect = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, 120) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return textRect.size.height;
}


#pragma mark-

-(void)Link:(UIButton*)sender
{
    NSArray *links = [[self.dictPlanCommon objectAtIndex:sender.tag] valueForKey:@"mediaURLs"];

    if (links.count > 0)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [[[self.dictPlanCommon objectAtIndex:sender.tag] valueForKey:@"mediaURLs"] objectAtIndex:0]]];
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
