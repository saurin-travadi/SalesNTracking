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
@property (nonatomic, retain) NSString *altPhoneType;
@property (nonatomic, retain) NSString *productID;

@property (nonatomic, retain) NSString *productID1;
@property (nonatomic, retain) NSString *sale1;

@property (nonatomic, retain) NSString *productID2;
@property (nonatomic, retain) NSString *sale2;

@property (nonatomic, retain) NSString *productID3;
@property (nonatomic, retain) NSString *sale3;

@property (nonatomic, retain) NSString *productID4;
@property (nonatomic, retain) NSString *sale4;

@property (nonatomic, retain) NSString *productID5;
@property (nonatomic, retain) NSString *sale5;

@property (nonatomic, retain) NSString *disp;
@property (nonatomic, retain) NSString *presNotes;

@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) NSString *notes;
@property BOOL canUpdateIndicator;
@property (nonatomic, retain) NSString *apptStatusCode;

-(id)initWithAppointmentId:(NSString*)apptId Address:(NSString*)address Name:(NSString*)name CSZ:(NSString*)cSZInfo ApptDate:(NSString*)dateTime Phone:(NSString*)phoneNumber AltPhone:(NSString*)altPhoneNumber Source:(NSString*)sourceNumber Notes:(NSString*)notesData ProductId:(NSString *)product ProductId1:(NSString *)product1 ProductId2:(NSString *)product2 ProductId3:(NSString *)product3 ProductId4:(NSString *)product4 ProductId5:(NSString *)product5 Sale1:(NSString *)sale1 Sale2:(NSString *)sale2 Sale3:(NSString *)sale3 Sale4:(NSString *)sale4 Sale5:(NSString *)sale5 AltPhoneType:(NSString *)alterPhoneType CanUpdate:(NSString*)canUpdate ApptStatus:(NSString*)statusCode Disposition:(NSString *)disposition PresNotes:(NSString*)notes;

@end
