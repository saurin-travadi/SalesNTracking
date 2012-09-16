//
//  LoginViewController.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "NextUITextField.h"
#import "AppDelegate.h"
#import "ServiceConsumer.h"
#import "Utility.h"

@implementation LoginViewController {
    NSString *pwd;
    NSString *cID;
    
    BOOL isFirstLogin;
}

@synthesize altViewFromNib, clientID, siteUrl, emailAddress;
@synthesize logOnButton;
@synthesize userName, password, delegate;
NSString *localSettingsPath;

- (id) init {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;

    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    password.secureTextEntry = YES;
    
    Utility *utility = [[Utility alloc] init];
    NSInteger res = [utility getUserSettings:@"FirstLogin"];
    if(res==0)
    {
        isFirstLogin=YES;
        
        NSArray* nibViews =[[NSBundle mainBundle] loadNibNamed:@"AlternateLogin" owner:self options:nil];
        [[self.view.subviews objectAtIndex:0] removeFromSuperview];
        [self.view addSubview:[nibViews objectAtIndex: 0]];
    }
    else
    {
        isFirstLogin=NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if(!isFirstLogin){
        UserInfo* user = [super getUserInfo];
        if(user==nil){
            pwd=@"";
            return;
        }
        else{                                           //we have user data saved, use it to logon
            userName.text = user.userName;
            
            if (user.password != NULL){
                pwd = user.password;
                cID = [Utility retrieveFromUserDefaults:@"clientId_preference"];
            }
            else
                pwd = @"";
        }
        if (![pwd isEqualToString:@""]){
            HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            HUD.dimBackground = YES;
            
            [self performSelector:@selector(performLogin) withObject:nil afterDelay:0.5];
        }
    }
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [self setLogOnButton:nil];
    [self setClientID:nil];
    [self setSiteUrl:nil];
    [self setEmailAddress:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    [password resignFirstResponder];
    [userName resignFirstResponder];
    [clientID resignFirstResponder];
    [siteUrl resignFirstResponder];
    [emailAddress resignFirstResponder];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"homeSegue"]) {
        userName.text = @"";
        password.text = @"";
    }
}

-(void) performLogin{
    
    UserInfo *info = [[UserInfo alloc] initWithUserName:userName.text Password:pwd ClientID:cID SiteURL:@"" ];
    [[[ServiceConsumer alloc] init] performLogin:info :^(bool* success) {
        
        [HUD hide:YES];
        
        if(*success){
            
            
            [super setUserInfo:info];
            [self performSegueWithIdentifier:@"homeSegue" sender:self];
        }
        else {
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Logon Failed"
                                                              message:@"The system was not able to log you on. Please check your User ID and Password and try again."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
    }];

}

- (IBAction)login:(id)sender {
    
    if(isFirstLogin){
        if([userName.text isEqualToString:@""] || [password.text isEqualToString:@""] || [clientID.text isEqualToString:@""] || [siteUrl.text isEqualToString:@""])
        {
            UIAlertView *alert  =[[UIAlertView alloc] initWithTitle:@"Configuration" message:@"Incorrect values provided for setup" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
            return;
        }
    }
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    if(isFirstLogin){
        pwd=password.text;
        password.text=@"";

        cID = clientID.text;
        
        //update users default
        Utility *u = [[Utility alloc] init];
        [u setUserSettings:1 keyName:@"FirstLogin"];
        
        [[NSUserDefaults standardUserDefaults] setObject:siteUrl.text forKey:@"baseurl_preference"];
        [[NSUserDefaults standardUserDefaults] setObject:clientID.text forKey:@"clientId_preference"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    else{
        
        [password resignFirstResponder];
        [userName resignFirstResponder];     
        
        pwd=password.text;
        password.text=@"";
        
        cID = [Utility retrieveFromUserDefaults:@"clientId_preference"];
    }

    [self performLogin];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    BOOL didResign = [textField resignFirstResponder];
    if (!didResign) return NO;
    
    if ([textField isKindOfClass:[NextUITextField class]]) {
        if (((NextUITextField *) textField).nextField != nil)
            [((NextUITextField *) textField).nextField becomeFirstResponder];
        else {
            [self login:nil];
        }
    }
    
    return YES;
    
}

-(IBAction)help:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.leadperfection.com/help/index.aspx?topic=01A"]];
}

-(IBAction)signup:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.leadperfection.com/help/index.aspx?topic=02A"]];
}


@end
