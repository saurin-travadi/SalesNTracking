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

@implementation LoginViewController {
    NSString *pwd;
}

@synthesize logOnButton;
@synthesize userName, password, delegate, settingsView;
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
    settingsView.backgroundColor  =[UIColor clearColor];
    
    [super makeRoundRect:logOnButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UserInfo* user = [super getUserInfo];
    if(user==nil){
        pwd=@"";
        return;
    }
    else{                                           //we have user data saved, use it to logon
        [settingsView setHidden:YES];
        CGRect frame = logOnButton.frame;
        frame.origin.y -= settingsView.frame.size.height;
        logOnButton.frame = frame;
        
        userName.text = user.userName;
        
        if (user.password != NULL){
            pwd = user.password;
        }
        else
            pwd = @"";
    }
    if (![pwd isEqualToString:@""]){
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.dimBackground = YES;
        
        [self performSelector:@selector(performLogin) withObject:nil afterDelay:0.1];
    }
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [self setLogOnButton:nil];
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
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"homeSegue"]) {
        userName.text = @"";
        password.text = @"";
    }
}

-(void) performLogin{
    
    UserInfo *info = [[UserInfo alloc] initWithUserName:userName.text Password:pwd ClientID:@"" SiteURL:@"" ];
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
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [password resignFirstResponder];
    [userName resignFirstResponder];     
    
    pwd=password.text;
    password.text=@"";
    
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


@end
