//
//  MainViewController.m
//  SimpleHalfRoundDisk
//
//  Created by 慢吞吞 on 12-8-28.
//  Copyright (c) 2012年 Teamnet. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    halfDisk = [[HalfRoundDisk alloc] initWithFrame:CGRectMake(107, 0, 213, 460)];
    halfDisk.delegate = self;
    halfDisk.objects = [self createSomeTestObject:10];
    [self.view addSubview:halfDisk];
    [halfDisk release];
}

- (void)viewDidUnload
{
    [playerNum release];
    playerNum = nil;
    [playerNumS release];
    playerNumS = nil;
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [playerNum release];
    [playerNumS release];
    [super dealloc];
}

- (NSArray *)createSomeTestObject:(NSInteger)num{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<num; i++) {
        UIImage *shirt_image = [UIImage imageNamed:@"shirt.png"];
        UIButton *btnObject = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnObject setImage:shirt_image forState:UIControlStateNormal];
        btnObject.frame = CGRectMake(0, 0, shirt_image.size.width, shirt_image.size.height);
        [arr addObject:btnObject];
    }
    return (NSArray *)arr;
}

- (void)halfroundDisk:(HalfRoundDisk *)disk didPressButtonWithIndex:(NSInteger)index{
    playerNum.text = [NSString stringWithFormat:@"%d",++index];
}

- (void)halfroundDisk:(HalfRoundDisk *)disk didEndAnimationOnButtonWithIndex:(NSInteger)index{
    playerNumS.text = [NSString stringWithFormat:@"%d",++index];
}
@end
