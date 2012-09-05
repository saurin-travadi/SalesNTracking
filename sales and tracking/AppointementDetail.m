//
//  AppointementDetail.m
//  sales and tracking
//
//  Created by Sejal Pandya on 8/31/12.
//
//

#import "AppointementDetail.h"

@implementation AppointementDetail

@synthesize id =_id;
@synthesize address=_address;
@synthesize custName=_custName;
@synthesize cSZ=_cSZ;
@synthesize apptDate=_apptDate;
@synthesize phone=_phone;
@synthesize altPhone=_altPhone;
@synthesize altPhoneType=_altPhoneType;
@synthesize productID=_productID;
@synthesize source=_source;
@synthesize notes=_notes;
@synthesize canUpdateIndicator=_canUpdateIndicator;
@synthesize apptStatusCode=_apptStatusCode;

-(id)initWithAppointmentId:(NSString*)apptId Address:(NSString*)address Name:(NSString*)name CSZ:(NSString*)cSZInfo ApptDate:(NSString*)dateTime Phone:(NSString*)phoneNumber AltPhone:(NSString*)altPhoneNumber Source:(NSString*)sourceNumber Notes:(NSString*)notesData ProductId:(NSString *)product AltPhoneType:(NSString *)alterPhoneType CanUpdate:(NSString*)canUpdate ApptStatus:(NSString*)statusCode{
    
    self = [super init];
    if (self) {
        
        _id=apptId;
        _custName=name;
        _cSZ=cSZInfo;
        _apptDate=dateTime;
        _address=address;
        _phone=phoneNumber;
        _altPhone=altPhoneNumber;
        _altPhoneType = alterPhoneType;
        _productID=product;
        _source=sourceNumber;
        _notes=notesData;
        
        _canUpdateIndicator=[canUpdate boolValue];
        _apptStatusCode=statusCode;
        
        return self;
    }
    return nil;
}

@end
