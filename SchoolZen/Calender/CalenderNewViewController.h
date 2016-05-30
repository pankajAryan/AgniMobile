//
//  CalenderNewViewController.h
//  SchoolZen
//
//  Created by Jatin on 8/29/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderNewViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *arrMonth;
}
@property (nonatomic, strong) IBOutlet UICollectionView *DashBoardCollection;

@end
