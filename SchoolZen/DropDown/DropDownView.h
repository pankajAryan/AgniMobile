//
//  DropDownView.h
//
//  Created by Rahul Sharma on 06/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol DropDownDelegate;
@class DropdownContainer;
@interface DropDownView : UIView <UITableViewDelegate , UITableViewDataSource>{
	id<DropDownDelegate> target;
	NSArray *myDataarray;
	int selectedIndex; //-1 if no data array is available
	DropdownContainer *myContainerView;
	
	
	UILabel* myLabel;
	
}

- (id)initWithFrame:(CGRect)frame target:(id)caller;
@property (nonatomic,retain)   UITableView *myTableView;
@property (nonatomic,retain)   UILabel* myLabel;
@property (nonatomic,retain)   NSString* strDropDownValue;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, assign) int tagValue;
@property (nonatomic, copy) NSArray *myDataarray;
@property (nonatomic, copy) NSArray *arrKeys;
@property (nonatomic, assign) IBOutlet id<DropDownDelegate> target;

-(void)setDataArray:(NSArray*)dataArray;
-(void)openDropDown;
@end


//The Following delegate method provide the caller class with the Row index that is selected 
//along with the data Source for which this particular class was configured
@protocol DropDownDelegate <NSObject>

@required

-(void)didSelectIndex:(int)index ForDropDown:(DropDownView*)dropdown;

@end

@interface DropdownContainer : UIView 
{
	id delegate;
}
@property (nonatomic, assign) id delegate;
@end