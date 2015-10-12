//
//  TeacherSendHomeViewController.h
//  SchoolZen
//
//  Created by Jatin on 8/15/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherSendHomeViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    IBOutlet UIButton *btn_Class;
    
    IBOutlet UIButton *btn_Section;
    IBOutlet UIView *vwPicker;
    IBOutlet UIPickerView *teacherPicker;
}
-(IBAction)Click_BAck:(id)sender;

- (IBAction)Click_Proceed:(id)sender;
- (IBAction)Click_Class:(id)sender;
- (IBAction)Click_Section:(id)sender;
@end
