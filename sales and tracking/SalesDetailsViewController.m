//
//  SalesDetailsViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 9/3/12.
//
//

#import "SalesDetailsViewController.h"
#import "ServiceConsumer.h"
#import "MySales.h"

@implementation SalesDetailsViewController

@synthesize selectedJobId;

@synthesize nameLabel;
@synthesize addressLabel;
@synthesize cityLabel;
@synthesize phoneLabel;
@synthesize altPhoneLabel;
@synthesize productLabel;
@synthesize saleDateLabel;
@synthesize saleDollarLabel;
@synthesize jobStatusLabel;
@synthesize phoneButton;
@synthesize altPhoneButton;
@synthesize altPhoneTypeLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    [self getSales];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setAddressLabel:nil];
    [self setCityLabel:nil];
    [self setPhoneLabel:nil];
    [self setAltPhoneLabel:nil];
    [self setProductLabel:nil];
    [self setSaleDateLabel:nil];
    [self setSaleDollarLabel:nil];
    [self setJobStatusLabel:nil];
    [self setPhoneButton:nil];
    [self setAltPhoneLabel:nil];
    [self setPhoneButton:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)getSales
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] getJobDetailsById:selectedJobId withUserInof:[super getUserInfo] :^(id json) {
        
        nameLabel.text=((MySales*)json).custName;
        addressLabel.text=((MySales*)json).address;
        cityLabel.text=((MySales*)json).cSZ;
        phoneLabel.text =((MySales*)json).phone;
        phoneButton.backgroundColor = [UIColor clearColor];
        altPhoneLabel.text=((MySales*)json).altPhone;
        if(![((MySales*)json).altPhoneType isEqualToString:@""])
            altPhoneTypeLabel.text=[((MySales*)json).altPhoneType stringByAppendingString:@":"];
        altPhoneButton.backgroundColor = [UIColor clearColor];
        
        productLabel.text = ((MySales*)json).productID;
        saleDateLabel.text=[NSString stringWithFormat:@"%@ %@",[((MySales*)json).contractDate substringToIndex:10],[[((MySales*)json).contractDate substringFromIndex:11] substringToIndex:5]];
        saleDollarLabel.text = ((MySales*)json).grossAmount;
        jobStatusLabel.text=((MySales*)json).jobStatusDescr;
        
        [HUD hide:YES];
        
    }];
}

-(IBAction)phoneMade:(id)sender
{
    UIButton* btn = sender;
    NSString *phoneNumber;
    
    if(btn==phoneButton)
        phoneNumber = phoneLabel.text;
    else
        phoneNumber = altPhoneLabel.text;
    
    phoneNumber = [NSString stringWithFormat:@"%@%@", @"tel://", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

@end
