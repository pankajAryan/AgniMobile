//
//  FFZoomImageCollectionView.m
//  FabFurnish
//
//  Created by Amit Kumar on 19/06/15.
//  Copyright (c) 2015 Bluerock eServices Pvt Ltd. All rights reserved.
//

#import "FFZoomImageCollectionView.h"
#import "FFZoomImageCollectionCell.h"

@interface FFZoomImageCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *arrayDataSource;
}

@end

@implementation FFZoomImageCollectionView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithDataSource:(NSArray*)arraySource andSelectedIndex:(NSInteger)selectedIndex{
    
    self = (FFZoomImageCollectionView *)[[[NSBundle mainBundle] loadNibNamed:@"ZoomImageCollectionView" owner:nil options:nil]firstObject];
    if (self) {
        [self registerNib:[UINib nibWithNibName:@"ZoomImageCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"FFZoomImageCollectionCell"];

        self.frame = [[UIScreen mainScreen] bounds];
        arrayDataSource = arraySource;
        self.delegate = self;
        self.dataSource = self;
        [self reloadData];
        
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    return self;
}

#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrayDataSource.count;
}

- (FFZoomImageCollectionCell *)collectionView:(FFZoomImageCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    FFZoomImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FFZoomImageCollectionCell" forIndexPath:indexPath];
    if (!cell)
    {
        cell = (FFZoomImageCollectionCell*)[[[NSBundle mainBundle] loadNibNamed:@"ZoomImageCollectionCell" owner:self options:nil] firstObject];
    }
    [cell configureCell:[arrayDataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.bounds.size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self removeFromSuperview];
}
- (IBAction)removeCollectionViewOnTap:(id)sender {
    [self removeFromSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    CGFloat pageWidth = imgsCollectionView.frame.size.width;
    //    pageControl.currentPage = (imgsCollectionView.contentOffset.x + pageWidth / 2) / pageWidth;
}


@end
