//
//  SendFeedbackViewController.m
//  SchoolZen
//
//  Created by Jatin on 8/18/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "SendFeedbackViewController.h"
#import "WebCommunicationClass.h"
#import "GlobalDataPersistence.h"
#import "Config.h"
#import "SendFeedTableViewCell.h"

@interface SendFeedbackViewController ()

@end

@implementation SendFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=YES;
    self.automaticallyAdjustsScrollViewInsets=NO;

    obj_student=[[NSMutableArray alloc] init];
    
    arrSelected=[[NSMutableArray alloc] init];
    WebCommunicationClass *obj_Web=[[WebCommunicationClass alloc] init];
    
    [obj_Web setACaller:self];
    GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
    
    [obj_Web GetStudentsOfClass:[obj_glob.dictUserInfo valueForKey:@"schoolId"] classId:_strClassId sectionId:_strSectionId];//  classId:@"3" sectionId:@"71"];

    // Do any additional setup after loading the view from its nib.
    GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
    
    if([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"])
    {
        _imgHeading.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
        
    }
    else
    {
        _imgHeading.backgroundColor=[UIColor colorWithRed:193.0/255.0 green:106.0/255.0 blue:255.0/255.0 alpha:1.0];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark- Webservice callback
#pragma mark-
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    NSString *strResult=[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSLog(@"%@",[strResult valueForKey:@"errorCode"]);
    NSNumber * isSuccessNumber = (NSNumber *)[strResult valueForKey:@"errorCode"];
    
    if(isSuccessNumber)
    {
        
        
        if(aReq.tag==17)
        
        {
            UIAlertView *alert = KALERT(KApplicationName, @"Feedback sent successfully.", nil);
            
            [alert show];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
        NSArray *arr=[strResult valueForKey:@"responseObject"];
        for (NSDictionary *dict in arr )
        {
            
            NSLog(@"%@",dict);
            [obj_student addObject:[NSMutableDictionary dictionaryWithDictionary:dict]];
             NSLog(@"%@",obj_student);
        }
        NSLog(@"%@",obj_student);
        
        for (int j=0; j<[obj_student count];j++)
        {
            NSMutableDictionary *aDict=[[NSMutableDictionary alloc] init];
            
            aDict = [obj_student  objectAtIndex:j];
            
            
            
            [aDict setObject:[NSString stringWithFormat:@"%@",@"0"] forKey:[NSString stringWithFormat:@"%@",kisuserselection]];
            
            for (int i = 0; i <[obj_student count]; i++)
            {
                if (j == i)
                {
                    
                    [obj_student  replaceObjectAtIndex:i withObject:aDict];
                    
                    
                    break;
                }
            }
        }
        NSLog(@"%@",obj_student);
        [tblSendFeedBack reloadData];
        }
    }
    else
        
    {
        
        UIAlertView *alert = KALERT(KApplicationName, [strResult valueForKey:@"errorMessage"], self);
        
        
        
        [alert show];
        
        
    }

    
}
-(IBAction)Select_All:(id)sender
{
  NSMutableDictionary *aDict=[[NSMutableDictionary alloc]init];

    for (int j=0; j<[obj_student count];j++)
    {
        
    
        aDict = [obj_student  objectAtIndex:j];
        
        
        
        [aDict setObject:[NSString stringWithFormat:@"%@",@"1"] forKey:[NSString stringWithFormat:@"%@",kisuserselection]];
        
        for (int i = 0; i <[obj_student count]; i++)
        {
            if (j == i)
            {
                
                [obj_student  replaceObjectAtIndex:i withObject:aDict];
                
                
                break;
            }
        }
        [tblSendFeedBack reloadData];
    }

        
            
      
   


}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [obj_student count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   static NSString *CellIdentifier = @"Cell";
    
    
        SendFeedTableViewCell*   cell = (SendFeedTableViewCell *)[tblSendFeedBack dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            UIViewController *view = [[UIViewController alloc]initWithNibName:@"SendFeedTableViewCell" bundle:nil];
            cell = (SendFeedTableViewCell *)view.view;
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        }
    cell.btnSelection.tag=indexPath.row;
     NSMutableDictionary * dict = [obj_student objectAtIndex:indexPath.row] ;
    cell.lblStudent.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"studentName"]];
     cell.lblRollNo.text=[NSString stringWithFormat:@"Roll No. %@",[dict valueForKey:@"studentId"]];
    
    [cell.btnSelection addTarget:self action:@selector(User_selection:) forControlEvents:UIControlEventTouchUpInside];
    int userSelected = (int)[[dict valueForKey:[NSString stringWithFormat:@"%@",kisuserselection]] integerValue];
    
    [cell.btnSelection setSelected:userSelected];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 92.0;
    
    
}
-(void)User_selection:(UIButton*)sender
{

    NSMutableDictionary *aDict=[[NSMutableDictionary alloc]init];
    
    if (sender.selected)
    {
        aDict = [obj_student   objectAtIndex:sender.tag] ;
        
        
        [aDict setObject:[NSString stringWithFormat:@"%@",@"0"] forKey:[NSString stringWithFormat:@"%@",kisuserselection]];
        
        for (int i = 0; i <[obj_student count]; i++)
        {
            if (sender.tag == i)
            {
            
                [obj_student replaceObjectAtIndex:i withObject:aDict];
                break;
            }
        }
        [tblSendFeedBack reloadData];
    }
    else
    {
        aDict = [obj_student  objectAtIndex:sender.tag];
        
     
        
        [aDict setObject:[NSString stringWithFormat:@"%@",@"1"] forKey:[NSString stringWithFormat:@"%@",kisuserselection]];
        
        for (int i = 0; i <[obj_student count]; i++)
        {
            if (sender.tag == i)
            {
                
                [obj_student  replaceObjectAtIndex:i withObject:aDict];
                
                
                break;
            }
        }
        [tblSendFeedBack reloadData];
    }


}
-(IBAction)Click_Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)Click_Save:(id)sender {
    
    
    
    if(txtPostMessage.text.length==0)
    {
        UIAlertView *alert =KALERT(KApplicationName, @"Please enter Post", self);
        
        [alert show];
    }
    else
    {
        [arrSelected removeAllObjects];
        NSLog(@"%@",obj_student);
        
    for (int k=0; k<[obj_student count]; k++) {
        if([[[obj_student valueForKey:@"userSelection"] objectAtIndex:k] integerValue]==1)
        {
            [arrSelected addObject:[obj_student objectAtIndex:k]];
        
        }
    }
    
    
    NSArray *myStrings = [arrSelected valueForKey:@"studentId"];

    NSString *joinedString = [myStrings componentsJoinedByString:@"|"];
    
     NSLog(@"%@",joinedString);
    
    WebCommunicationClass *obj_Web=[[WebCommunicationClass alloc] init];
    
    [obj_Web setACaller:self];
    GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];

    [obj_Web AddFeedbackTeacher:[obj_glob.dictUserInfo valueForKey:@"schoolId"] staffId:[obj_glob.dictUserInfo valueForKey:@"userId"] message:txtPostMessage.text classId:_strClassId sectionId:_strSectionId childIds:joinedString];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}


@end
