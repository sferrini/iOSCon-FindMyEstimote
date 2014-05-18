//
//  SeekPanelView.m
//  iOSCon-FindMyEstimote
//
//  Created by Simone Ferrini on 18/05/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

#import "SeekPanelView.h"

@implementation SeekPanelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        SeekPanelView *view = (SeekPanelView *)[[[NSBundle mainBundle] loadNibNamed:@"SeekPanelView" owner:nil options:nil] objectAtIndex:0];
        self = view;
    }
    return self;
}

- (void) makeSelected
{
    CGPoint oldCenter = self.center;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width * 1.4, self.frame.size.height * 1.4);
    self.center = oldCenter;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


@end
