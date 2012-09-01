//
//  CalendarViewController.h
//  sales and tracking
//
//  Created by Sejal Pandya on 8/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
#import "Kal.h"

@interface CalendarViewController : BaseUIViewController <UITableViewDataSource, UITableViewDelegate, KalDataSource> {
    dispatch_queue_t apptQueue; // offloads the query work to a background thread.
}

@property (nonatomic, retain) NSDate* selectedDate;

@end
