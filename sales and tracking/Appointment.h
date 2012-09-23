//
//  Customer.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Consumer.h"

@interface Appointment : Consumer

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *custName;
@property (nonatomic, retain) NSString *cSZ;
@property (nonatomic, retain) NSString *apptDate;
@property (nonatomic, retain) NSString *apptDisplayDate;

-(id)initWithAppointmentId:(NSString*)apptId CustomerName:(NSString*)name Address:(NSString*)address ApptDate:(NSString *)date DisplayDate:(NSString *)displayDate;

@end
