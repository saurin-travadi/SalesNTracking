//
//  MyStat.m
//  sales and tracking
//
//  Created by Sejal Pandya on 9/1/12.
//
//

#import "MyStat.h"

@implementation MyStat

@synthesize numIssued=_numIssued;
@synthesize numDemo=_numDemo;
@synthesize numSale=_numSale;
@synthesize grossAmount=_grossAmount;
@synthesize netAmount=_netAmount;
@synthesize demoRate=_demoRate;
@synthesize closingRate=_closingRate;

@synthesize descr=_descr;
@synthesize statValue=_statValue;

-(id)initWithDesc:(NSString*)description StatValue:(NSString*)stat {

    self = [super init];
    if (self) {

        _descr=description;
        _statValue=stat;

        return self;
    }
    return nil;
}

@end
