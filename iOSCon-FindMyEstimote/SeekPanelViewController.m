//
//  SeekPanelViewController.m
//  iOSCon-FindMyEstimote
//
//  Created by Simone Ferrini on 18/05/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

#import "SeekPanelViewController.h"

#import "CAGradientLayer+FMEGradients.h"

#import "ESTBeaconManager.h"

#import "SearchingBox.h"
#import "SeekPanelView.h"

@interface SeekPanelViewController () <ESTBeaconManagerDelegate>

@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *region;

@property (nonatomic, copy) void (^completionHandler)(ESTBeacon *);

@property (nonatomic, strong) SearchingBox *searchBox;
@property BOOL isShowingAlert, estimoteDiscovered, allPanelsInPlace;

@property (strong, nonatomic) NSArray *colourArray, *panelArray, *panelDescription;
@property (strong, nonatomic) SeekPanelView *panelZero, *panelOne, *panelTwo, *panelThree, *panelFour, *panelFive, *panelSix, *panelSeven;

@end

@implementation SeekPanelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCompletionHandler:(void (^)(ESTBeacon *))completionHandler
{
    self = [super init];
    if (self)
    {
        self.completionHandler = completionHandler;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Adding the background gradient.
    CAGradientLayer *backgroundLayer = [CAGradientLayer blueGradientLayer];
    backgroundLayer.frame = self.view.frame;
    [self.view.layer insertSublayer:backgroundLayer atIndex:0];
    
    self.panelDescription = @[@"Scorching",
                              @"Very hot",
                              @"Hot",
                              @"Lukewarm",
                              @"Tepid",
                              @"Cold",
                              @"Very cold",
                              @"Freezing"];
    
    self.searchBox = [[SearchingBox alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    self.searchBox.center = self.view.center;
    
    self.isShowingAlert = NO;
    self.estimoteDiscovered = NO;
    
    [self setupPanels];
}

- (void)setupPanels
{
    self.colourArray = @[[UIColor colorWithRed:0.92 green:0.13 blue:0.18 alpha:1.0],
                         [UIColor colorWithRed:0.93 green:0.18 blue:0.33 alpha:1.0],
                         [UIColor colorWithRed:0.93 green:0.33 blue:0.33 alpha:1.0],
                         [UIColor colorWithRed:0.93 green:0.45 blue:0.34 alpha:1.0],
                         [UIColor colorWithRed:0.93 green:0.69 blue:0.56 alpha:1.0],
                         [UIColor colorWithRed:0.52 green:0.79 blue:0.62 alpha:1.0],
                         [UIColor colorWithRed:0.54 green:0.69 blue:0.92 alpha:1.0],
                         [UIColor colorWithRed:0.06 green:0.47 blue:0.63 alpha:1.0]];
    
    self.panelZero = [[SeekPanelView alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     [UIScreen mainScreen].bounds.size.width,
                                                                     [UIScreen mainScreen].bounds.size.height / 8)];
    self.panelOne = [[SeekPanelView alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    [UIScreen mainScreen].bounds.size.width,
                                                                    [UIScreen mainScreen].bounds.size.height / 8)];
    self.panelTwo = [[SeekPanelView alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    [UIScreen mainScreen].bounds.size.width,
                                                                    [UIScreen mainScreen].bounds.size.height / 8)];
    self.panelThree = [[SeekPanelView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      [UIScreen mainScreen].bounds.size.width,
                                                                      [UIScreen mainScreen].bounds.size.height / 8)];
    self.panelFour = [[SeekPanelView alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     [UIScreen mainScreen].bounds.size.width,
                                                                     [UIScreen mainScreen].bounds.size.height / 8)];
    self.panelFive = [[SeekPanelView alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     [UIScreen mainScreen].bounds.size.width,
                                                                     [UIScreen mainScreen].bounds.size.height / 8)];
    self.panelSix = [[SeekPanelView alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    [UIScreen mainScreen].bounds.size.width,
                                                                    [UIScreen mainScreen].bounds.size.height / 8)];
    self.panelSeven = [[SeekPanelView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      [UIScreen mainScreen].bounds.size.width,
                                                                      [UIScreen mainScreen].bounds.size.height / 8)];
    
    self.panelArray = @[self.panelZero,
                        self.panelOne,
                        self.panelTwo,
                        self.panelThree,
                        self.panelFour,
                        self.panelFive,
                        self.panelSix,
                        self.panelSeven];
    
    self.allPanelsInPlace = NO;
}

- (void)setUpColourBars
{
    for (NSInteger x = 0; x < [self.panelArray count]; x++) {
        SeekPanelView *tempView = [self.panelArray objectAtIndex:x];
        
        // Create y coordinate based on its index number (top to bottom of screen)
        CGFloat yCoord;
        float timeDelay;
        
        // Check if it's first in the array
        if (x == 0) {
            yCoord = 0;
            timeDelay = 0;
        } else {
            yCoord = ([UIScreen mainScreen].bounds.size.height / 8) * x;
            timeDelay = 0.2 * x;
        }
        
        // Move the panel off screen
        tempView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width,
                                    yCoord,
                                    [UIScreen mainScreen].bounds.size.width,
                                    [UIScreen mainScreen].bounds.size.height / 8);
        
        tempView.backgroundColor = [self.colourArray objectAtIndex:x];
        
        tempView.panelLabel.text = [self.panelDescription objectAtIndex:x];
        
        [self.view addSubview:tempView];
        
        [UIView animateWithDuration:0.5 delay:timeDelay usingSpringWithDamping:0.8f initialSpringVelocity:2.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            tempView.frame = CGRectMake(0,
                                        yCoord,
                                        [UIScreen mainScreen].bounds.size.width,
                                        [UIScreen mainScreen].bounds.size.height / 8);
        } completion:^(BOOL finished) {
            if (x == [self.panelArray count] - 1) {
                self.allPanelsInPlace = YES;
                
                [self showSearchingBox];
            }
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self setUpColourBars];
    
    // Make sure backButton is on top of colour bars
    [self.view addSubview:self.backButton];
    
    
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    /*
     * Creates sample region object (you can additionaly pass major / minor values).
     *
     * We specify it using only the ESTIMOTE_PROXIMITY_UUID because we want to discover all
     * hardware beacons with Estimote's proximty UUID.
     */
    self.region = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID
                                                      identifier:@"EstimoteSampleRegion"];
    
    /*
     * Starts looking for Estimote beacons.
     * All callbacks will be delivered to beaconManager delegate.
     */
    [self.beaconManager startRangingBeaconsInRegion:self.region];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // Stops ranging after exiting the view.
    [self.beaconManager stopRangingBeaconsInRegion:self.region];
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    /*
     * Fill the table with beacon data.
     */
    ESTBeacon *beacon = [beacons objectAtIndex:0];
    
    NSLog(@"%@", [NSString stringWithFormat:@"Major: %@, Minor: %@", beacon.major, beacon.minor]);
    NSLog(@"%@", [NSString stringWithFormat:@"Distance: %.2f", [beacon.distance floatValue]]);
    
    
    //    32687 blu
    //    47723 green
    //    37862 purple
    
    NSLog(@"Blu:%@ Green:%@ Purple:%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"32687"],
          [[NSUserDefaults standardUserDefaults] objectForKey:@"47723"],
          [[NSUserDefaults standardUserDefaults] objectForKey:@"37862"]);
    
    // Make sure the intro animation is complete
    if (self.allPanelsInPlace && !self.estimoteDiscovered) {
        
        [self hideSearchingBox];
        
        float distanceToBeacon = beacon.distance.floatValue;
        
        if (distanceToBeacon < 0.2 && distanceToBeacon > 0) {
            [self resetPanelLabelAlphas];
            self.panelZero.panelLabel.alpha = 0.7f;
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@", beacon.major]];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!"
                                                            message:@"You have found an estimote!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            
            [alert show];
            
            self.estimoteDiscovered = YES;
            
        } else if (distanceToBeacon > 0.2 && distanceToBeacon < 2) {
            [self resetPanelLabelAlphas];
            self.panelOne.panelLabel.alpha = 0.7f;
            
        } else if (distanceToBeacon > 2 && distanceToBeacon < 5) {
            [self resetPanelLabelAlphas];
            self.panelTwo.panelLabel.alpha = 0.7f;
            
        } else if (distanceToBeacon > 5 && distanceToBeacon < 8) {
            [self resetPanelLabelAlphas];
            self.panelThree.panelLabel.alpha = 0.7f;
            
        } else if (distanceToBeacon > 8 && distanceToBeacon < 11) {
            [self resetPanelLabelAlphas];
            self.panelFour.panelLabel.alpha = 0.7f;
            
        } else if (distanceToBeacon > 11 && distanceToBeacon < 14) {
            [self resetPanelLabelAlphas];
            self.panelFive.panelLabel.alpha = 0.7f;
            
        } else if (distanceToBeacon > 14 && distanceToBeacon < 17) {
            [self resetPanelLabelAlphas];
            self.panelSix.panelLabel.alpha = 0.7f;
            
        } else if (distanceToBeacon > 17) {
            [self resetPanelLabelAlphas];
            self.panelSeven.panelLabel.alpha = 0.7f;
            
        } else {
            
            NSLog(@"Lost!");
            [self showSearchingBox];
        }
    }
}

#pragma mark - Searching Box

- (void)showSearchingBox
{
    if (self.isShowingAlert == NO) {
        self.searchBox.center = CGPointMake(self.view.center.x, self.view.center.y - [UIScreen mainScreen].bounds.size.height);
        
        [self.view addSubview:self.searchBox];
        [self resetPanelLabelAlphas];
        
        [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.6f initialSpringVelocity:2.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.searchBox.center = self.view.center;
            self.isShowingAlert = YES;
        }completion:nil];
    }
}

- (void)hideSearchingBox
{
    if (self.isShowingAlert) {
        [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.6f initialSpringVelocity:2.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.searchBox.center = CGPointMake(self.view.center.x, self.view.center.y + [UIScreen mainScreen].bounds.size.height);
            self.isShowingAlert = YES;
        }completion:^(BOOL finished){
            [self.searchBox removeFromSuperview];
            self.isShowingAlert = NO;
        }];
    }
}

- (IBAction)closeSeekPanel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.beaconManager stopRangingBeaconsInRegion:self.region];
}

- (void)resetPanelLabelAlphas
{
    self.panelZero.panelLabel.alpha = 0.1f;
    self.panelOne.panelLabel.alpha = 0.1f;
    self.panelTwo.panelLabel.alpha = 0.1f;
    self.panelThree.panelLabel.alpha = 0.1f;
    self.panelFour.panelLabel.alpha = 0.1f;
    self.panelFive.panelLabel.alpha = 0.1f;
    self.panelSix.panelLabel.alpha = 0.1f;
    self.panelSeven.panelLabel.alpha = 0.1f;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Congratulations!"]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.beaconManager stopRangingBeaconsInRegion:self.region];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
