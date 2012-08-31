//
//  AppointmentsViewController.h
//  sales and tracking
//
//  Created by Sejal Pandya on 8/29/12.
//
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"

@interface AppointmentsViewController : BaseUIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
