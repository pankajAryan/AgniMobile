//
//  SendFeedbackViewController.h
//  SchoolZen
//
//  Created by Jatin on 8/18/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendFeedbackViewController : UIViewController<UITableViewDataSource,UITableViewDataSource>
{
    NSMutableArray *obj_student;
    IBOutlet UITableView *tblSendFeedBack;
    
    IBOutlet UITextView *txtPostMessage;
    NSMutableArray *arrSelected;
    

}
-(IBAction)Click_Back:(id)sender;
- (IBAction)Click_Save:(id)sender;
@property(nonatomic,strong)NSString *strClassId;
@property(nonatomic,strong)NSString *strSectionId;

@property(strong,nonatomic)IBOutlet UIImageView *imgHeading;


@end
