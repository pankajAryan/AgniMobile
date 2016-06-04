//
//  CircularDetailViewController.m
//  SchoolZen
//
//  Created by Pankaj Yadav on 05/06/16.
//  Copyright © 2016 Jatin. All rights reserved.
//

#import "CircularDetailViewController.h"

@interface CircularDetailViewController ()

@end

@implementation CircularDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.lblMainHeading.text = _mainHeading;
    
    self.lbldate.text = _date;
    
    self.txtView_circular.text = _noticeText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Click_Back:(id)sender
{    
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

@end
