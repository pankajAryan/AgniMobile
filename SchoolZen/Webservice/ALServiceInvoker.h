//

#import <Foundation/Foundation.h>
//#import "ALConfigration.h"
//#import "ALUtilityClass.h"
#import "ASIFormDataRequest.h"
//#import "ASIHTTPRequest.h"

@protocol ALServiceInvokerDelegate <NSObject>

@optional

-(void)serviceInvokerRequestFinished:(ASIFormDataRequest *)request;
-(void)serviceInvokerRequestFailed:(ASIFormDataRequest *)request;

@end



@interface ALServiceInvoker : NSObject
{
@private
	id <ALServiceInvokerDelegate> __unsafe_unretained _delegate;
    
    ASIFormDataRequest *request;
}

@property(unsafe_unretained,nonatomic) id<ALServiceInvokerDelegate> __unsafe_unretained delegate;

+ (ALServiceInvoker*)sharedInstance; // To get instance of service invoker Singleton class

#pragma mark- API service calling Methods

- (void)serviceInvokerRequestWithParams:(NSDictionary*)postParams requestAPI:(NSString*)stringURL reqTag:(NSInteger)tag delegate:(id<ALServiceInvokerDelegate>)delegate;

- (void)cancelRequest;

@end
