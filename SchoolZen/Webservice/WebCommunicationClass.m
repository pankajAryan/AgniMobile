 


#import "WebCommunicationClass.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SVProgressHUD.h"
#import "Config.h"
#import "AppDelegate.h"
#import "ALUtilityClass.h"
#import "NSString+MD5.h"

@implementation WebCommunicationClass

@synthesize aCaller,MethoodName;

- (id)init {
    self = [super init];
    if (self)
	{
		AnAppDelegatObj=(AppDelegate *)[[UIApplication sharedApplication] delegate];
		
    }
    return self;
}
- (void)dealloc
{
//    NSLog(@"%s",__PRETTY_FUNCTION__);
    [aCaller release];
    aCaller = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark - User Defined Methods

-(void)loginUserName:(NSString*)username  withpassword:(NSString*)password UserType:(NSString*)usertype
{    
    [SVProgressHUD showWithStatus:@"Please wait..."];

    password = [password MD5String];
    
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:username forKey:@"email"];
    [aUserInfo setValue:password forKey:@"password"];
    [aUserInfo setValue:usertype forKey:@"userType"];
    
    if (password && password.length)//[usertype isEqualToString:@"P"]
    {
        [aUserInfo setValue:@"Email" forKey:@"loginType"];
        
        [ALUtilityClass SaveDatatoUserDefault:@"Email" :@"loginType"];
        [ALUtilityClass SaveDatatoUserDefault:password :@"pass"];
    }
    else {
        [aUserInfo setValue:@"G+" forKey:@"loginType"];
        
        [ALUtilityClass SaveDatatoUserDefault:@"G+" :@"loginType"];
    }
    
    //    [self ASICallSyncToServerWithFunctionName:Login_MethodName PostDataDictonery:aUserInfo];
    [self retain];
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:Login_MethodName reqTag:1 delegate:self];
}

-(void)Get_PlannedHoliday:(NSString *)getPlannedHolidays month:(NSString*)month
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:getPlannedHolidays forKey:@"schoolId"];
    [aUserInfo setValue:month forKey:@"month"];
    [self retain];

    
     [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kgetPlannedHolidays reqTag:2 delegate:self];

}
-(void)GetgetUnPlannedHolidays:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection month:(NSString*)month
{

    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [aUserInfo setValue:childClass forKey:@"childClass"];
    [aUserInfo setValue:childSection forKey:@"childSection"];
    [aUserInfo setValue:month forKey:@"month"];
    
    [self retain];
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kgetUnPlannedHolidays reqTag:3 delegate:self];

}


-(void)Get_commonCircular:(NSString *)schoolId
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:KgetCommonCircular reqTag:4 delegate:self];



}

-(void)getTimetable:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection
{
    
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [aUserInfo setValue:childClass forKey:@"classId"];
    [aUserInfo setValue:childSection forKey:@"sectionId"];
    
    [self retain];
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:KgetTimeTable reqTag:21 delegate:self];
}

-(void)GetCircular:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection
{

    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [aUserInfo setValue:childClass forKey:@"childClass"];
    [aUserInfo setValue:childSection forKey:@"childSection"];
    
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kgetCircularForChild reqTag:5 delegate:self];


}


-(void)Get_commonfeedback:(NSString *)schoolId
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kgetCommonFeedback reqTag:6 delegate:self];



}
-(void)Getfeedback:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection childId:(NSString*)childId
{

    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [aUserInfo setValue:childClass forKey:@"childClass"];
    [aUserInfo setValue:childSection forKey:@"childSection"];
    [aUserInfo setValue:childId forKey:@"childId"];

    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kgetFeedbackForChild reqTag:7 delegate:self];

}

-(void)Get_commonMedia:(NSString *)schoolId
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kgetCommonMedia reqTag:8 delegate:self];
    

}
-(void)Getmedia:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [aUserInfo setValue:childClass forKey:@"childClass"];
    [aUserInfo setValue:childSection forKey:@"childSection"];
    
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kgetMediaForChild reqTag:9 delegate:self];

}

