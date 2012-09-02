//
//  MyStatesViewController.h
//  sales and tracking
//
//  Created by Sejal Pandya on 9/1/12.
//
//

#import "BaseUIViewController.h"
#import "ServiceConsumer.h"

@interface MyStatsViewController : BaseUIViewController

@property (strong, nonatomic) IBOutlet UILabel *apptsLabel;
@property (strong, nonatomic) IBOutlet UILabel *demosLabel;
@property (strong, nonatomic) IBOutlet UILabel *demoRateLabel;
@property (strong, nonatomic) IBOutlet UILabel *salesLabel;
@property (strong, nonatomic) IBOutlet UILabel *closingRateLabel;
@property (strong, nonatomic) IBOutlet UILabel *grossVolumeLabel;
@property (strong, nonatomic) IBOutlet UILabel *netVolumeLabel;

@end
