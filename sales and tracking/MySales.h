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
@property (nonatomic, retain) NSString *contractDisplayDate;
@property (nonatomic, retain) NSString *grossAmount;
@property (nonatomic, retain) NSString *jobStatusDescr;

@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *cSZ;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *altPhone;
@property (nonatomic, retain) NSString *altPhoneType;

-(id)initWithJobId:(NSString*)job CustomerName:(NSString*)name ProductId:(NSString*)product SaleDate:(NSString*)saleDate SaleDisplayDate:(NSString*)saleDisplayDate SaleAmt:(NSString*)saleAmt JobStatus:(NSString*)jobStatus;

-(id)initDetailWithJobId:(NSString*)job CustomerName:(NSString*)name ProductId:(NSString*)product SaleDate:(NSString*)saleDate SaleDisplayDate:(NSString*)saleDisplayDate SaleAmt:(NSString*)saleAmt JobStatus:(NSString*)jobStatus Address:(NSString*)address CSZ:(NSString*)cityInfo Phone:(NSString*)phoneNumber AltPhone:(NSString*)altPhoneNumber AltPhoneType:(NSString*)altPhoneNumberType;

@end
