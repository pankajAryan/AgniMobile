//
//  TeacherFeedbackViewController.h
//  SchoolZen
//
//  Created by Jatin on 8/4/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendMessage : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    IBOutlet UIButton *btn_Class;

    IBOutlet UIButton *btn_Section;
    IBOutlet UIView *vwPicker;
    IBOutlet UIPickerView *teacherPicker;
    
    NSString *strBtnSelection;
    NSMutableArray *arrMain;
    NSMutableArray *arrClassSection;

}

-(IBAction)Click_BAck:(id)sender;

- (IBAction)Click_Proceed:(id)sender;
- (IBAction)Click_Class:(id)sender;

@end
