//
//  SeekPanelViewController.h
//  iOSCon-FindMyEstimote
//
//  Created by Simone Ferrini on 18/05/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTBeacon.h"

@interface SeekPanelViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *backButton;

/*
 * Selected beacon is returned on given completion handler.
 */
- (id)initWithCompletionHandler:(void (^)(ESTBeacon *))completionHandler;

@end
