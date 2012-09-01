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
@synthesize phoneLabel, phoneButton;
@synthesize altPhoneLable, altPhoneButton;
@synthesize sourceLabel;
@synthesize notesLabel;
@synthesize acknowledgeButton;
@synthesize updateApptButton;

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getAppointmentDetail];
}

- (void)viewDidUnload
{
    [self setDateLabel:nil];
    [self setNameLabel:nil];
    [self setAddressLabel:nil];
    [self setCityLabel:nil];
    [self setSourceLabel:nil];
    [self setNotesLabel:nil];
    [self setAcknowledgeButton:nil];
    [self setUpdateApptButton:nil];
    [self setPhoneLabel:nil];
    [self setPhoneButton:nil];
    [self setAltPhoneLable:nil];
    [self setAltPhoneButton:nil];
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
    
    [[[ServiceConsumer alloc] init] getSalesAppointmentDetailById:[self apptId] DateTime:[self appDateTime] withUserInfo:[super getUserInfo] :^(id json) {
        
        AppointementDetail *appt = json;
        
        dateLabel.text = [NSString stringWithFormat:@"%@ %@",[appt.apptDate substringToIndex:10],[[appt.apptDate substringFromIndex:11] substringToIndex:5]];
        nameLabel.text=appt.custName;
        addressLabel.text=appt.address;
        cityLabel.text=appt.cSZ;
        phoneLabel.text =appt.phone;
        phoneButton.backgroundColor = [UIColor clearColor];
        altPhoneLable.text=appt.altPhone;
        altPhoneButton.backgroundColor = [UIColor clearColor];
        
        sourceLabel.text=appt.source;
        notesLabel.text=appt.notes;
        
        //set notesLabel
        notesLabel.lineBreakMode = UILineBreakModeWordWrap;
        notesLabel.numberOfLines = 0;
        UIFont *cellFont = [UIFont systemFontOfSize:17];
        CGSize constraintSize = CGSizeMake(175.0f, MAXFLOAT);
        CGSize labelSize = [notesLabel.text sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        CGRect frame = notesLabel.frame;
        frame.size.height=labelSize.height;
        notesLabel.frame = frame;
        
        //set remaining fields per notesLabel height
        frame = acknowledgeButton.frame;
        frame.origin.y += notesLabel.frame.size.height;
        acknowledgeButton.frame = frame;

        frame = updateApptButton.frame;
        frame.origin.y +=notesLabel.frame.size.height;
        updateApptButton.frame=frame;
        
        frame = self.view.bounds;
        frame.size.height = self.view.bounds.size.height + notesLabel.frame.size.height;
        self.scrollView.contentSize=frame.size;
        
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
        phoneNumber = altPhoneLable.text;
    
    phoneNumber = [NSString stringWithFormat:@"%@%@", @"tel://", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

@end