-(void)Get_Contact:(NSString *)schoolId
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kgetContact reqTag:10 delegate:self];

}

-(void)Get_About:(NSString *)schoolId
{

    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kgetAbout reqTag:11 delegate:self];


}

-(void)AddFeedback:(NSString *)schoolId parentId:(NSString *)parentId title:(NSString *)tile message:(NSString*)msg
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
        [aUserInfo setValue:parentId forKey:@"parentId"];
    [aUserInfo setValue:tile forKey:@"title"];
    [aUserInfo setValue:msg forKey:@"message"];
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kaddFeedbackForSchool reqTag:12 delegate:self];


}

-(void)GetHomeWork:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection
{
    
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [aUserInfo setValue:childClass forKey:@"childClass"];
    [aUserInfo setValue:childSection forKey:@"childSection"];
    
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:Kgethomework reqTag:13 delegate:self];
}

-(void)updateProfile:(NSString*)userId userType:(NSString*)userType userName:(NSString*)userName userEmail:(NSString*)userEmail userMobile:(NSString*)userMobile newPassword:(NSString*)loginPass
{
    
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:userId forKey:@"userId"];
    [aUserInfo setValue:userType forKey:@"userType"];
    [aUserInfo setValue:userName forKey:@"userName"];
    [aUserInfo setValue:userEmail forKey:@"userEmail"];
    [aUserInfo setValue:userMobile forKey:@"userMobile"];
    [aUserInfo setValue:loginPass forKey:@"password"];
    
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:KupdateUser reqTag:14 delegate:self];
}

-(void)getTicker:(NSString*)schoolId {
    
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    
    [self retain];

    ALServiceInvoker *serviceInvoker = [[ALServiceInvoker alloc] init];
    [serviceInvoker serviceInvokerRequestWithParams:aUserInfo requestAPI:API_GET_TICKER reqTag:41 delegate:self];
}

-(void)GetStaffClassSectionSubjectStructure:(NSString*)schoolId staffId:(NSString*)staffId
{

    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [aUserInfo setValue:staffId forKey:@"staffId"];
   
    
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kgetStaffClassSectionSubjectStructure reqTag:15 delegate:self];



}

-(void)GetStudentsOfClass:(NSString*)schoolId classId:(NSString*)classId sectionId:(NSString*)sectionId
{

    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [aUserInfo setValue:classId forKey:@"schoolClass"];
     [aUserInfo setValue:sectionId forKey:@"schoolSection"];
    
    
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kgetStudentsOfClass reqTag:16 delegate:self];


}

-(void)AddFeedbackTeacher:(NSString*)schoolId staffId:(NSString*)staffId message:(NSString*)message classId:(NSString*)classId sectionId:(NSString*)sectionId childIds:(NSString*)childIds
{


    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [aUserInfo setValue:staffId forKey:@"staffId"];
    [aUserInfo setValue:message forKey:@"message"];
    
    [aUserInfo setValue:classId forKey:@"classId"];
    [aUserInfo setValue:sectionId forKey:@"sectionId"];
    [aUserInfo setValue:childIds forKey:@"childIds"];
    
    
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:KteacherFeedback reqTag:17 delegate:self];


}


-(void)PutFileUpload:(NSData*)file
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:file forKey:@"file"];
    
    
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:KfileUpload reqTag:18 delegate:self];

}
-(void)addHomework:(NSString*)schoolId staffId:(NSString*)staffId title:(NSString*)title message:(NSString*)message classId:(NSString*)classId
     attachmentURL:(NSString*)attachmentURL sectionId:(NSString*)sectionId subjectId:(NSString*)subjectId
{

    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [aUserInfo setValue:staffId forKey:@"staffId"];
    
    [aUserInfo setValue:title forKey:@"title"];
    [aUserInfo setValue:message forKey:@"message"];
    [aUserInfo setValue:classId forKey:@"classId"];
    
    if (attachmentURL) {
        [aUserInfo setValue:attachmentURL forKey:@"attachmentURL"];
    }
    else
        [aUserInfo setValue:@"" forKey:@"attachmentURL"];
    
    [aUserInfo setValue:sectionId forKey:@"sectionId"];
    
    [aUserInfo setValue:subjectId forKey:@"subjectId"];
   
    
    
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kaddHomework reqTag:19 delegate:self];



}

