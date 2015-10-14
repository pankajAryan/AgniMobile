//
//  FFZoomImageCollectionView.h
//  FabFurnish
//
//  Created by Amit Kumar on 19/06/15.
//  Copyright (c) 2015 Bluerock eServices Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFZoomImageCollectionView : UICollectionView
-(instancetype)initWithDataSource:(NSArray*)arraySource andSelectedIndex:(NSInteger)selectedIndex;

@end
