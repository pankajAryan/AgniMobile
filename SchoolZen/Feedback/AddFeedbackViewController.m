//
//  AddFeedbackViewController.m
//  SchoolZen
//
//  Created by Jatin on 7/30/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "AddFeedbackViewController.h"
#import "WebCommunicationClass.h"
#import "GlobalDataPersistence.h"
#import "Config.h"

@interface AddFeedbackViewController ()

@end

@implementation AddFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GlobalDataPersistence*obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
    if([obj_GlobalDataPersistence.strUserType isEqualToString:@"T"])
    {
         _imgHeading.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
        
    }
    else
    {
     _imgHeading.backgroundColor=[UIColor colorWithRed:193.0/255.0 green:106.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
    
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)Click_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)Click_Send:(id)sender {
    
    if(_txttitle.text.length==0)
    {
    
    }
    else if (_txtMessage.text.length==0)
    {
    
    
    
    }
    else
    {

    WebCommunicationClass *obj_Web=[[WebCommunicationClass alloc] init];
    
    [obj_Web setACaller:self];
     GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
        
        [obj_Web AddFeedback:[obj_glob.dictUserInfo valueForKey:@"schoolId"] parentId:[[obj_glob.arrChild valueForKey:@"parentId"] objectAtIndex:0] title:self.txttitle.text message:self.txtMessage.text];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return true;
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
        
        UIAlertView *alert =KALERT(KApplicationName, @"We have received your valuable feedback, Thanks!", self);
        
        [alert show];
        
        [self.navigationController popViewControllerAnimated:YES];
      
    }
    else
        
    {
        
        UIAlertView *alert = KALERT(KApplicationName, [strResult valueForKey:@"errorMessage"], self);
        
        
        
        [alert show];
        
        
    }
    
    
    
    
    
    
}

@end
