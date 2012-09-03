//
//  SalesDetailsViewController.h
//  sales and tracking
//
//  Created by Sejal Pandya on 9/3/12.
//
//

#import "BaseUIViewController.h"

@interface SalesDetailsViewController : BaseUIViewController

@property  (nonatomic,retain) NSString* selectedJobId;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *altPhoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *productLabel;
@property (strong, nonatomic) IBOutlet UILabel *saleDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *saleDollarLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobStatusLabel;

@property (strong, nonatomic) IBOutlet UIButton *phoneButton;
@property (strong, nonatomic) IBOutlet UIButton *altPhoneButton;
@property (strong, nonatomic) IBOutlet UILabel *altPhoneTypeLabel;

-(IBAction)phoneMade:(id)sender;

@end
