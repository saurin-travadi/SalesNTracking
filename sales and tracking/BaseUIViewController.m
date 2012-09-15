
//
//  BaseUIViewController.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseUIViewController.h"
#import "AppDelegate.h"
#import "SFHFKeychainUtils.h"
#import "LoginViewController.h"
#import "Utility.h"
#import "ServiceConsumer.h"

@implementation BaseUIViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    UINavigationController *nav = self.navigationController;
//    CGRect frame = nav.navigationBar.frame;
//    frame.size.height += 5;
//    self.navigationController.navigationBar.frame = frame;

    [self setTitle];
    
    
    //location service related code
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self setBackButton];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}

#pragma mark -
#pragma mark Public methods

-(void)setTitle {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor blackColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = self.navigationItem.title;
    [label sizeToFit];
}

-(void)setBackButton {

    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor orangeColor], UITextAttributeTextColor,
                                [UIColor blackColor], UITextAttributeTextShadowColor,
                                nil];
    

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.tintColor = [UIColor blackColor];
    backButton.title = @"Back";
    self.navigationItem.backBarButtonItem = backButton;

    [[UIBarButtonItem appearance] setTitleTextAttributes: attributes forState: UIControlStateNormal];
}

-(UIBarButtonItem*)setBarButton:(NSString*)title {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor orangeColor], UITextAttributeTextColor,
                                [UIColor blackColor], UITextAttributeTextShadowColor,
                                nil];
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] init];
    rightButton.tintColor = [UIColor blackColor];
    rightButton.title = title;
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [[UIBarButtonItem appearance] setTitleTextAttributes: attributes forState: UIControlStateNormal];
    
    return rightButton;
}

-(void)makeRoundRect:(UIButton*)sender {
     sender.layer.cornerRadius = 8.0;
}

-(void)makeRoundRectView:(UIView *)view {
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
}

-(void)setUserInfo:(UserInfo*)userInfo {
    NSString *localSettingsPath = ((AppDelegate *) [[UIApplication sharedApplication] delegate]).localSettingsPath;
    
    // Save to keychain
    NSError *error = nil;
    [SFHFKeychainUtils storeUsername:userInfo.userName andPassword:userInfo.password forServiceName:@"leadperfection" updateExisting:TRUE error:&error];
    
    // Save UserName to local settings
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: localSettingsPath];
    [data setObject:userInfo.userName forKey:@"UserName"];

    [data writeToFile: localSettingsPath atomically:YES];
}

-(UserInfo*)getUserInfo{
    
    NSString *localSettingsPath = ((AppDelegate *) [[UIApplication sharedApplication] delegate]).localSettingsPath;
    
    NSMutableDictionary *project = [[NSMutableDictionary alloc] initWithContentsOfFile: localSettingsPath];
    NSString *settingsUserName = [project objectForKey:@"UserName"];
    
    if(settingsUserName!=nil && settingsUserName!=@"") {

        NSError *error = nil;
        NSString *savedPassword = [SFHFKeychainUtils getPasswordForUsername:settingsUserName andServiceName:@"leadperfection" error:&error];

        UserInfo* currentUserInfo = [[UserInfo alloc] initWithUserName:settingsUserName Password:savedPassword ClientID:@"" SiteURL:@""];
        currentUserInfo.userName = settingsUserName;
        currentUserInfo.password = savedPassword;

        currentUserInfo.siteURL = [Utility retrieveFromUserDefaults:@"baseurl_preference"];
        currentUserInfo.clientID = [Utility retrieveFromUserDefaults:@"clientId_preference"];

        return currentUserInfo;
    }
    return nil;
}


-(void)logout {
    UserInfo* user = [self getUserInfo];
    
    NSError *error;
    
    [SFHFKeychainUtils deleteItemForUsername:user.userName andServiceName:@"leadperfection" error:&error];
    
    NSString *localSettingsPath = ((AppDelegate *) [[UIApplication sharedApplication] delegate]).localSettingsPath;
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: localSettingsPath];
    [data setObject:@"" forKey:@"UserName"];
    [data writeToFile: localSettingsPath atomically:YES];

    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        //do nothing
    }];
}

@end





