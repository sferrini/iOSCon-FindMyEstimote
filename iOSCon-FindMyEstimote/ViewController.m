//
//  ViewController.m
//  iOSCon-FindMyEstimote
//
//  Created by Simone Ferrini on 18/05/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

#import "ViewController.h"

#import "CAGradientLayer+FMEGradients.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *seekbutton;
@property (strong, nonatomic) IBOutlet UIButton *howToPlayButton;

@property CGRect seekButtonFrame;
@property CGRect howToPlayFrame;

@property BOOL buttonsInPlace;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.seekButtonFrame = self.seekbutton.frame;
    self.howToPlayFrame = self.howToPlayButton.frame;
    
    self.buttonsInPlace = NO;
    
    //Adding the background gradient.
    CAGradientLayer *backgroundLayer = [CAGradientLayer blueGradientLayer];
    backgroundLayer.frame = self.view.frame;
    [self.view.layer insertSublayer:backgroundLayer atIndex:0];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.buttonsInPlace == NO) {
        [self animateButtonsIntoPlace];
    }
}

- (void)animateButtonsIntoPlace
{
    self.seekbutton.center = CGPointMake(self.seekbutton.center.x, self.seekbutton.center.y - 400);
    self.howToPlayButton.center = CGPointMake(self.howToPlayButton.center.x, self.howToPlayButton.center.y - 400);
    
    [UIView animateWithDuration:0.8f delay:0.5f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        self.seekbutton.frame = self.seekButtonFrame;
        self.howToPlayButton.frame = self.howToPlayFrame;
    }completion:nil];
    self.buttonsInPlace = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
