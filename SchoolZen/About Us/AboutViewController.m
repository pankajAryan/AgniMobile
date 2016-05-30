//
//  AboutViewController.m
//  SchoolZen
//
//  Created by Jatin on 7/20/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import "AboutViewController.h"
#import "DashBoradViewController.h"
#import "SideViewController.h"
#import "GlobalDataPersistence.h"
#import "WebCommunicationClass.h"
#import "GlobalDataPersistence.h"
#import "CustomNavigation.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
    
    [imgschool setImageURL:[NSURL URLWithString:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolImage"]]];
    
    WebCommunicationClass* aCommunication = [[WebCommunicationClass alloc]init];
    [aCommunication setACaller:self];
    [aCommunication Get_About:[obj_GlobalDataPersistence.dictUserInfo valueForKey:@"schoolId"]];

    // Do any additional setup after loading the view from its nib.
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
        NSMutableString *html = [NSMutableString stringWithString:[[strResult valueForKey:@"responseObject"] valueForKey:@"aboutUs"]];
        
        //continue building the string
       
        [html appendString:@"</body></html>"];
        
        //instantiate the web view

        [webAbout loadHTMLString:[html description] baseURL:nil];

    
    }
        
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
