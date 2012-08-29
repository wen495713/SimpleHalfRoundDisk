//
//  MainViewController.h
//  SimpleHalfRoundDisk
//
//  Created by 慢吞吞 on 12-8-28.
//  Copyright (c) 2012年 Teamnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HalfRoundDisk.h"
@interface MainViewController : UIViewController<HalfRoundDiskDelegate>{
    HalfRoundDisk *halfDisk;
    IBOutlet UILabel *playerNum;
    IBOutlet UILabel *playerNumS;
}

@end
