//
//  SettingsViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 9/4/12.
//
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize view1;
@synthesize view2;
@synthesize clientId;
@synthesize siteURL;
@synthesize logOut;

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
    
    [super makeRoundRect:logOut];
    view1.layer.cornerRadius = 5;
    view1.layer.masksToBounds = YES;
    
    view2.layer.cornerRadius = 5;
    view2.layer.masksToBounds = YES;

    self.view.layer.cornerRadius = 5;
    self.view.layer.masksToBounds = YES;
   
}

-(void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidUnload
{
    [self setLogOut:nil];
    [self setClientId:nil];
    [self setSiteURL:nil];
    [self setView1:nil];
    [self setView2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)logout:(id)sender {
    
    [super logout];
    
}



@end
