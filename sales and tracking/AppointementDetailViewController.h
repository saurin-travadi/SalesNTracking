//
//  AppointementDetailViewController.h
//  sales and tracking
//
//  Created by Sejal Pandya on 8/31/12.
//
//

#import "BaseUIViewController.h"
#import "ServiceConsumer.h"

@interface AppointementDetailViewController : BaseUIViewController

@property (nonatomic, retain) NSString* appDateTime;
@property (nonatomic, retain) NSString* apptId;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *altPhoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *sourceLabel;
@property (strong, nonatomic) IBOutlet UILabel *notesLabel;

@end
