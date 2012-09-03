//
//  MySales.m
//  sales and tracking
//
//  Created by Sejal Pandya on 9/3/12.
//
//

#import "MySales.h"

@implementation MySales


@synthesize jobID=_jobID;
@synthesize custName=_custName;
@synthesize productID=_productID;
@synthesize contractDate=_contractDate;
@synthesize grossAmount=_grossAmount;
@synthesize jobStatusDescr=_jobStatusDescr;

@synthesize address=_address;
@synthesize cSZ = _cSZ;
@synthesize phone=_phone;
@synthesize altPhone=_altPhone;
@synthesize altPhoneType=_altPhoneType;

-(id)initWithJobId:(NSString*)job CustomerName:(NSString*)name ProductId:(NSString*)product SaleDate:(NSString*)saleDate SaleAmt:(NSString*)saleAmt JobStatus:(NSString*)jobStatus {

    self = [super init];
    if (self) {
        
        _jobID=job;
        _custName=name;
        _productID=product;
        _contractDate=saleDate;
        _grossAmount=saleAmt;
        _jobStatusDescr=jobStatus;
        
        return self;
    }
    return nil;

}

-(id)initDetailWithJobId:(NSString*)job CustomerName:(NSString*)name ProductId:(NSString*)product SaleDate:(NSString*)saleDate SaleAmt:(NSString*)saleAmt JobStatus:(NSString*)jobStatus Address:(NSString*)address CSZ:(NSString*)cityInfo Phone:(NSString*)phoneNumber AltPhone:(NSString*)altPhoneNumber AltPhoneType:(NSString*)altPhoneNumberType {

    self = [super init];
    if (self) {
        
        _jobID=job;
        _custName=name;
        _productID=product;
        _contractDate=saleDate;
        _grossAmount=saleAmt;
        _jobStatusDescr=jobStatus;
        _address=address;
        _cSZ=cityInfo;
        _phone=phoneNumber;
        _altPhone=altPhoneNumber;
        _altPhoneType=altPhoneNumberType;
        
        return self;
    }
    return nil;

    
}

@end
