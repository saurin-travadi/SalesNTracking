//
//  MySales.h
//  sales and tracking
//
//  Created by Sejal Pandya on 9/3/12.
//
//

#import <Foundation/Foundation.h>

@interface MySales : NSObject

@property (nonatomic, retain) NSString *jobID;
@property (nonatomic, retain) NSString *custName;
@property (nonatomic, retain) NSString *productID;
@property (nonatomic, retain) NSString *contractDate;
@property (nonatomic, retain) NSString *grossAmount;
@property (nonatomic, retain) NSString *jobStatusDescr;

-(id)initWithJobId:(NSString*)job CustomerName:(NSString*)name ProductId:(NSString*)product SaleDate:(NSString*)saleDate SaleAmt:(NSString*)saleAmt JobStatus:(NSString*)jobStatus;

@end
