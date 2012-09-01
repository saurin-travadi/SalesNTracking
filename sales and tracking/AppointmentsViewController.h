//
//  AppointmentsViewController.h
//  sales and tracking
//
//  Created by Sejal Pandya on 8/29/12.
//
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
#import "AppointementDetail.h"

@interface AppointmentsViewController : BaseUIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSString *dateTime;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
