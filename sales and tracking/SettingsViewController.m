//
//  SettingsViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 9/4/12.
//
//

#import "SettingsViewController.h"
#import "UserInfo.h"

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
   
    UserInfo* user = [super getUserInfo];
    clientId.text = user.clientID;
    siteURL.text = user.siteURL;
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

- (IBAction)updateSettings:(id)sender {
    [clientId resignFirstResponder];
    [siteURL resignFirstResponder];
    
    UIAlertView *alert;
    if([clientId.text isEqualToString:@""]){
        alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Invalid Client ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else if([siteURL.text isEqualToString:@""]){
        alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Invalid Site URL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    

    alert = [[UIAlertView alloc] initWithTitle:@"Settings" message:@"Updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [clientId resignFirstResponder];
    [siteURL resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL didResign = [textField resignFirstResponder];
    if (!didResign) return NO;
    
    if ([textField isKindOfClass:[NextUITextField class]]) {
        if (((NextUITextField *) textField).nextField != nil)
            [((NextUITextField *) textField).nextField becomeFirstResponder];
        else {
            [self updateSettings:nil];
        }
    }
    
    return YES;
    
}

@end
