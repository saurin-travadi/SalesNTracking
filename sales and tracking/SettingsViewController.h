//
//  SettingsViewController.h
//  sales and tracking
//
//  Created by Sejal Pandya on 9/4/12.
//
//

#import "BaseUIViewController.h"
#import "NextUITextField.h"

@interface SettingsViewController : BaseUIViewController

@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) IBOutlet NextUITextField *clientId;
@property (strong, nonatomic) IBOutlet NextUITextField *siteURL;

@property (strong, nonatomic) IBOutlet UIButton *logOut;
- (IBAction)logout:(id)sender;
@end
