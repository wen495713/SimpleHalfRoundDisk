//
//  HalfRoundDisk.h
//  SimpleHalfRoundDisk
//
//  Created by 慢吞吞 on 12-8-28.
//  Copyright (c) 2012年 Teamnet. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HalfRoundDiskDelegate;
@interface HalfRoundDisk : UIView<UIScrollViewDelegate>{
    UIScrollView *scrollView;
    CGAffineTransform orginalTransform;
}
@property (nonatomic, assign) id<HalfRoundDiskDelegate>delegate;
@property (nonatomic, retain) NSArray *objects;


@end
@protocol HalfRoundDiskDelegate <NSObject>
@optional
- (void)halfroundDisk:(HalfRoundDisk *)disk didPressButtonWithIndex:(NSInteger)index;
- (void)halfroundDisk:(HalfRoundDisk *)disk didEndAnimationOnButtonWithIndex:(NSInteger)index;
@end