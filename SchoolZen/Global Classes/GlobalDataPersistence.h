//
//  GlobalDataPersistence.h
//  FingerOlympic
//
//  Created by RahulSharma on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginResponse.h"
#import "ParentDashBoard.h"

@interface GlobalDataPersistence : NSObject
{
    
}
@property (nonatomic, strong) NSString *role_id;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *secret_key;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *pincode;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *state_id;
@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, strong) NSString *school_id;
@property (nonatomic, strong) NSString *class_id;
@property (nonatomic, strong) NSString *section_id;
@property (nonatomic, strong) NSString *dob;

@property (nonatomic, strong) NSString *child_role_id;
@property (nonatomic, strong) NSString *parent_profile_id;

@property (nonatomic, strong) NSString *current_profile_id;
@property (nonatomic, strong) NSString *romNumber;
@property (nonatomic, strong) NSString *tagParent;
@property (nonatomic, strong) NSString *tagName;

/*************** NEED TO TAKE THESE VARIABLE DUE TO MAINTAIN THE LOGIN OF OPTION VIEW AS PER OLD DASHBOARD *********************/
@property (nonatomic, assign) NSInteger tagForWall;
@property (nonatomic, assign) NSInteger tagForDashboard;
@property (nonatomic, assign) NSInteger publisher_role_id;
@property (nonatomic, strong) NSString *selectedOption;
@property (nonatomic, strong) NSDictionary *selectedUserInfo;
/***************************/

@property (nonatomic, strong) LoginResponse *loginInfo;
@property (nonatomic, retain) ParentDashBoard *parentDashBoard;


@property(strong, nonatomic)NSMutableArray *arrCategories;
@property (nonatomic, strong) NSString *categoryId;

@property (nonatomic, strong) NSString *board_id;


@property (nonatomic, strong) NSString *event_user_id;
@property (nonatomic, strong) NSString *event_contact_person;
@property (nonatomic, strong) NSString *event_loaction;
@property (nonatomic, strong) NSString *event_userimage;

@property (nonatomic, strong) NSString *event_first_name;
@property (nonatomic, strong) NSString *event_last_name;
@property (nonatomic, strong) NSString *event_company_name;
@property (nonatomic, strong) NSString *event_email;
@property (nonatomic, strong) NSString *event_event_user_type_id;
@property (nonatomic, strong) NSString *event_address;
@property (nonatomic, strong) NSString *event_zipcode;
@property (nonatomic, strong) NSString *event_contact_number;
@property (nonatomic, strong) NSString *event_website;
@property (nonatomic, strong) NSString *event_area_name;
@property (nonatomic, strong) NSString *event_area_id;
@property (nonatomic, strong) NSString *event_other_area;
@property (nonatomic, strong) NSString *event_state_id;
@property (nonatomic, strong) NSString *event_state_name;
@property (nonatomic, strong) NSString *event_city_id;
@property (nonatomic, strong) NSString *event_city_name;


/** The user latitude. */
@property (nonatomic, strong) NSString *userLatitude;

/** The user longitude. */
@property (nonatomic, strong) NSString *userLongitude;

@property (nonatomic, strong) NSString *currentCity;


@property (nonatomic , retain) NSMutableDictionary *dictLoginResponse;

+ (GlobalDataPersistence *)sharedGlobalDataPersistence;
+ (void)resetGlobalDataPersistence;

@end
