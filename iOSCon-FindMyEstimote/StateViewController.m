//
//  StateViewController.m
//  iOSCon-FindMyEstimote
//
//  Created by Simone Ferrini on 18/05/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

#import "StateViewController.h"

#import "CAGradientLayer+FMEGradients.h"

@interface StateViewController ()

@property (nonatomic, strong) NSArray *estimoteNames;

@end

@implementation StateViewController

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
    // Do any additional setup after loading the view.
    
    [self.estimoteNumber addTarget:self action:@selector(segmentSwitch:) forControlEvents:UIControlEventValueChanged];
    
    self.estimoteNames = @[@"First estimote", @"Second estimote", @"Third estimote"];
    
    // Setup
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"32687"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"47723"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"37862"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //Adding the background gradient.
    CAGradientLayer *backgroundLayer = [CAGradientLayer blueGradientLayer];
    backgroundLayer.frame = self.view.frame;
    [self.view.layer insertSublayer:backgroundLayer atIndex:0];
    
    self.conteinerView.layer.cornerRadius = 10;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.estimoteTableView reloadData];
}

- (IBAction)backToMenu:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table View

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    switch (self.estimoteNumber.selectedSegmentIndex) {
        case 0: {
            return 1;
        }
        case 1: {
            return 2;
        }
        default: {
            
            return 3;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.textLabel.textColor = [UIColor grayColor];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = self.estimoteNames[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Futura" size:15];
    
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // or you have the previous 'None' style...
    tableView.separatorColor = [UIColor grayColor];
    
    switch (indexPath.row) {
        case 0:{
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"32687"] isEqualToValue:@YES] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"47723"] isEqualToValue:@YES] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"37862"] isEqualToValue:@YES]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                if (self.estimoteNumber.selectedSegmentIndex == 0) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You win!"
                                                                    message:@"Congratulations you have found all estimote"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
            }
        }
            break;
        case 1:{
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"32687"] isEqualToValue:@YES] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"47723"] isEqualToValue:@YES] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"37862"] isEqualToValue:@YES]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                if (self.estimoteNumber.selectedSegmentIndex == 1) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You win!"
                                                                    message:@"Congratulations you have found all estimote"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
            }
            
            if (
                
                ([[[NSUserDefaults standardUserDefaults] objectForKey:@"32687"] isEqualToValue:@YES] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"47723"] isEqualToValue:@YES]) ||
                
                ([[[NSUserDefaults standardUserDefaults] objectForKey:@"32687"] isEqualToValue:@YES] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"37862"] isEqualToValue:@YES]) ||
                
                ([[[NSUserDefaults standardUserDefaults] objectForKey:@"47723"] isEqualToValue:@YES] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"37862"] isEqualToValue:@YES]) ) {
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                if (self.estimoteNumber.selectedSegmentIndex == 1) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You win!"
                                                                    message:@"Congratulations you have found all estimote"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
            }
        }
            break;
        case 2:{
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"32687"]  isEqualToValue:@YES] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"47723"] isEqualToValue:@YES] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"37862"] isEqualToValue:@YES]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                if (self.estimoteNumber.selectedSegmentIndex == 2) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You win!"
                                                                    message:@"Congratulations you have found all estimote"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
            }
        }
            break;
    }
    return cell;
}

#pragma mark Segment

- (void)segmentSwitch:(id)sender
{
    [self.estimoteTableView reloadData];
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
