//
//  MyStat.h
//  sales and tracking
//
//  Created by Sejal Pandya on 9/1/12.
//
//

#import <Foundation/Foundation.h>
#import "Consumer.h"

@interface MyStat : Consumer

@property (nonatomic, retain) NSString *numIssued;
@property (nonatomic, retain) NSString *numDemo;
@property (nonatomic, retain) NSString *numSale;
@property (nonatomic, retain) NSString *grossAmount;
@property (nonatomic, retain) NSString *netAmount;
@property (nonatomic, retain) NSString *demoRate;
@property (nonatomic, retain) NSString *closingRate;

@end
