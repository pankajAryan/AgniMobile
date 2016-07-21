
/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//************************************END********************************************



#define KALERT(TITLE,MSG,DELEGATE) [[UIAlertView alloc]initWithTitle:TITLE message:MSG delegate:DELEGATE cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]

#define KALERT_YN(TITLE,MSG,DELEGATE) [[UIAlertView alloc]initWithTitle:TITLE message:MSG delegate:DELEGATE cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil]

//#define AppDelegate (AppDelegate*)[UIApplication sharedApplication].delegate

//#define APP_ManageObject ((AppDelegate*)iTicket_AppDelegate).managedObjectContext

#define whiteCharacterSet [NSCharacterSet whitespaceAndNewlineCharacterSet]


#define KApplicationName @"TIA Dubai"


//#define BASE_URL_STRING @"http://128.199.129.241:8080/SchoolApp/rest/service/"

#define BASE_URL_STRING @"http://agnitioworld.com:8080/SchoolApp/rest/service/"

// 128.199.129.241
// agnitioworld.com

#define IS_IPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


#define kAPNS_WEBSERVICE @"registerPushNotificationId"
#define Login_MethodName @"login"

#define API_GET_TICKER @"getTicker"


#define kgetPlannedHolidays @"getPlannedHolidays"
#define kgetUnPlannedHolidays @"getUnPlannedHolidays"

#define kgetCircularForChild @"getCircularForChild"
#define KgetCommonCircular @"getCommonCircular"

#define kgetFeedbackForChild @"getFeedbackForChild"
#define kgetCommonFeedback @"getCommonFeedback"

#define KgetTimeTable @"getTimeTable"

#define kgetMediaForChild @"getMediaForChild"
#define kgetCommonMedia @"getCommonMedia"

#define kaddFeedbackForSchool    @"addFeedbackForSchool"
#define kgetContact @"getContact"

#define kgetAbout @"getAbout"

#define Kgethomework @"getHomeWork"

#define KupdateUser @"updateUser" 

#define kgetStaffClassSectionSubjectStructure @"getStaffClassSectionSubjectStructure"

#define kgetStudentsOfClass @"getStudentsOfClass"
#define KteacherFeedback @"addFeedback"
#define KfileUpload @"uploadHomeworkAttachment"
#define kaddHomework @"addHomework"

#define kisuserselection @"userSelection"
#define KforgotPassword @"forgotPassword"
#define KaddMessage @"addMessage"
#define KgetMessages @"getMessages"
