//
//  Jobs.m
//  sales and tracking
//
//  Created by Sejal Pandya on 8/31/12.
//
//

#import "Job.h"

@implementation Job

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
