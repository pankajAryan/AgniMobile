//
//  CalenderNewViewController.m
//  SchoolZen
//
//  Created by Jatin on 8/29/15.
//  Copyright (c) 2015 Mobiquel. All rights reserved.
//

#import "CalenderNewViewController.h"
#import "CalenderCollectionViewCell.h"
#import "CalendarViewController.h"

@interface CalenderNewViewController ()
{
    CalendarViewController *parentController;

}

@end

@implementation CalenderNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrMonth=[[NSArray alloc] initWithObjects:@"Jan",@"Feb", @"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec",nil];
    
    
    [self.DashBoardCollection registerNib:[UINib nibWithNibName:@"CalenderCollectionViewCell" bundle:[NSBundle mainBundle]]
               forCellWithReuseIdentifier:@"CalenderCollectionViewCell"];
    [self.DashBoardCollection setShowsHorizontalScrollIndicator:NO];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 ;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CalenderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalenderCollectionViewCell" forIndexPath:indexPath];
    cell.lblMonth.text=[arrMonth objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100,100);
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

        NSIndexPath *path = indexPath;
        NSInteger theInteger = path.row;
    
    parentController = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
     parentController.strMonthIndex=[NSString stringWithFormat:@"%d",theInteger+1];
    parentController.strCat=@"Calendar";
    CGRect rect = parentController.view.frame;
    rect.origin.y = 64;
    parentController.view.frame = rect;
   
    //   [self.view addSubview:parentController.view];
    [self.navigationController pushViewController:parentController animated:YES];
    
}
-(IBAction)Click_Back:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
