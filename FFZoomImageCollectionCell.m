//
//  FFZoomImageCollectionCell.m
//  FabFurnish
//
//  Created by Amit Kumar on 19/06/15.
//  Copyright (c) 2015 Bluerock eServices Pvt Ltd. All rights reserved.
//

#import "FFZoomImageCollectionCell.h"
#import "EGOImageView.h"

@interface FFZoomImageCollectionCell ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet EGOImageView *imageView;

@end

@implementation FFZoomImageCollectionCell

-(void)awakeFromNib{
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 4.0;
    self.scrollView.delegate = self;
}

-(void)configureCell:(id)imageData
{
    self.scrollView.zoomScale = 1.0;
    
    if ([imageData isKindOfClass:[NSString class]]) {
        [self.imageView setImageURL:[NSURL URLWithString:imageData]];// setImageWithURL:[NSURL URLWithString:imageData] placeholderImage:[UIImage ffplaceHolderWhiteBackground]];
    }
 
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


@end
