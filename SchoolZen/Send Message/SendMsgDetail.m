//
//  HomeDetailViewController.m
//  SchoolZen
//
//  Created by Jatin on 8/19/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import "SendMsgDetail.h"
#import "WebCommunicationClass.h"
#import "GlobalDataPersistence.h"
#import "Config.h"


@interface SendMsgDetail ()

@end

@implementation SendMsgDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=YES;
    self.automaticallyAdjustsScrollViewInsets=NO;

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

- (IBAction)Click_Attached:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)Click_send:(id)sender {
    
    if(txttitle.text.length==0)
    {
        UIAlertView *alert =KALERT(KApplicationName, @"Please enter title", self);
        
        [alert show];
    }
    else if (txtHomeWork.text.length==0)
    {
        UIAlertView *alert =KALERT(KApplicationName, @"Please enter Message", self);
        
        [alert show];
    }
    else
    {
    GlobalDataPersistence *obj_glob=[GlobalDataPersistence sharedGlobalDataPersistence];
    WebCommunicationClass *obj_web=[WebCommunicationClass new];
    [obj_web setACaller:self];
        [obj_web addMsg:[obj_glob.dictUserInfo valueForKey:@"schoolId"] staffId:[obj_glob.dictUserInfo valueForKey:@"userId"] title:txttitle.text message:txtHomeWork.text classId:_strClassId attachmentURL:self.attachementUrl sectionId:_strSectionId];
    }
}

- (IBAction)Click_Back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    // Dismiss the image selection, hide the picker and
    
    int a=(int)[NSDate timeIntervalSinceReferenceDate];
    NSString*   documentName=[NSString stringWithFormat:@"doc%i.png",a];
    [UIImagePNGRepresentation(image) writeToFile: [[NSString stringWithFormat:@"~/Documents/%@",documentName] stringByExpandingTildeInPath]  atomically: YES];
    
    NSData *obj_data=[NSData dataWithContentsOfFile:[[NSString stringWithFormat:@"~/Documents/%@",documentName] stringByExpandingTildeInPath]];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    WebCommunicationClass *obj_web=[WebCommunicationClass new];
    [obj_web setACaller:self];
    [obj_web PutFileUpload:obj_data];
    
    
}


#pragma mark- Webservice callback
#pragma mark-
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    if ([aReq.url.path isEqualToString:@"/SchoolApp/rest/service/uploadHomeworkAttachment"]) {
        
        self.attachementUrl = aReq.responseString;
        
        return;
    }
    
    NSError *jsonParsingError = nil;
    
    NSString *strResult=[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSLog(@"%@",[strResult valueForKey:@"errorCode"]);
    NSNumber * isSuccessNumber = (NSNumber *)[strResult valueForKey:@"errorCode"];
    
    if(isSuccessNumber)
    {
        
        UIAlertView *alert =KALERT(KApplicationName, @"Message sent successfully.", nil);
        
        [alert show];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    else
        
    {
        
        UIAlertView *alert = KALERT(KApplicationName, [strResult valueForKey:@"errorMessage"], self);
        
        [alert show];
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}


@end
