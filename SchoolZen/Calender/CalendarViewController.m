//
//  CalendarViewController.m
//  SchoolZen
//
//  Created by Jatin on 7/21/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import "CalendarViewController.h"
#import "TestStudentTableViewController.h"
#import "PlannedTableViewController.h"
#import "GlobalDataPersistence.h"
#import "Config.h"
#import "TimeTableViewController.h"

@class TestStudentTableViewController;

@interface CalendarViewController () {
    
    PlannedTableViewController *controller1;
    PlannedTableViewController *controller2;
    PlannedTableViewController *controller3;
    TestStudentTableViewController *controller4;

}
@property (nonatomic) CAPSPageMenu *pageMenu;
@end

@implementation CalendarViewController
@synthesize strCat;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lblHeader.text = strCat;
    
    NSLog(@"%@",_strMonthIndex);
    
    UIColor *menuSelectionIndicatorColor = [UIColor blueColor];
    CGFloat pageMenuItemWidth = 90.0;
    
    GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];

    NSMutableArray *arrcontrollers = [NSMutableArray new];

    if([strCat isEqualToString:@"Calendar"])
    {
        imgHeader.backgroundColor = menuSelectionIndicatorColor = [UIColor colorWithRed:255.0/255.0 green:144.0/255.0 blue:0.0 alpha:1.0];
        
        controller3 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
        controller3.strCateg=strCat;
        controller3.strMonthIndex = _strMonthIndex;
        controller3.isCommonType = YES;
        
        if([obj_GlobalDataPersistence.strUserType isEqualToString:@"P"])
        {
            for (int index = 0; index < obj_GlobalDataPersistence.arrChild.count; index++) {
                
                PlannedTableViewController *controller = [[PlannedTableViewController alloc] initWithNibName:@"PlannedTableViewController" bundle:nil];
                controller.navigationController.navigationBarHidden=YES;
                
                controller.strCateg= strCat;
                controller.strMonthIndex = _strMonthIndex;
                controller.selectedTabIndex = index;
                controller.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:index];
                
                [arrcontrollers addObject:controller];
            }
            
            controller3.title = @"Planned";
        }
        else {
            pageMenuItemWidth = 140.0;
            controller3.title = @"Planned Holidays";
        }
        
        [arrcontrollers addObject:controller3];
    }
    
    else if ([strCat isEqualToString:@"timetable"])
    {
        imgHeader.backgroundColor = menuSelectionIndicatorColor = [UIColor colorWithRed:255.0/255.0 green:48/255.0 blue:170/255.0 alpha:1.0];
        lblHeader.text = @"Time Table";
        
        for (id child in obj_GlobalDataPersistence.arrChild) {
            
            TimeTableViewController *controller = [[TimeTableViewController alloc] initWithNibName:@"TimeTableViewController" bundle:nil];
            controller.dictChild =  child;
            controller.title = [child valueForKey:@"childName"];
            
            [arrcontrollers addObject:controller];
        }
    }

    else if ([strCat isEqualToString:@"Circular"])
    {
        imgHeader.backgroundColor = menuSelectionIndicatorColor = [UIColor colorWithRed:19.0/255.0 green:203.0/255.0 blue:132.0/255.0 alpha:1.0];
        
        if([obj_GlobalDataPersistence.strUserType isEqualToString:@"P"])
        {
            for (int index = 0; index < obj_GlobalDataPersistence.arrChild.count; index++) {
                
                PlannedTableViewController *controller = [[PlannedTableViewController alloc] initWithNibName:@"PlannedTableViewController" bundle:nil];
                controller.navigationController.navigationBarHidden=YES;
                
                controller.strCateg=strCat;
                controller.selectedTabIndex = index;
                controller.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:index];
                
                [arrcontrollers addObject:controller];
            }
        }

        controller3 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
        controller3.strCateg=strCat;
        controller3.isCommonType = YES;
        controller3.title = @"Common";
    
        [arrcontrollers addObject:controller3];
    }
    
    else if ([strCat isEqualToString:@"Feedback"])
    {
        imgHeader.backgroundColor = menuSelectionIndicatorColor = [UIColor colorWithRed:71.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0];
        
        for (int index = 0; index < obj_GlobalDataPersistence.arrChild.count; index++) {
            
            PlannedTableViewController *controller = [[PlannedTableViewController alloc] initWithNibName:@"PlannedTableViewController" bundle:nil];
            controller.navigationController.navigationBarHidden=YES;
            
            controller.strCateg=strCat;
            controller.selectedTabIndex = index;
            controller.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:index];
            
            [arrcontrollers addObject:controller];
        }
    }
    
    else if ([strCat isEqualToString:@"Media"])
    {
        imgHeader.backgroundColor = menuSelectionIndicatorColor = [UIColor colorWithRed:255.0/255.0 green:99.0/255.0 blue:117.0/255.0 alpha:1.0];
        
        if([obj_GlobalDataPersistence.strUserType isEqualToString:@"P"])
        {
            for (int index = 0; index < obj_GlobalDataPersistence.arrChild.count; index++) {
                
                TestStudentTableViewController *controller = [[TestStudentTableViewController alloc] initWithNibName:@"TestStudentTableViewController" bundle:nil];
                controller.navigationController.navigationBarHidden=YES;
                
                controller.strCateg=strCat;
                controller.selectedTabIndex = index;
                controller.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:index];
                
                [arrcontrollers addObject:controller];
            }
        }
        
        controller4 = [[TestStudentTableViewController alloc]initWithNibName:@"TestStudentTableViewController" bundle:nil];
        controller4.strCateg=strCat;
        controller4.isCommonType = YES;
        controller4.title = @"Common";
        
        [arrcontrollers addObject:controller4];
    }
    
    else if ([strCat isEqualToString:@"Homework"])
    {
         imgHeader.backgroundColor = menuSelectionIndicatorColor = [UIColor colorWithRed:149.0/255.0 green:181.0/255.0 blue:0.0 alpha:1.0];
        
//        controller2.strCateg=@"Work";

        for (int index = 0; index < obj_GlobalDataPersistence.arrChild.count; index++) {
            
            PlannedTableViewController *controller = [[PlannedTableViewController alloc] initWithNibName:@"PlannedTableViewController" bundle:nil];
            controller.navigationController.navigationBarHidden=YES;
            
            controller.strCateg=strCat;
            controller.selectedTabIndex = index;
            controller.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:index];
            
            [arrcontrollers addObject:controller];
        }
    }
    else if ([strCat isEqualToString:@"Message"])
    {
        imgHeader.backgroundColor = menuSelectionIndicatorColor = [UIColor colorWithRed:189.0/255.0 green:82.0/255.0 blue:45.0/255.0 alpha:1.0];
        
        for (int index = 0; index < obj_GlobalDataPersistence.arrChild.count; index++) {
            
            PlannedTableViewController *controller = [[PlannedTableViewController alloc] initWithNibName:@"PlannedTableViewController" bundle:nil];
            controller.navigationController.navigationBarHidden=YES;
            
            controller.strCateg=strCat;
            controller.selectedTabIndex = index;
            controller.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:index];
            
            [arrcontrollers addObject:controller];
        }
    }
    
    
    controllerArray = [arrcontrollers copy];
    
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor whiteColor],
                                 CAPSPageMenuOptionViewBackgroundColor: [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:1.0],
                                 CAPSPageMenuOptionSelectionIndicatorColor: menuSelectionIndicatorColor,
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0],
                                 CAPSPageMenuOptionMenuItemFont: [UIFont fontWithName:@"HelveticaNeue" size:13.0],
                                 CAPSPageMenuOptionMenuHeight: @(40.0),
                                 CAPSPageMenuOptionMenuItemWidth: @(pageMenuItemWidth),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES)
                                 };
    
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 64.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 60) options:parameters];
    
    _pageMenu.view.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1.0];
    
    [self.view addSubview:_pageMenu.view];
}


