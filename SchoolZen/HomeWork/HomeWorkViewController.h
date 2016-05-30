//
//  HomeWorkViewController.h
//  SchoolZen
//
//  Created by Jatin on 8/19/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
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

    NSInteger selectedClassIndex;
    NSInteger selectedSectionIndex;
    NSInteger selectedSubjectIndex;

}

-(IBAction)Btn_Common:(id)sender;
- (IBAction)Click_HomeProceed:(id)sender;
- (IBAction)Click_Back:(id)sender;
@property(nonatomic,strong)NSString *strHomeClassName;
@property(nonatomic,strong)NSString *strHomeSectionName;



@end
