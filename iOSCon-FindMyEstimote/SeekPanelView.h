//
//  SeekPanelView.h
//  iOSCon-FindMyEstimote
//
//  Created by Simone Ferrini on 18/05/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeekPanelView : UIView

@property (weak, nonatomic) IBOutlet UILabel *panelLabel;

- (void) makeSelected;

@end
