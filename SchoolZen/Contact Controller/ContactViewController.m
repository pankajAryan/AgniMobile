//
//  ContactViewController.m
//  SchoolZen
//
//  Created by Jatin on 7/29/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "ContactViewController.h"
#import "WebCommunicationClass.h"
#import "GlobalDataPersistence.h"
#import "SideViewController.h"
#import "DashBoradViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
    WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
    [aCommunication setACaller:self];
    [aCommunication Get_Contact:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Webservice callback
#pragma mark-
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    NSString *strResult=[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSNumber * isSuccessNumber = (NSNumber *)[strResult valueForKey:@"errorCode"];
    
    if(isSuccessNumber)
    {
        
        [img setImageURL:[NSURL URLWithString:[[strResult valueForKey:@"responseObject"] valueForKey:@"schoolImage"]]];
        
        lblAddress.text=[NSString stringWithFormat:@"%@",[[strResult valueForKey:@"responseObject"] valueForKey:@"address"]];
        
        lblcontact.text=[NSString stringWithFormat:@"%@",[[strResult valueForKey:@"responseObject"] valueForKey:@"phone"]];
        
        lblEmail.text=[NSString stringWithFormat:@"%@",[[strResult valueForKey:@"responseObject"] valueForKey:@"email"]];

        lblURL.text=[NSString stringWithFormat:@"%@",[[strResult valueForKey:@"responseObject"] valueForKey:@"website"]];
    }
    
}
-(IBAction)Click_Back:(id)sender
{
    [[ALServiceInvoker sharedInstance] cancelRequest];
    [SVProgressHUD dismiss];

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
