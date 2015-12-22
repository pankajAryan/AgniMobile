//
//  TimeTableViewController.m
//  SchoolZen
//
//  Created by Pankaj Yadav on 12/10/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "TimeTableViewController.h"
#import "WebCommunicationClass.h"
#import "GlobalDataPersistence.h"
#import "Config.h"
#import "UIImage+Additions.h"

@interface TimeTableViewController ()

@end

@implementation TimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
    [aCommunication setACaller:self];
    
    GlobalDataPersistence*obj_GlobalDataPersistence = [GlobalDataPersistence sharedGlobalDataPersistence];

    [aCommunication getTimetable:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"] childclass:[self.dictChild valueForKey:@"childClass"] childsetion:[self.dictChild valueForKey:@"childSection"]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100);
    self.scrollView.frame = rect;
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

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imageView_Timetable;
}

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
        NSString *imageUrl = [strResult valueForKey:@"responseObject"];
        NSLog(@"%@",imageUrl);
        
//        _label_noInfo.hidden = (self.dictPlanCommon.count ? YES:NO);

        [self.imageView_Timetable setImageURL:[NSURL URLWithString:imageUrl]];
    }
    else
    {
        UIAlertView *alert = KALERT(KApplicationName, [strResult valueForKey:@"errorMessage"], self);
        [alert show];
        
    }
}


@end
