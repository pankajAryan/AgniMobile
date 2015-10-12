//
//  TeacherSendHomeViewController.m
//  SchoolZen
//
//  Created by Jatin on 8/15/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "TeacherSendHomeViewController.h"
#import "SendFeedbackViewController.h"

@interface TeacherSendHomeViewController ()

@end

@implementation TeacherSendHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return 1;
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    
    
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return @"Play group";
}
-(IBAction)Click_BAck:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Click_Proceed:(id)sender {

}

- (IBAction)Click_Class:(id)sender {
}

- (IBAction)Click_Section:(id)sender {
}


@end
