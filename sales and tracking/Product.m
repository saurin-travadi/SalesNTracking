//
//  Product.m
//  sales and tracking
//
//  Created by Sejal Pandya on 6/19/12.
//
//

#import "Product.h"

@implementation Product

@synthesize code=_code;
@synthesize descr=_descr;

-(id)initWithCode :(NSString*)cd Description:(NSString*)description {
    self = [super init];
    if (self) {
        
        _code=cd;
        _descr=description;
        
        return self;
    }
    return nil;
    
}

@end
