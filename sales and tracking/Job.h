//
//  Jobs.h
//  sales and tracking
//
//  Created by Sejal Pandya on 8/31/12.
//
//

#import <Foundation/Foundation.h>
#import "Consumer.h"

@interface Job : Consumer

@property (nonatomic, retain) NSString *apptDate;
@property (nonatomic, retain) NSString *numAppts;


-(id)initWithApptDate:(NSString *)date NumAppts:(NSString*)num;

@end
