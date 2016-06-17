
#import "ALServiceInvoker.h"
#import "ALUtilityClass.h"
#import "Config.h"
//#import "RSA.h"
#import "PBEWithMD5AndDES.h"
//#import "SecurityUtility.h"
#import "GlobalDataPersistence.h"

@implementation ALServiceInvoker

@synthesize delegate = _delegate;

NSString *encryptKey = @"@GE#r4ws6xLBJmx8fB-3";

#pragma mark - Singleton Class Method
 
+ (ALServiceInvoker*)sharedInstance {
	static ALServiceInvoker* instance = nil;
	
	@synchronized(self) {
		if(instance == nil) {
			instance = [[self alloc] init];
		}
	}
	return(instance);
}

- (void)cancelRequest {
    if (request) {
        [request clearDelegatesAndCancel];
    }
}

#pragma mark - USER_API Request Methods

- (void)serviceInvokerRequestWithParams:(NSDictionary *)postParams requestAPI:(NSString *)stringURL reqTag:(NSInteger)tag delegate:(id<ALServiceInvokerDelegate>)delegate {

    @try {
        
        self.delegate = delegate;
        
        if ([ALUtilityClass isNetworkAvailable])
        {
            // ********* Initialise Request ******** //
            NSURL *url = [NSURL URLWithString:[BASE_URL_STRING stringByAppendingString:stringURL]];
            
            NSLog(@"API URL = %@",url.absoluteString);
            
            ASIFormDataRequest *apiRequest = [[ASIFormDataRequest alloc]initWithURL:url];
            apiRequest.tag = tag;
            
            request = apiRequest;
            
            if (postParams != nil)
            {
                for (NSString *key in postParams)
                {
                    [request addPostValue:[postParams objectForKey:key] forKey:key];
                    
                    if ([key isEqualToString:@"file"]) {
                        [request addData:[postParams objectForKey:key] withFileName:@"image.jpg" andContentType:@"image/jpeg" forKey:@"file"];
                    }
                }
            }
            
            //[request addPostValue:[ALUtilityClass getDeviceIdentifier] forKey:@"deviceId"];
            GlobalDataPersistence *obj_global=[GlobalDataPersistence sharedGlobalDataPersistence];

            NSString *username = [ALUtilityClass RetrieveDataFromUserDefault:@"mob"];
            NSString *password = [ALUtilityClass RetrieveDataFromUserDefault:@"pass"];
            
            NSString* encrypted_username = [PBEWithMD5AndDES encrypt:username KEY:encryptKey];
            NSString* encrypted_password = [PBEWithMD5AndDES encrypt:password KEY:encryptKey];
            
            [request addPostValue:encrypted_username forKey:@"mobile"];
            [request addPostValue:encrypted_password forKey:@"password"];
            
            [request addPostValue:obj_global.strUserType forKey:@"userType"];

            NSLog(@"API Request Params = %@",postParams);

            
            __weak typeof(request) weakRequest = request;
            
           // __weak typeof(_delegate) weakDelegate = _delegate;

            
            [request setCompletionBlock:^{
                
                __strong typeof(request) strongRequest = weakRequest;
                
                switch(strongRequest.responseStatusCode)
                {
                    case 200:
                    {
                        if ([strongRequest.url.path isEqualToString:@"/SchoolApp/rest/service/uploadHomeworkAttachment"]) {
                            
                            if([_delegate respondsToSelector:@selector(serviceInvokerRequestFinished:)]){
                                [_delegate performSelector:@selector(serviceInvokerRequestFinished:) withObject:strongRequest];
                            }
                            
                            return;
                        }
                        
                        NSError *error = nil;
                        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:strongRequest.responseData options:NSJSONReadingMutableLeaves error:&error];
                        
                        NSLog(@"API response = %@",responseDict);
                        
                        if (error == nil && responseDict != nil)
                        {
                            if ([[[responseDict objectForKey:@"errorCode"] stringValue] isEqualToString:@"0"])
                            {
                                if([_delegate respondsToSelector:@selector(serviceInvokerRequestFinished:)]){
                                    [_delegate performSelector:@selector(serviceInvokerRequestFinished:) withObject:strongRequest];
                                }
                            }
                            else
                            {
                                
                                if([_delegate respondsToSelector:@selector(serviceInvokerRequestFailed:)]) {
                                    [_delegate serviceInvokerRequestFailed:strongRequest];
                                }
                                
                                if (strongRequest.tag != 41) // ie. not ticker api response.
                                {
                                    [ALUtilityClass showAlertwithTitle:@"Error" message:[responseDict objectForKey:@"errorMessage"]];
                                }
                                
                            }
                        }
                        else
                        { // Error scenarios covered.
                            
                            //if (error != nil)
//                                [ALUtilityClass showAlertwithTitle:@"Error" message:@"Unfortunately We are unable to serve your request, Please try again later."];
                            // [ALUtilityClass showAlertwithTitle:@"Error" message:@"Unfortunately server connection failed, Please try again."];
                            
                            if([_delegate respondsToSelector:@selector(serviceInvokerRequestFailed:)]) {
                                [_delegate serviceInvokerRequestFailed:strongRequest];
                            }
                        }
                        
                        break;
                    }
                        
                    default:
                    {
                        NSLog(@"failed: server error code: %i",strongRequest.responseStatusCode);
                        
                        [ALUtilityClass showAlertwithTitle:@"Error" message:@"Unfortunately We are unable to serve your request, Please try again later."];
                        
                        if([_delegate respondsToSelector:@selector(serviceInvokerRequestFailed:)]) {
                            [_delegate serviceInvokerRequestFailed:strongRequest];
                        }
                        
                        break;
                    }
                }
                
                //nslog(@"API service Response: %@",strongRequest.responseString);
            }];
            
            
            [request setFailedBlock:^{ // Some error b/w the server-client communication
                
                __strong typeof(request) strongRequest = weakRequest;
                
                if([_delegate respondsToSelector:@selector(serviceInvokerRequestFailed:)]) {
                    [_delegate serviceInvokerRequestFailed:strongRequest];
                }
                
                [ALUtilityClass showAlertwithTitle:@"Error" message:[[[strongRequest.error userInfo] objectForKey:NSUnderlyingErrorKey] localizedDescription]];
            
            }];
            
            request.timeOutSeconds = 120;
            [request setShouldAttemptPersistentConnection:NO];
            [request startAsynchronous];
        }
        else { // Show alert for Data connectivity failure.
            [ALUtilityClass showAlertwithTitle:@"Network Connectivity Error!" message:@"Please check your network connection and try again."];
            if([_delegate respondsToSelector:@selector(serviceInvokerRequestFailed:)]) {
                [_delegate serviceInvokerRequestFailed:nil];
            }
        }
    }
    @catch (NSException *exception) {
        //nslog(@"exception catch : %@",exception.description);
    }
    @finally {
        
    }
}



@end
