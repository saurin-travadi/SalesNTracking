//
//  Customer.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Appointment.h"

@implementation Appointment

@synthesize id = _id;
@synthesize custName =_custName;
@synthesize cSZ = _cSZ;
@synthesize apptDate=_apptDate;


-(id)initWithAppointmentId:(NSString*)apptId CustomerName:(NSString*)name Address:(NSString*)address ApptDate:(NSString *)date {
    
    self = [super init];
    if (self) {
        _id=apptId;
        _custName=name;
        _cSZ=address;
        _apptDate=date;
        
        return self;
    }
    return nil;
}

@end
