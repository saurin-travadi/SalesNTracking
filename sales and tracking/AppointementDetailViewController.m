//
//  AppointementDetailViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 8/31/12.
//
//

#import "AppointementDetailViewController.h"
#import "AppointmentUpdateViewController.h"

@implementation AppointementDetailViewController

@synthesize appDateTime, apptId;

@synthesize dateLabel;
@synthesize nameLabel;
@synthesize addressLabel,mapButton1;
@synthesize cityLabel,mapButton2;
@synthesize phoneLabel, phoneButton;
@synthesize altPhoneLable, altPhoneButton;
@synthesize sourceLabel;
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
        
        AppointementDetail *appt = json;
        
        dateLabel.text = [NSString stringWithFormat:@"%@ %@",[appt.apptDate substringToIndex:10],[[appt.apptDate substringFromIndex:11] substringToIndex:5]];
        nameLabel.text=appt.custName;
        addressLabel.text=appt.address;
        cityLabel.text=appt.cSZ;
        mapButton1.titleLabel.text=[NSString stringWithFormat:@"%@ %@",appt.address, appt.cSZ];
        mapButton2.titleLabel.text=[NSString stringWithFormat:@"%@ %@",appt.address, appt.cSZ];
        mapButton1.backgroundColor  = [UIColor clearColor];
        mapButton2.backgroundColor = [UIColor clearColor];
       
        
        phoneLabel.text =appt.phone;
        phoneButton.backgroundColor = [UIColor clearColor];
        altPhoneLable.text=appt.altPhone;
        if(![appt.altPhoneType isEqualToString:@""])
            altPhoneCaption.text=[appt.altPhoneType stringByAppendingString:@":"];
        altPhoneButton.backgroundColor = [UIColor clearColor];
        
        productLabel.text = appt.productID;
        sourceLabel.text=appt.source;
        notesLabel.text=[NSString stringWithFormat:@"%@",appt.notes];
        
        //set notesLabel
        notesLabel.lineBreakMode = UILineBreakModeWordWrap;
        notesLabel.numberOfLines = 0;
        UIFont *cellFont = [UIFont systemFontOfSize:17];
        CGSize constraintSize = CGSizeMake(175.0f, MAXFLOAT);
        CGSize labelSize = [notesLabel.text sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        CGRect frame = notesLabel.frame;
        frame.size.height=labelSize.height;
        notesLabel.frame = frame;
        
        notesScrollView.contentSize=notesLabel.frame.size;
        
        if(!appt.canUpdateIndicator)
            [updateApptButton setHidden:YES];
        
        if([appt.apptStatusCode isEqualToString:@"Y"])
        {
            UILabel *lbl = [[UILabel alloc] initWithFrame:acknowledgeButton.frame];
            lbl.textAlignment  = UITextAlignmentCenter;
            lbl.text = @"Acknowledged by Rep";
            [self.view addSubview:lbl];
            [acknowledgeButton setHidden:YES];
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
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] acknowledgeAppointmentId:[self apptId] withUserInfo:[super getUserInfo] :^(id json) {
        
        [HUD hide:YES];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Appointment" message:@"Appointment Acknowledged" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
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
    [[segue destinationViewController] setDateTime:dateLabel.text];
    [[segue destinationViewController] setName:nameLabel.text];
    [[segue destinationViewController] setAddress:addressLabel.text];
    [[segue destinationViewController] setCity:cityLabel.text];
    [[segue destinationViewController] setApptId:[self apptId]];
}
@end
