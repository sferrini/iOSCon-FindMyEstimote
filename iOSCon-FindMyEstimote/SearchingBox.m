//
//  SearchingBox.m
//  iOSCon-FindMyEstimote
//
//  Created by Simone Ferrini on 18/05/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

#import "SearchingBox.h"

@implementation SearchingBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        SearchingBox *view = (SearchingBox *)[[[NSBundle mainBundle] loadNibNamed:@"SearchingBox" owner:nil options:nil] objectAtIndex:0];
        self = view;
    }
    return self;
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
