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


@end