-(IBAction)Click_Back:(id)sender
{
    [[controllerArray objectAtIndex: _pageMenu.currentPageIndex] Click_Back:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Webservice callback
#pragma mark-

/*
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 
 lblHeader.text = strCat;
 
 NSLog(@"%@",_strMonthIndex);
 if([strCat isEqualToString:@"Calendar"])
 {
 imgHeader.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:144.0/255.0 blue:0.0 alpha:1.0]; // remains
 
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 
 if([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"])
 {
 WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
 [aCommunication setACaller:self];
 [aCommunication Get_PlannedHoliday:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] month:_strMonthIndex];
 }
 else
 {
 
 WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
 [aCommunication setACaller:self];
 
 
 [aCommunication GetgetUnPlannedHolidays:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childClass"] objectAtIndex:0] childsetion:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childSection"] objectAtIndex:0] month:_strMonthIndex];
 
 }
 
 }
 
 else if ([strCat isEqualToString:@"timetable"])
 {
 imgHeader.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:48/255.0 blue:170/255.0 alpha:1.0];
 lblHeader.text = @"Time Table";
 
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 
 NSMutableArray *arrcontrollers = [NSMutableArray new];
 
 for (id child in obj_GlobalDataPersistence.arrChild) {
 
 TimeTableViewController *controller = [[TimeTableViewController alloc] initWithNibName:@"TimeTableViewController" bundle:nil];
 controller.dictChild =  child;
 controller.title = [child valueForKey:@"childName"];
 [arrcontrollers addObject:controller];
 }
 
 controllerArray = [arrcontrollers copy];
 
 NSDictionary *parameters = @{
 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor whiteColor],
 CAPSPageMenuOptionViewBackgroundColor: [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:1.0],
 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor yellowColor],
 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0],
 CAPSPageMenuOptionMenuItemFont: [UIFont fontWithName:@"HelveticaNeue" size:13.0],
 CAPSPageMenuOptionMenuHeight: @(40.0),
 CAPSPageMenuOptionMenuItemWidth: @(90.0),
 CAPSPageMenuOptionCenterMenuItems: @(YES)
 };
 
 _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 64.0, self.view.frame.size.width, self.view.frame.size.height-60) options:parameters];
 
 [self.view addSubview:_pageMenu.view];
 }
 
 else if ([strCat isEqualToString:@"Circular"])
 {
 imgHeader.backgroundColor=[UIColor colorWithRed:19.0/255.0 green:203.0/255.0 blue:132.0/255.0 alpha:1.0];
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 if([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"])
 {
 WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
 [aCommunication setACaller:self];
 [aCommunication Get_commonCircular:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"]];
 }
 else
 {
 
 WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
 [aCommunication setACaller:self];
 
 [aCommunication GetCircular:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childClass"] objectAtIndex:0] childsetion:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childSection"] objectAtIndex:0]];
 
 
 }
 
 }
 else if ([strCat isEqualToString:@"Feedback"])
 {
 imgHeader.backgroundColor=[UIColor colorWithRed:71.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0];
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 
 
 WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
 [aCommunication setACaller:self];
 
 [aCommunication Getfeedback:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childClass"] objectAtIndex:0] childsetion:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childSection"] objectAtIndex:0] childId:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childId"] objectAtIndex:0]];
 
 }
 else if ([strCat isEqualToString:@"Media"])
 {
 imgHeader.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:99.0/255.0 blue:117.0/255.0 alpha:1.0];
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 
 
 if([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"])
 {
 WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
 [aCommunication setACaller:self];
 [aCommunication Get_commonMedia:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"]];
 }
 else
 {
 
 WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
 [aCommunication setACaller:self];
 
 [aCommunication Getmedia:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childClass"] objectAtIndex:0] childsetion:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childSection"] objectAtIndex:0]];
 }
 
 }
 else if ([strCat isEqualToString:@"Homework"])
 {
 imgHeader.backgroundColor=[UIColor colorWithRed:149.0/255.0 green:181.0/255.0 blue:0.0 alpha:1.0];
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
 [aCommunication setACaller:self];
 
 [aCommunication GetHomeWork:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childClass"] objectAtIndex:0] childsetion:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childSection"] objectAtIndex:0]];
 
 }
 else if ([strCat isEqualToString:@"Message"])
 {
 imgHeader.backgroundColor=[UIColor colorWithRed:189.0/255.0 green:82.0/255.0 blue:45.0/255.0 alpha:1.0];
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
 [aCommunication setACaller:self];
 
 [aCommunication GetMessage:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childClass"] objectAtIndex:0] childsetion:[[obj_GlobalDataPersistence.arrChild valueForKey:@"childSection"] objectAtIndex:0]];
 
 }
 
 }
 
 -(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
 {
 NSError *jsonParsingError = nil;
 
 NSString *strResult=[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
 
 NSNumber * isSuccessNumber = (NSNumber *)[strResult valueForKey:@"errorCode"];
 
 if(isSuccessNumber)
 {
 
 if(aReq.tag==3)
 {
 
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 obj_GlobalDataPersistence.arrTable=[strResult valueForKey:@"responseObject"];
 
 
 
 WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
 [aCommunication setACaller:self];
 [aCommunication Get_PlannedHoliday:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] month:_strMonthIndex];
 
 
 }
 else if (aReq.tag==2)
 {
 
 
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 
 
 if([obj_GlobalDataPersistence.strUserType isEqualToString:@"P"])
 {
 controller1 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller1.strCateg=@"cal";
 controller1.navigationController.navigationBarHidden=YES;
 controller1.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:0];
 
 controller2 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller2.strCateg=@"cal";
 controller2.navigationController.navigationBarHidden=YES;
 controller2.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:1];
 
 controller3 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller3.strCateg=@"cal";
 obj_GlobalDataPersistence.arrPlan=[strResult valueForKey:@"responseObject"];
 controller3.title = @"Planned";
 
 controllerArray = @[controller1,controller2,controller3];
 }
 else
 {
 controller1 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller1.strCateg=@"cal";
 obj_GlobalDataPersistence.arrPlan=[strResult valueForKey:@"responseObject"];
 controller1.title = @"Planned Holidays";
 controllerArray = @[controller1];
 }
 
 
 }
 
 else if(aReq.tag==5)
 {
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 obj_GlobalDataPersistence.arrTable=[strResult valueForKey:@"responseObject"];
 
 
 WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
 [aCommunication setACaller:self];
 [aCommunication Get_commonCircular:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"]];
 
 }
 else if (aReq.tag==4)
 {
 
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 
 if([obj_GlobalDataPersistence.strUserType isEqualToString:@"P"])
 {
 
 obj_GlobalDataPersistence.arrPlan=[strResult valueForKey:@"responseObject"];
 NSLog(@"%@",[strResult valueForKey:@"responseObject"]);
 controller1 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller1.strCateg=@"Cir";
 controller1.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:0];
 
 controller3 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller3.strCateg=@"Cir";
 controller3.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:1];
 
 
 controller2 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller2.strCateg=@"Cir";
 controller2.title = @"Common";
 obj_GlobalDataPersistence.arrPlan=[strResult valueForKey:@"responseObject"];
 controllerArray = @[controller1,controller3,controller2];
 }
 else
 {
 controller2 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller2.strCateg=@"Cir";
 controller2.title = @"Common";
 obj_GlobalDataPersistence.arrPlan=[strResult valueForKey:@"responseObject"];
 controllerArray = @[controller2];
 }
 
 }
 
 else if (aReq.tag==7)
 {
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 obj_GlobalDataPersistence.arrPlan=[strResult valueForKey:@"responseObject"];
 
 
 
 
 controller2 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller2.strCateg=@"Feed";
 controller2.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:0];;
 
 
 controller3 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller3.strCateg=@"Feed";
 controller3.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:1];;
 
 controllerArray = @[controller2,controller3];
 
 
 }
 else if(aReq.tag==9)
 {
 
 
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 obj_GlobalDataPersistence.arrTable=[strResult valueForKey:@"responseObject"];
 
 
 WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
 [aCommunication setACaller:self];
 [aCommunication Get_commonMedia:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"]];
 
 
 }
 else if (aReq.tag==8)
 {
 
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 obj_GlobalDataPersistence.arrPlan=[strResult valueForKey:@"responseObject"];
 if([obj_GlobalDataPersistence.strUserType isEqualToString:@"P"])
 {
 NSLog(@"%@",[strResult valueForKey:@"responseObject"]);
 controller1 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller1.strCateg=@"Me";
 controller1.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:0];
 
 controller3 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller3.strCateg=@"Me";
 controller3.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:1];
 
 
 controller2 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller2.strCateg=@"Me";
 controller2.title = @"Common";
 
 controllerArray = @[controller1,controller3,controller2];
 }
 else
 {
 obj_GlobalDataPersistence.arrPlan=[strResult valueForKey:@"responseObject"];
 controller2 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller2.strCateg=@"Me";
 controller2.title = @"Common";
 obj_GlobalDataPersistence.arrPlan=[strResult valueForKey:@"responseObject"];
 controllerArray = @[controller2];
 }
 
 }
 else if(aReq.tag==13)
 {
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 obj_GlobalDataPersistence.arrPlan=[strResult valueForKey:@"responseObject"];
 
 
 
 controller2 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller2.strCateg=@"Work";
 controller2.strCateg=@"wo";
 controller2.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:0];;
 
 
 controller3 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller3.strCateg=@"Work";
 controller3.strCateg=@"wo";
 controller3.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:1];;
 
 controllerArray = @[controller2,controller3];
 
 }
 else if (aReq.tag==22)
 {
 
 GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
 obj_GlobalDataPersistence.arrTable=[strResult valueForKey:@"responseObject"];
 if([obj_GlobalDataPersistence.strUserType isEqualToString:@"P"])
 {
 NSLog(@"%@",[strResult valueForKey:@"responseObject"]);
 controller1 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller1.strCateg=@"send";
 obj_GlobalDataPersistence.arrPlan=[strResult valueForKey:@"responseObject"];
 controller1.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:0];
 
 
 controller3 = [[PlannedTableViewController alloc]initWithNibName:@"PlannedTableViewController" bundle:nil];
 controller3.strCateg=@"send";
 obj_GlobalDataPersistence.arrPlan=[strResult valueForKey:@"responseObject"];
 controller3.title = [[obj_GlobalDataPersistence.arrChild valueForKey:@"childName"] objectAtIndex:1];
 
 
 
 controllerArray = @[controller1,controller3];
 }
 }
 
 NSDictionary *parameters = @{
 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor whiteColor],
 CAPSPageMenuOptionViewBackgroundColor: [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:1.0],
 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor yellowColor],
 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0],
 CAPSPageMenuOptionMenuItemFont: [UIFont fontWithName:@"HelveticaNeue" size:13.0],
 CAPSPageMenuOptionMenuHeight: @(40.0),
 CAPSPageMenuOptionMenuItemWidth: @(90.0),
 CAPSPageMenuOptionCenterMenuItems: @(YES)
 };
 
 _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 64.0, self.view.frame.size.width, self.view.frame.size.height-60) options:parameters];
 
 [self.view addSubview:_pageMenu.view];
 }
 
 }
 
*/

@end
