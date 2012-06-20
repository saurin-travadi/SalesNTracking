//
//  Disposition.h
//  sales and tracking
//
//  Created by Sejal Pandya on 6/19/12.
//
//

#import <Foundation/Foundation.h>

@interface Disposition : NSObject

@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *descr;

-(id)initWithCode :(NSString*)cd Description:(NSString*)description;
@end
