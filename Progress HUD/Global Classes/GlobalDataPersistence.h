//
//  GlobalDataPersistence.h
//  FingerOlympic
//
//  Created by RahulSharma on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalDataPersistence : NSObject
{
    
}
@property(nonatomic,strong)NSMutableDictionary *dictUserInfo;
@property(nonatomic,strong)NSDictionary *dictCal;
@property(nonatomic,strong)NSArray *arrChild;
@property(nonatomic,strong)NSArray *arrTable;
@property(nonatomic,strong)NSArray *arrPlan;
@property(nonatomic,strong)NSString *strUserType;
@property(nonatomic,strong)NSArray *arrTeacher;


+ (GlobalDataPersistence *)sharedGlobalDataPersistence;
+ (void)resetGlobalDataPersistence;

@end
