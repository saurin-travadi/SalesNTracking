//
//  AppointementDetailViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 8/31/12.
//
//

#import "AppointementDetailViewController.h"
#import "AppointmentUpdateViewController.h"

@implementation AppointementDetailViewController {
    AppointementDetail *apptObject;
    bool ack;
}

@synthesize appDateTime, apptId;

@synthesize dateLabel;
@synthesize nameLabel;
@synthesize addressLabel,mapButton1;
@synthesize cityLabel,mapButton2;
@synthesize phoneLabel, phoneButton;
@synthesize altPhoneLable, altPhoneButton;
@synthesize sourceLabel;
@synthesize dispLabel;
@synthesize notesLabel, notesScrollView;
@synthesize productLabel;
@synthesize altPhoneCaption;
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
 
    [self.navigationController setToolbarHidden:YES animated:NO];
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
    [self setNotesScrollView:nil];
    [self setAcknowledgeButton:nil];
    [self setUpdateApptButton:nil];
    [self setPhoneLabel:nil];
    [self setPhoneButton:nil];
    [self setAltPhoneLable:nil];
    [self setAltPhoneButton:nil];
    [self setProductLabel:nil];
    [self setAltPhoneCaption:nil];
    [self setMapButton1:nil];
    [self setMapButton2:nil];
    
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
        
        apptObject = json;
        
        dateLabel.text = apptObject.apptDisplayDate;
        nameLabel.text=apptObject.custName;
        addressLabel.text=apptObject.address;
        cityLabel.text=apptObject.cSZ;
        mapButton1.titleLabel.text=[NSString stringWithFormat:@"%@ %@",apptObject.address, apptObject.cSZ];
        mapButton2.titleLabel.text=[NSString stringWithFormat:@"%@ %@",apptObject.address, apptObject.cSZ];
        mapButton1.backgroundColor  = [UIColor clearColor];
        mapButton2.backgroundColor = [UIColor clearColor];
       
        
        phoneLabel.text =apptObject.phone;
        phoneButton.backgroundColor = [UIColor clearColor];
        altPhoneLable.text=apptObject.altPhone;
        if(![apptObject.altPhoneType isEqualToString:@""])
            altPhoneCaption.text=[apptObject.altPhoneType stringByAppendingString:@":"];
        altPhoneButton.backgroundColor = [UIColor clearColor];
        
        productLabel.text = apptObject.productID;
        sourceLabel.text=apptObject.source;
        dispLabel.text = apptObject.disp;
        notesLabel.text=[NSString stringWithFormat:@"%@",apptObject.notes];
        
        //set notesLabel
        notesLabel.lineBreakMode = UILineBreakModeWordWrap;
        notesLabel.numberOfLines = 0;
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica-Oblique" size:15];;
        CGSize constraintSize = CGSizeMake(175.0f, notesLabel.frame.size.width);
        CGSize labelSize = [notesLabel.text sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        CGRect frame = notesLabel.frame;
        frame.size.height=labelSize.height;
        notesLabel.frame = frame;
        
        notesScrollView.contentSize=notesLabel.frame.size;
        [notesScrollView scrollRectToVisible:CGRectMake(0, 0, notesScrollView.frame.size.width, notesScrollView.frame.size.height) animated:NO];
        
        frame = CGRectMake(0, notesScrollView.frame.origin.y+notesScrollView.frame.size.height, self.view.bounds.size.width, 20);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
        imgView.image = [UIImage imageNamed:@"DottedLine.png"];
        [self.scrollView addSubview:imgView];
        [self.scrollView sendSubviewToBack:imgView];
        
        if(!apptObject.canUpdateIndicator)
            [updateApptButton setHidden:YES];
        
        if([apptObject.apptStatusCode isEqualToString:@"Y"])
        {
            ack=YES;
            [acknowledgeButton setBackgroundImage:[UIImage imageNamed:@"AcknowledgedOffButton.png"] forState:UIControlStateNormal];
        }
        
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

-(IBAction)ackAppt:(id)sender{
    if(ack)
        return;
    
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] acknowledgeAppointmentId:[self apptId] withUserInfo:[super getUserInfo] :^(id json) {
        
        [HUD hide:YES];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Appointment" message:@"Appointment Acknowledged" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
        ack=YES;
        [acknowledgeButton setBackgroundImage:[UIImage imageNamed:@"AcknowledgedOffButton.png"] forState:UIControlStateNormal];
        
    }];

}

-(IBAction)showMap:(id)sender {
    UIButton *btn = sender;
    NSString* dAddress = [btn.titleLabel.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *sAddress = [NSString stringWithFormat:@"%f,%f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%@&daddr=%@", sAddress,dAddress]]];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    [[segue destinationViewController] setApptObject:apptObject];
}
@end
