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
@synthesize productID1=_productID1;
@synthesize sale1=_sale1;
@synthesize productID2=_productID2;
@synthesize sale2=_sale2;
@synthesize productID3=_productID3;
@synthesize sale3=_sale3;
@synthesize productID4=_productID4;
@synthesize sale4=_sale4;
@synthesize productID5=_productID5;
@synthesize sale5=_sale5;
@synthesize disp=_disp;
@synthesize dispText=_dispText;
@synthesize source=_source;
@synthesize notes=_notes;
@synthesize canUpdateIndicator=_canUpdateIndicator;
@synthesize apptStatusCode=_apptStatusCode;

-(id)initWithAppointmentId:(NSString*)apptId Address:(NSString*)address Name:(NSString*)name CSZ:(NSString*)cSZInfo ApptDate:(NSString*)dateTime Phone:(NSString*)phoneNumber AltPhone:(NSString*)altPhoneNumber Source:(NSString*)sourceNumber Notes:(NSString*)notesData ProductId:(NSString *)product ProductId1:(NSString *)product1 ProductId2:(NSString *)product2 ProductId3:(NSString *)product3 ProductId4:(NSString *)product4 ProductId5:(NSString *)product5 Sale1:(NSString *)sale1 Sale2:(NSString *)sale2 Sale3:(NSString *)sale3 Sale4:(NSString *)sale4 Sale5:(NSString *)sale5 AltPhoneType:(NSString *)alterPhoneType CanUpdate:(NSString*)canUpdate ApptStatus:(NSString*)statusCode Disposition:(NSString *)disposition DispositionText:(NSString*)dispositionText {
    
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
        _productID1=product1;
        _sale1=sale1;
        _productID2=product2;
        _sale2=sale2;
        _productID3=product3;
        _sale3=sale3;
        _productID4=product4;
        _sale4=sale4;
        _productID5=product5;
        _sale5=sale5;
        _source=sourceNumber;
        _notes=notesData;
        _disp=disposition;
        _dispText=dispositionText;
        
        _canUpdateIndicator=[canUpdate boolValue];
        _apptStatusCode=statusCode;
        
        return self;
    }
    return nil;
}

@end
