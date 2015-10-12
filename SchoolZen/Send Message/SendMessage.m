//
//  TeacherFeedbackViewController.m
//  SchoolZen
//
//  Created by Jatin on 8/4/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "SendMessage.h"
#import "GlobalDataPersistence.h"
#import "SendFeedbackViewController.h"
#import "Config.h"
#import "SendMsgDetail.h"

@interface SendMessage ()

@end

@implementation SendMessage

- (void)viewDidLoad {
    [super viewDidLoad];
    arrClassSection=[[NSMutableArray alloc] init];
arrMain=[[NSMutableArray alloc] init];
    teacherPicker.delegate=nil;
    teacherPicker.dataSource=nil;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Click_BAck:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Click_Proceed:(id)sender {
    
    if (btn_Class.titleLabel.text.length==0 || [btn_Class.titleLabel.text isEqualToString:@"Class"]) {
       
        UIAlertView *alert = KALERT(KApplicationName,@"Please Select Class", self);
        
        [alert show];

    }
    else if ((btn_Section.titleLabel.text.length==0)
             || ([btn_Class.titleLabel.text isEqualToString:@"Section"]))
    {
        UIAlertView *alert = KALERT(KApplicationName,@"Please Select Section", self);
        
        [alert show];

    }
    else
    {
    
    SendMsgDetail *obj_SendFeedbackViewController=[SendMsgDetail new];
    GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
    obj_SendFeedbackViewController.strClassId=[NSString stringWithFormat:@"%@",[[obj_glob.arrTeacher valueForKey:@"classId"] objectAtIndex:0]];
    obj_SendFeedbackViewController.strSectionId = [NSString stringWithFormat:@"%@",[[obj_glob.arrTeacher valueForKey:@"sectionId"] objectAtIndex:0]];
    
    [self.navigationController pushViewController:obj_SendFeedbackViewController animated:YES];
    
    }
    }

- (IBAction)Click_Class:(UIButton*)sender {
    
    if(sender.tag==0)
    {
        [arrClassSection removeAllObjects];
        strBtnSelection=@"C";
        GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
        for (int i=0; i<[obj_glob.arrTeacher count];i++) {
            [arrClassSection addObject:[NSString stringWithFormat:@"%@",[[obj_glob.arrTeacher valueForKey:@"className"] objectAtIndex:i]]];
            NSLog(@"%@",arrClassSection);
        }
    }
    else
    {
        strBtnSelection=@"S";
        [arrClassSection removeAllObjects];
        GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
        for (int i=0; i<[obj_glob.arrTeacher count];i++) {
            [arrClassSection addObject:[NSString stringWithFormat:@"%@",[[obj_glob.arrTeacher valueForKey:@"sectionName"] objectAtIndex:i]]];
            NSLog(@"%@",arrClassSection);
        }
    }
    
    arrMain=arrClassSection;
    NSLog(@"%@",arrMain);
    teacherPicker.delegate = self;
    teacherPicker.dataSource = self;
    [teacherPicker reloadAllComponents];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    vwPicker.frame = CGRectMake(0,(self.view.frame.size.width==375?450:347), self.view.frame.size.width, 222);
    [UIView commitAnimations];
    
    //[txtjobdesc resignFirstResponder];
    [self.view addSubview:vwPicker];
 
    
    
}


#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    
    return [arrMain count] ;
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    
if([strBtnSelection isEqualToString:@"C"])
{
    [btn_Class setTitle:[arrMain objectAtIndex:row] forState:UIControlStateNormal];
}
    else
    {
     [btn_Section setTitle:[arrMain objectAtIndex:row] forState:UIControlStateNormal];
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    vwPicker.frame = CGRectMake(0,750, self.view.frame.size.width, 222);
    [UIView commitAnimations];
    
    //[txtjobdesc resignFirstResponder];
    [self.view addSubview:vwPicker];

   
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    
   
    return [arrMain objectAtIndex:row];

}


@end