-(void)ForgotPassword:(NSString *)email :(NSString*)userType;
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:email forKey:@"email"];
       [aUserInfo setValue:userType forKey:@"userType"];
 [self retain];
     [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:KforgotPassword reqTag:20 delegate:self];
}

-(void)addMsg:(NSString*)schoolId staffId:(NSString*)staffId title:(NSString*)title message:(NSString*)message classId:(NSString*)classId attachmentURL:(NSString*)attachmentURL sectionId:(NSString*)sectionId
{
    
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [aUserInfo setValue:staffId forKey:@"staffId"];
    
    [aUserInfo setValue:title forKey:@"title"];
    [aUserInfo setValue:message forKey:@"message"];
    [aUserInfo setValue:classId forKey:@"classId"];
    
    if (attachmentURL) {
        [aUserInfo setValue:attachmentURL forKey:@"attachmentURL"];
    }
    else
        [aUserInfo setValue:@"" forKey:@"attachmentURL"];

    
    [aUserInfo setValue:sectionId forKey:@"sectionId"];
    
    [self retain];
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:KaddMessage reqTag:21 delegate:self];
}


-(void)GetMessage:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection
{
    
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:schoolId forKey:@"schoolId"];
    [aUserInfo setValue:childClass forKey:@"childClass"];
    [aUserInfo setValue:childSection forKey:@"childSection"];
    
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:KgetMessages reqTag:22 delegate:self];
    
    
}

/*
-(void)checkCompanyExist:(NSString*)companyName
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    //    NSString *url = [ServerAdd stringByAppendingFormat:@"%@?email=%@&password=%@",Login_MethodName,username,password];
    //    [self ASICallSyncToServerWithUrl:url FunctionName:Login_MethodName];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    
    [aUserInfo setValue:companyName forKey:@"companyName"];
	[aUserInfo setValue:companyName_MethodName forKey:@"action"];
    
    NSLog(@"to=%@",aUserInfo);
    //NSString *json=[[NSString alloc]initWithString:[aTodayEvent JSONFragment]];
	//NSLog( @"%@",json);=admin&=123456
    [self ASICallSyncToServerWithFunctionName:companyName_MethodName PostDataDictonery:aUserInfo];
}
-(void)registerUser:(NSMutableDictionary *)userData
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:SignUp_MethodName PostDataDictonery:userData];
}

-(void)updateUserProfile:(NSMutableDictionary *)userData
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:UpdateUser PostDataDictonery:userData];
}

-(void)updateCompanyDetails:(NSMutableDictionary *)dictCompnayDetails
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:UpdateUser PostDataDictonery:dictCompnayDetails];
}

-(void)fetchAllUsers:(NSMutableDictionary *)dictCompany
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:FetchAllUers PostDataDictonery:dictCompany];
}

-(void)changeUserStatus:(NSMutableDictionary *)dictUser
{
    [self ASICallSyncToServerWithFunctionName:kChangeUserStatus PostDataDictonery:dictUser];
}

-(void)deleteUser: (NSMutableDictionary *) dictUser
{
    [self ASICallSyncToServerWithFunctionName:kDeleteUser PostDataDictonery:dictUser];
}

-(void)editUserInUserPanel:(NSMutableDictionary *) dictUser
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kEditUserInUserPanel PostDataDictonery:dictUser];
}

-(void)addImporter:(NSMutableDictionary *) dictImporter
{
    [self ASICallSyncToServerWithFunctionName:kAddImporter PostDataDictonery:dictImporter];
}

-(void)addExporter:(NSMutableDictionary *) dictExporter
{
    [self ASICallSyncToServerWithFunctionName:kAddExporter PostDataDictonery:dictExporter];
}


-(void)fetchExporters:(NSMutableDictionary *)dict
{
    [self ASICallSyncToServerWithFunctionName:kListExporter PostDataDictonery:dict];
}

-(void)fetchImporters:(NSMutableDictionary *)dict
{
    [self ASICallSyncToServerWithFunctionName:kListImporter PostDataDictonery:dict];
}

-(void)addSample:(NSMutableDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kAddSample PostDataDictonery:dict];
}
-(void)addDulicateSample:(NSMutableDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kAddDuplicateSample PostDataDictonery:dict];
}
-(void)setSampleReportStatus:(NSMutableDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kSetSampleReportStatus PostDataDictonery:dict];
}
-(void)updateLocation:(NSMutableDictionary *)dict
{
    [self ASICallSyncToServerWithFunctionName:kUpdateUserLocation PostDataDictonery:dict];
}

-(void)fetchAllSample:(NSMutableDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kListSample PostDataDictonery:dict];
}
-(void)getNearestUserList:(NSString *)userId
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    NSMutableDictionary *dict= [NSMutableDictionary dictionary];
    
    [dict setValue:userId forKey:@"userId"];
    [self ASICallSyncToServerWithFunctionName:kGetNearestUserList PostDataDictonery:dict];
}
-(void)allowGuestUser:(NSMutableDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kAllowGuestUser PostDataDictonery:dict];
}
-(void)addCupping:(NSMutableDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kAddCupping PostDataDictonery:dict];
}
*/





