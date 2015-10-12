//
//  HomeWorkViewController.m
//  SchoolZen
//
//  Created by Jatin on 8/19/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "HomeWorkViewController.h"
#import "HomeDetailViewController.h"
#import "GlobalDataPersistence.h"
#import "WebCommunicationClass.h"
#import "Config.h"

@interface HomeWorkViewController ()

@end

@implementation HomeWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrClassSection=[[NSMutableArray alloc] init];
    arrMain=[[NSMutableArray alloc] init];
    pickerHomeWork.delegate=nil;
    pickerHomeWork.dataSource=nil;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Btn_Common:(UIButton*)sender
{
if(sender.tag==0)
{
    [arrClassSection removeAllObjects];
    strBtnSelection=@"C";
    GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
    for (int i=0; i<[obj_glob.arrTeacher count];i++) {
        [arrClassSection addObject:[NSString stringWithFormat:@"%@",[[obj_glob.arrTeacher valueForKey:@"className"] objectAtIndex:i]]];
       
    }
}
else if (sender.tag==1)
{
    strBtnSelection=@"S";
    [arrClassSection removeAllObjects];
    GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
    for (int i=0; i<[obj_glob.arrTeacher count];i++) {
        [arrClassSection addObject:[NSString stringWithFormat:@"%@",[[obj_glob.arrTeacher valueForKey:@"sectionName"] objectAtIndex:i]]];
        
        NSLog(@"%@",arrClassSection);
    }

}
else if (sender.tag==2)
{
    strBtnSelection=@"Se";
    [arrClassSection removeAllObjects];
    GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
    for (int i=0; i<[obj_glob.arrTeacher count];i++) {
        [arrClassSection addObject:[NSString stringWithFormat:@"%@",[[obj_glob.arrTeacher valueForKey:@"subjectName"] objectAtIndex:i]]];
        NSLog(@"%@",arrClassSection);
        
    }
    
}

    arrMain=arrClassSection;
    NSLog(@"%f",self.view.frame.size.width);
    pickerHomeWork.delegate = self;
    pickerHomeWork.dataSource = self;
    [pickerHomeWork reloadAllComponents];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    vwHomeWorkPicker.frame = CGRectMake(0,(self.view.frame.size.width==375?450:347), self.view.frame.size.width, 222);
    [UIView commitAnimations];
    
    [self.view addSubview:vwHomeWorkPicker];


}


- (IBAction)Click_HomeProceed:(id)sender {
    
    if (btnClass.titleLabel.text.length==0 || [btnClass.titleLabel.text isEqualToString:@"Class"]) {
        
        UIAlertView *alert = KALERT(KApplicationName,@"Please Select Class", self);
        
        [alert show];
        
    }
    else if ((btnSection.titleLabel.text.length==0)
             || ([btnSection.titleLabel.text isEqualToString:@"Section"]))
    {
        UIAlertView *alert = KALERT(KApplicationName,@"Please Select Section", self);
        
        [alert show];
    }
    else if ((btn_Subject.titleLabel.text.length==0)
             || ([btn_Subject.titleLabel.text isEqualToString:@"Subject"]))
    {
        UIAlertView *alert = KALERT(KApplicationName,@"Please Select Subject", self);
        
        [alert show];
        
    }
    
    else
    {
    
    HomeDetailViewController *obj_HomeDetailViewController=[HomeDetailViewController new];
  
        [self.navigationController pushViewController:obj_HomeDetailViewController animated:YES];
    }
 
}

- (IBAction)Click_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
    //Demo
    if([strBtnSelection isEqualToString:@"C"])
    {
        [btnClass setTitle:[arrMain objectAtIndex:row] forState:UIControlStateNormal];
    }
    else if([strBtnSelection isEqualToString:@"S"])
    {
        [btnSection setTitle:[arrMain objectAtIndex:row] forState:UIControlStateNormal];
    }
    else
    {
     [btn_Subject setTitle:[arrMain objectAtIndex:row] forState:UIControlStateNormal];
    
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    vwHomeWorkPicker.frame = CGRectMake(0,750, self.view.frame.size.width, 222);
    [UIView commitAnimations];
    
    //[txtjobdesc resignFirstResponder];
    [self.view addSubview:vwHomeWorkPicker];
    
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    
    
    return [arrMain objectAtIndex:row];
    
}
@end
