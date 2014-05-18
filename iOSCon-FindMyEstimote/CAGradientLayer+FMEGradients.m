//
//  CAGradientLayer+FMEGradients.m
//  iOSCon-FindMyEstimote
//
//  Created by Simone Ferrini on 18/05/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

#import "CAGradientLayer+FMEGradients.h"

@implementation CAGradientLayer (CAGradientLayer)

+ (CAGradientLayer *)blueGradientLayer
{
    // Defining the gradient colors
    UIColor *topColor = [UIColor colorWithRed:0.37 green:0.78 blue:0.98 alpha:1];
    UIColor *mediumColor = [UIColor colorWithRed:0.48 green:0.86 blue:0.96 alpha:1];
    UIColor *bottomColor = [UIColor colorWithRed:0.59 green:0.95 blue:0.98 alpha:1];
    
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)bottomColor.CGColor,
                                                        (id)mediumColor.CGColor,
                                                        (id)topColor.CGColor, nil];
    
    NSArray *gradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithInt:0.0],[NSNumber numberWithInt:1.0], nil];
    
    // Defining the gradient layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
    
    return gradientLayer;
}

@end
