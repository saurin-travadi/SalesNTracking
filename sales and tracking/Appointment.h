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

@property (nonatomic, retain) NSString *apptDate;
@property (nonatomic, retain) NSString *numAppts;


-(id)initWithApptDate:(NSString *)date NumAppts:(NSString*)num;

@end