//-(void)resetCouping:(NSMutableDictionary *)dict
//{
//    [SVProgressHUD showWithStatus:@"Loading..."];
//    [self ASICallSyncToServerWithFunctionName:kResetCouping PostDataDictonery:dict];
//}
//-(void)getOpenSampleData:(NSMutableDictionary *)dict
//{
//    [SVProgressHUD showWithStatus:@"Loading..."];
//    [self ASICallSyncToServerWithFunctionName:kGetOpenSampleData PostDataDictonery:dict];
//}



#pragma mark - Class Methods


+ (NSString *)urlEncodeValue:(NSString *)str
{
	NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
	return [result autorelease];
}
+ (NSString *)urlDecodeValue:(NSString *)str
{
	//NSString *result = (NSString *) CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
	NSString *result = (NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)str,  CFSTR("?=&+"), kCFStringEncodingUTF8);
	return [result autorelease];
}

//-(void)uploadImage:(NSString*)imageUrl
//{
//    //GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
//    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    NSString *Afunction=[[NSString alloc]initWithString:Image_MethodName];
//	MethoodName=Afunction;
//    
//	NSString *urlString = @"http://carpark-management.co.uk/mobile-app/users/imageUploadWithPcn";
////    NSString *urlString = @"http://122.160.205.84/iticket/users/imageUploadWithPcn";
//    
//	NSURL *aUrl=[[NSURL alloc]initWithString:urlString];
//	ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:aUrl] autorelease];
//    request.shouldAttemptPersistentConnection = NO;
////    [request setPostValue:GDP.kUserID forKey:@"UserID"];
////    [request setPostValue:GDP.PCN forKey:@"PCN"];
//    
//	[request setDidFailSelector:@selector(dataDownloadFail:)];
//
//    [request setDidFinishSelector:@selector(dataDidFinishDowloading:)];
//    [request setDelegate:self];
//    [request setFile:imageUrl forKey:@"img"];
//    [request setPersistentConnectionTimeoutSeconds:1800.0];
//    [request startAsynchronous];
//
//    [Afunction release];
//    [aUrl release];
//}
/*-(void)ASICallSyncToServerWithUrl:(NSString *)urlString FunctionName:(NSString*)FunctionName
{	
    if ([AppDelegate checkNetwork])
    {
        [self retain];
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

            MethoodName=FunctionName;
            NSURL *aUrl=[[[NSURL alloc]initWithString:urlString]autorelease];
            
            ASIFormDataRequest *anASIReq = [ASIFormDataRequest requestWithURL:aUrl];
            anASIReq.delegate = self;
            anASIReq.didFailSelector = @selector(dataDownloadFail:);
            anASIReq.didFinishSelector = @selector(dataDidFinishDowloading:);
            anASIReq.requestMethod = @"POST";
            [anASIReq startAsynchronous];
        }
        
    }
    else
    {
        [SVProgressHUD dismiss];
    }
}*/

