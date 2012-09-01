//
//  AppointementDetail.h
//  sales and tracking
//
//  Created by Sejal Pandya on 8/31/12.
//
//

#import <Foundation/Foundation.h>
#import "ServiceConsumer.h"

@interface AppointementDetail : NSObject

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *custName;
@property (nonatomic, retain) NSString *cSZ;
@property (nonatomic, retain) NSString *apptDate;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *altPhone;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) NSString *notes;

-(id)initWithAppointmentId:(NSString*)apptId Address:(NSString*)address Name:(NSString*)name CSZ:(NSString*)cSZInfo ApptDate:(NSString*)dateTime Phone:(NSString*)phoneNumber AltPhone:(NSString*)altPhoneNumber Source:(NSString*)sourceNumber Notes:(NSString*)notesData;
@end
