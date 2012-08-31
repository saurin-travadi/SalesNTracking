
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



@implementation BaseUIViewController

@synthesize baseUrl;


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
    
    [self loadDefaults];
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

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}

#pragma mark -
#pragma mark Public methods

- (void)loadDefaults {
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"LocalSettings.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"LocalSettings" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    baseUrl = [temp objectForKey:@"BaseUrl"];   
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
    
    NSError *error = nil;
    NSString *savedPassword = [SFHFKeychainUtils getPasswordForUsername:settingsUserName andServiceName:@"leadperfection" error:&error]; 
    
    UserInfo* currentUserInfo = [[UserInfo alloc] initWithUserName:settingsUserName Password:savedPassword ClientID:@"" SiteURL:@""];
    currentUserInfo.userName = settingsUserName;
    currentUserInfo.password = savedPassword;
    
    return currentUserInfo;
}


@end