-(void)ASICallSyncToServerWithFunctionName:(NSString *)FunctionName getDataDictonery :(NSMutableDictionary *)Dictionery
{
    
    
    [self retain];
    NSString *JsonString=nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Dictionery
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        JsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSLog(@"FunctionName-->> %@",FunctionName);
        NSLog(@"requestjson-->> %@",JsonString);
        
        MethoodName=FunctionName;
        NSString *urlString = [NSString stringWithFormat:@"%@",BASE_URL_STRING];
        NSLog(@"ServerAdd-->> %@",BASE_URL_STRING);
        NSURL *aUrl=[[[NSURL alloc]initWithString:urlString]autorelease];
        
        ASIFormDataRequest *anASIReq = [ASIFormDataRequest requestWithURL:aUrl];
        
//        anASIReq.methodName=FunctionName;

        
               NSLog(@"Json Data %@",JsonString);
        
        if([[Dictionery allKeys]containsObject:@"file"])
        {
            NSString *imagePath = [Dictionery objectForKey:@"file"];
            
            NSLog(@"%@",[Dictionery objectForKey:@"file"]);
            if ([imagePath stringByTrimmingCharactersInSet:whiteCharacterSet].length)
            {
                NSString *fileNAme = [NSString stringWithFormat:@"%@",[[imagePath componentsSeparatedByString:@"/"] lastObject]];
                
                
                [anASIReq setFile:[NSData dataWithContentsOfFile:imagePath] withFileName:fileNAme andContentType:@"Image/" forKey:[NSString stringWithFormat:@"file"]];
                
                
                
                
                
                NSLog(@"%@",imagePath);
                
                //  [anASIReq setFile:imagePath forKey:@"image1"];
            }
        }
        
        [anASIReq setPostValue:FunctionName forKey:@"action"];
        [anASIReq setPostValue:JsonString forKey:@"jsAxon"];
        
        anASIReq.delegate = self;
        anASIReq.didFailSelector = @selector(dataDownloadFail:);
        anASIReq.didFinishSelector = @selector(dataDidFinishDowloading:);
        anASIReq.requestMethod = @"POST";
        
        [JsonString release];
        [anASIReq startAsynchronous];
    }
    
    
}
-(void)ASICallSyncToServerWithFunctionName:(NSString *)FunctionName PostDataDictonery :(NSMutableDictionary *)postParams
{
    
//if ([AppDelegate checkNetwork])
       // {
            [self retain];
//            NSString *JsonString=nil;
//            NSError *error;
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Dictionery
//            options:NSJSONWritingPrettyPrinted
//            error:&error];
    
//            if (! jsonData) {
//                NSLog(@"Got an error: %@", error);
//                } else {
//                 JsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                    
                 NSLog(@"FunctionName-->> %@",FunctionName);
//                 NSLog(@"requestjson-->> %@",JsonString);
                    
                 MethoodName=FunctionName;
                 NSString *urlString = [NSString stringWithFormat:@"%@%@",BASE_URL_STRING,FunctionName];
                 NSLog(@"ServerAdd-->> %@",BASE_URL_STRING);
                 NSURL *aUrl=[[[NSURL alloc]initWithString:urlString]autorelease];
                    
                 ASIFormDataRequest *anASIReq = [ASIFormDataRequest requestWithURL:aUrl];
                    
//                 anASIReq.methodName=FunctionName;
                    
                    
                    
                    
//                    NSLog(@"Json Data %@",JsonString);
                    
                    [anASIReq setPostValue:FunctionName forKey:@"action"];
//                    [anASIReq setPostValue:JsonString forKey:([FunctionName isEqualToString:Reg_MethodName]?@"User":@"json")];
    
    if (postParams != nil) {
        for (NSString *key in [postParams allKeys]) {
            [anASIReq setPostValue:[postParams objectForKey:key] forKey:key];
        }
    }

    
                    anASIReq.delegate = self;
                    anASIReq.didFailSelector = @selector(dataDownloadFail:);
                    anASIReq.didFinishSelector = @selector(dataDidFinishDowloading:);
                    anASIReq.requestMethod = @"POST";
                    
//                    [JsonString release];
                    [anASIReq startAsynchronous];
//                    }
            
//}
   // else
      //  {
       //     [SVProgressHUD dismiss];
//zs}
}




