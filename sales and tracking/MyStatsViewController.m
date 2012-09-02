//
//  MyStatesViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 9/1/12.
//
//

#import "MyStatsViewController.h"
#import "MyStat.h"

@implementation MyStatsViewController {
    MyStat *stat;
}
@synthesize apptsLabel;
@synthesize demosLabel;
@synthesize demoRateLabel;
@synthesize salesLabel;
@synthesize closingRateLabel;
@synthesize grossVolumeLabel;
@synthesize netVolumeLabel;

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
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self getStats];
}
- (void)viewDidUnload
{
    [self setApptsLabel:nil];
    [self setDemosLabel:nil];
    [self setDemoRateLabel:nil];
    [self setSalesLabel:nil];
    [self setClosingRateLabel:nil];
    [self setGrossVolumeLabel:nil];
    [self setNetVolumeLabel:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)getStats
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] getSalesStatesByUser:[super getUserInfo] :^(id json) {
        
        stat=json;
        
        apptsLabel.text=stat.numIssued;
        demosLabel.text=stat.numDemo;
        demoRateLabel.text=stat.demoRate;
        salesLabel.text=stat.numSale;
        closingRateLabel.text=stat.closingRate;
        grossVolumeLabel.text=stat.grossAmount;
        netVolumeLabel.text=stat.netAmount;
        
        [HUD hide:YES];

    }];
}

@end
