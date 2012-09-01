//
//  AppointementDetailViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 8/31/12.
//
//

#import "AppointementDetailViewController.h"


@implementation AppointementDetailViewController

@synthesize appDateTime, apptId;

@synthesize dateLabel;
@synthesize nameLabel;
@synthesize addressLabel;
@synthesize cityLabel;
@synthesize phoneLabel;
@synthesize altPhoneLabel;
@synthesize sourceLabel;
@synthesize notesLabel;

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
    
    [self getAppointmentDetail];
}

- (void)viewDidUnload
{
    [self setDateLabel:nil];
    [self setNameLabel:nil];
    [self setAddressLabel:nil];
    [self setCityLabel:nil];
    [self setPhoneLabel:nil];
    [self setAltPhoneLabel:nil];
    [self setSourceLabel:nil];
    [self setNotesLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)getAppointmentDetail
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] getSalesAppointmentDetailById:@"54" DateTime:@"2012-06-18" withUserInfo:[super getUserInfo] :^(id json) {
        
        AppointementDetail *appt = json;
        
        dateLabel.text = appt.apptDate;
        nameLabel.text=appt.custName;

            addressLabel.text=appt.address;
        
        cityLabel.text=appt.cSZ;
        phoneLabel.text=appt.phone;
        altPhoneLabel.text=appt.altPhone;
        sourceLabel.text=appt.source;
        notesLabel.text=appt.notes;
        
        [HUD hide:YES];
    }];
}

@end
