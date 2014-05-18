//
//  StateViewController.h
//  iOSCon-FindMyEstimote
//
//  Created by Simone Ferrini on 18/05/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *conteinerView;

@property (strong, nonatomic) IBOutlet UISegmentedControl *estimoteNumber;

@property (strong, nonatomic) IBOutlet UITableView *estimoteTableView;

@end
