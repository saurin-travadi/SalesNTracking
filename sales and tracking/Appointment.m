//
//  Customer.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Appointment.h"

@implementation Appointment

@synthesize apptDate=_apptDate;
@synthesize numAppts=_numAppts;


-(id)initWithApptDate:(NSString *)date NumAppts:(NSString*)num {
    
    self = [super init];
    if (self) {
        _apptDate=date;
        _numAppts=num;
        
        return self;
    }
    return nil;
    
}

@end
