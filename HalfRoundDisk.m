//
//  HalfRoundDisk.m
//  SimpleHalfRoundDisk
//
//  Created by 慢吞吞 on 12-8-28.
//  Copyright (c) 2012年 Teamnet. All rights reserved.
//

#import "HalfRoundDisk.h"

@implementation HalfRoundDisk
@synthesize objects,delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.decelerationRate = 0.9;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:scrollView];
        [scrollView release];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    NSInteger num = [objects count];
    if (num>0) {
        for (int i=0; i<num; i++) {
            UIButton *btnObject = (UIButton *)[objects objectAtIndex:i];
            btnObject.tag = i;
            [btnObject addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            CGRect btnRct = btnObject.frame;
            btnRct.origin.x = scrollView.frame.size.width - btnObject.frame.size.width;
            btnRct.origin.y = i*btnObject.frame.size.height+self.frame.size.height/2;
            btnObject.frame = btnRct;
            [scrollView addSubview:btnObject];
            [btnObject release];
        }
        
        UIButton *btnObject = (UIButton *)[objects objectAtIndex:0];
        orginalTransform = btnObject.transform;
        CGFloat btnHigh = btnObject.frame.size.height;
        CGRect scrollRct = scrollView.frame;
        scrollRct.origin.x = btnObject.frame.size.width;
        scrollView.frame = scrollRct;
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, btnHigh*num+self.frame.size.height);
        [scrollView setContentOffset:CGPointMake(0, scrollView.contentSize.height/2-scrollView.frame.size.height/2) animated:NO];
        [self setCurrentObject];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scroll{
    for (UIButton *btnObject in objects) {
        CGFloat degree = fabsf(scrollView.contentOffset.y - btnObject.center.y);
        if (degree>scrollView.frame.size.height/2) {
            degree = fabsf(degree - scrollView.frame.size.height);
        }
        CGFloat xita = sinf(degree/scrollView.frame.size.height*M_PI);
        CGAffineTransform transform = btnObject.transform;
        CGFloat sXita = xita*1.7;
        sXita = sXita>1?sXita:1;
        transform = CGAffineTransformScale(orginalTransform, sXita, sXita);
        CGFloat mita = xita*btnObject.frame.size.width;
        transform = CGAffineTransformTranslate(transform, -0.9*mita, 0);
        btnObject.transform = transform;
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setCurrentObject];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self setCurrentObject];
    }
}

- (void)buttonAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(halfroundDisk:didPressButtonWithIndex:)]) {
        [self.delegate halfroundDisk:self didPressButtonWithIndex:sender.tag];
    }
}

- (void)setCurrentObject{
    CGFloat degree = 10000.0f;
    UIButton *centerObject = nil;
    for (UIButton *btn in objects) {
        CGFloat yCenter = scrollView.contentOffset.y+scrollView.frame.size.height/2;
        CGFloat tmpDegree = fabsf( btn.frame.origin.y - yCenter );
        if (degree>tmpDegree) {
            degree = tmpDegree;
            centerObject = btn;
        }
    }
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 57+centerObject.frame.origin.y-scrollView.frame.size.height/2) animated:YES];
    if ([self.delegate respondsToSelector:@selector(halfroundDisk:didEndAnimationOnButtonWithIndex:)]) {
        [self.delegate halfroundDisk:self didEndAnimationOnButtonWithIndex:centerObject.tag];
    }
}




@end
