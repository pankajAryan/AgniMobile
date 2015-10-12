//
//  DropDownTableView.h
//
//  Created by Rahul Sharma on 15/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Constant.h"

@protocol DropDownTableDelegate;

@interface Constant : NSObject

typedef enum
{
    UserProfile=1,
    PostNotification,
    Like,
    Dislike,
    ManageGroup,
    AddFriend,
    Themes,
    
}UserAction;

typedef enum
{
	kTableViewDirectionDown =0,
	kTableViewDirectionUp ,
	
}TableViewShowDirection;


@end
@interface DropDownTableView : UIView <UITableViewDelegate, UITableViewDataSource>{
	id				target;
@private
	UITableView*	tblvDropDown;
	NSArray*		arrDataSource;
	NSInteger		selectedDropDownIndex;
	NSIndexPath*	indexPathPreviousSelected;	
}

@property (nonatomic, assign) id <DropDownTableDelegate,NSObject> target;
@property (nonatomic, copy) NSArray *arrDataSource;
- (id)initWithDelegate:(id)caller dataSource:(NSArray*)array frame:(CGRect)frame;
- (void)animateTableview:(TableViewShowDirection)direction atPoint:(CGPoint)point;
@end

@protocol DropDownTableDelegate

@required
-(void)didSelectRow:(NSInteger)index inDataSource:(NSArray*)dataSource;
@end
