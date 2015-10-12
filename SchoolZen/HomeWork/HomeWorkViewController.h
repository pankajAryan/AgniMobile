//
//  HomeWorkViewController.h
//  SchoolZen
//
//  Created by Jatin on 8/19/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeWorkViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UIView *vwHomeWorkPicker;
    IBOutlet UIPickerView *pickerHomeWork;
    IBOutlet UIButton *btnClass;
    
    IBOutlet UIButton *btnSection;

    IBOutlet UIButton *btn_Subject;
    
    NSMutableArray *arrClassSection;
    NSMutableArray *arrMain;
    NSString *strBtnSelection;

    
}
-(IBAction)Btn_Common:(id)sender;
- (IBAction)Click_HomeProceed:(id)sender;
- (IBAction)Click_Back:(id)sender;
@property(nonatomic,assign)NSString *strHomeClassName;
@property(nonatomic,assign)NSString *strHomeSectionName;



@end
