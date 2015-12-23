
#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "SVProgressHUD.h"
#import "ALServiceInvoker.h"
//#import "NSString+URLEncoding.h"

@class UserInfo;
@class AppDelegate;

@interface WebCommunicationClass : NSObject <ALServiceInvokerDelegate> {

	AppDelegate *AnAppDelegatObj;
		id aCaller;
	
}
@property(nonatomic,strong)NSString *MethoodName;
;
@property(nonatomic,retain)	id aCaller;
@property(nonatomic,assign)	BOOL isCancelAllRequest;
-(void)loginUserName:(NSString*)username  withpassword:(NSString*)password UserType:(NSString*)usertype;

-(void)Get_PlannedHoliday:(NSString *)getPlannedHolidays month:(NSString*)month;
-(void)GetgetUnPlannedHolidays:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection month:(NSString*)month;


-(void)Get_commonCircular:(NSString *)schoolId;
-(void)GetCircular:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection;

-(void)getTimetable:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection;

-(void)Get_commonfeedback:(NSString *)schoolId;
-(void)Getfeedback:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection childId:(NSString*)childId;

-(void)Get_commonMedia:(NSString *)schoolId;
-(void)Getmedia:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection;

-(void)Get_Contact:(NSString *)schoolId;

-(void)Get_About:(NSString *)schoolId;

-(void)AddFeedback:(NSString *)schoolId parentId:(NSString *)parentId title:(NSString *)tile message:(NSString*)msg;

-(void)GetHomeWork:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection;

-(void)forgotPassword:(NSString*)EmailID;
-(void)updateProfile:(NSString*)userId userType:(NSString*)userType userName:(NSString*)userName userEmail:(NSString*)userEmail userMobile:(NSString*)userMobile newPassword:(NSString*)loginPass;

-(void)GetStaffClassSectionSubjectStructure:(NSString*)schoolId staffId:(NSString*)staffId;

-(void)GetStudentsOfClass:(NSString*)schoolId classId:(NSString*)classId sectionId:(NSString*)sectionId;

-(void)AddFeedbackTeacher:(NSString*)schoolId staffId:(NSString*)staffId message:(NSString*)message classId:(NSString*)classId sectionId:(NSString*)sectionId childIds:(NSString*)childIds;

-(void)PutFileUpload:(NSData*)file;

-(void)addHomework:(NSString*)schoolId staffId:(NSString*)staffId title:(NSString*)title message:(NSString*)message classId:(NSString*)classId
attachmentURL:(NSString*)attachmentURL sectionId:(NSString*)sectionId subjectId:(NSString*)subjectId;


-(void)ForgotPassword:(NSString *)email :(NSString*)userType;

-(void)addMsg:(NSString*)schoolId staffId:(NSString*)staffId title:(NSString*)title message:(NSString*)message classId:(NSString*)classId attachmentURL:(NSString*)attachmentURL sectionId:(NSString*)sectionId;

-(void)GetMessage:(NSString*)schoolId childclass:(NSString*)childClass childsetion:(NSString*)childSection;

-(void)getTicker:(NSString*)schoolId;

+ (NSString *)urlEncodeValue:(NSString *)str;
+ (NSString *)urlDecodeValue:(NSString *)str;
-(void)ASICallSyncToServerWithUrl:(NSString *)urlString FunctionName:(NSString*)FunctionName;
-(void) dataDownloadFail:(ASIHTTPRequest*)aReq;
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq;
//-(NSDictionary * )getUTCFormateDate:(NSString *)aDate:(NSString *)aTimeStr;
@end




@protocol WebCommunicationClassDelegate

-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj;
-(void) dataDownloadFail:(ASIHTTPRequest*)aReq  withMethood:(NSString *)MethoodName;



@end