-(void)ASICallSyncToServerWithFunctionName:(NSString *)FunctionName
{/*
    if ([AppDelegate checkNetwork])
    {
        NSString *urlString = [NSString stringWithFormat:@"%@",ServerAdd1];
        NSLog(@"ServerAdd-->> %@",ServerAdd1);
        NSURL *aUrl=[[[NSURL alloc]initWithString:urlString]autorelease];

        ASIFormDataRequest *anASIReq = [ASIFormDataRequest requestWithURL:aUrl];
        
       
        anASIReq.delegate = self;
        anASIReq.didFailSelector = @selector(dataDownloadFail:);
        anASIReq.didFinishSelector = @selector(dataDidFinishDowloading:);
        anASIReq.requestMethod = @"GET";
        
        
        [anASIReq startAsynchronous];

        
    }*/
}



#pragma mark- ALServiceInvoker Delegate
#pragma mark-

- (void)serviceInvokerRequestFailed:(ASIFormDataRequest *)request
{
    // ****** Hide activity Indicator ******** //
    
    [SVProgressHUD dismiss];
    NSLog(@"DATA DOWNLOAD Error--%@",request.error);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if([aCaller respondsToSelector:@selector(dataDownloadFail:withMethood:)])
    {
        [aCaller dataDownloadFail:request withMethood:request.url.path];
        NSLog(@"DATA DOWNLOAD Error--%@",request.error);
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Jackpot Vacantion" message:[NSString stringWithFormat:@"%@",request.error] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        alert.delegate=self;
//        [alert show];
    }

}

- (void)serviceInvokerRequestFinished:(ASIFormDataRequest *)request
{
    // ****** Hide activity Indicator ******** //
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [SVProgressHUD dismiss];
    
//    NSError *error = nil;
//    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:&error];
    
    
    NSString *string=[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",string);
    
    [self.aCaller dataDidFinishDowloading:request withMethood:MethoodName withOBJ:self];
    
    //    if([aReq.methodName isEqualToString:Login_MethodName])
    //    {
    //
    //            [self.aCaller dataDidFinishDowloading:aReq withMethood:MethoodName withOBJ:self];
    //    }
    //   else if([aReq.methodName isEqualToString:Reg_MethodName])
    //    {
    //
    //
    //    }
    
    [aCaller release];
    aCaller = nil;
    
}

/*
#pragma mark - Response Methods
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq
{
    
    NSLog(@"Successful");
    
//    [self navigateWithData:aReq];
    

}
-(void) dataDownloadFail:(ASIHTTPRequest*)aReq
{
    [SVProgressHUD dismiss];
     NSLog(@"DATA DOWNLOAD Error--%@",aReq.error);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if([aCaller respondsToSelector:@selector(dataDownloadFail:withMethood:)])
    {
        [aCaller dataDownloadFail:aReq withMethood:aReq.url.path];
        NSLog(@"DATA DOWNLOAD Error--%@",aReq.error);
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Jackpot Vacantion" message:[NSString stringWithFormat:@"%@",aReq.error] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.delegate=self;
        [alert show];
    }
}

#pragma mark - Navigation methods
- (void)navigateWithData:(ASIHTTPRequest*)aReq
{
    
    
}
*/
-(void)removeWebComm:(WebCommunicationClass*)webComm
{
    @try {
        if (webComm) {
            
            [webComm setACaller:nil];
            [webComm release];
            webComm = nil;
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception : %@ %s",exception.description,__PRETTY_FUNCTION__);
    }
    @finally {
        
    }
    
}

@end
