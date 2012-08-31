//
//  ServiceConsumer.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceConsumer.h"
#import "JSON.h"
#import "Appointment.h"

@implementation ServiceConsumer


-(void)getEmployees:(UserInfo *)userInfo :(void (^)(bool*))Success {
    
    _OnLoginSuccess = [Success copy];
    
    NSString *soapMsg = @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetEmployees xmlns=\"http://webservice.leadperfection.com/\" /></soap:Body></soap:Envelope>";
    
    NSURL *url = [NSURL URLWithString: @"http://lptest.leadperfection.com/batch/lpservice.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetEmployees" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"GetEmployeesResult" Request:req :^(id json) {
        NSLog(@"%@",[json description]);
        
        bool success = true;
        _OnLoginSuccess(&success);
    } :^(NSError *error) {
        
        bool success = false;
        _OnLoginSuccess(&success);
    }];    
}

-(void)performLogin:(UserInfo *)userInfo :(void (^)(bool*))Success {
    
    _OnLoginSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?> <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"> <soap:Body> <ValidateLogin xmlns=\"http://webservice.leadperfection.com/\"> <clientid>%@</clientid> <username>%@</username> <password>%@</password> </ValidateLogin> </soap:Body> </soap:Envelope>",userInfo.clientID,userInfo.userName,userInfo.password];
    
    NSURL *url = [NSURL URLWithString: @"http://lptest.leadperfection.com/batch/lpservice.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/ValidateLogin" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"ValidateLoginResult" Request:req :^(id json) {
        NSString* result = [NSString stringWithFormat:@"%@",[json description]];
        
        bool success = true;
        if([result isEqualToString:@"\"NOT VALID USER\""])
            success=false;
        
        _OnLoginSuccess(&success);
    } :^(NSError *error) {
        
        bool success = false;
        _OnLoginSuccess(&success);
    }];
}

-(void)getLoginMessages:(UserInfo *)userInfo :(void (^)(id))Success {
    
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SalesLoginMessage xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password></SalesLoginMessage></soap:Body></soap:Envelope>",userInfo.clientID,userInfo.userName,userInfo.password];
    
    NSURL *url = [NSURL URLWithString: @"http://lptest.leadperfection.com/batch/lpservice.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/SalesLoginMessage" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"SalesLoginMessageResult" Request:req :^(id json) {
        NSLog(@"%@",[json description]);
        
        NSMutableArray *messages = [[NSMutableArray alloc] init];
        
        NSArray *result = [json JSONValue];
        for (id obj in result) {
            
            [messages addObject:[obj valueForKey:@"Message"]];
        }
        
        _OnSearchSuccess(messages);
        
    } :^(NSError *error) {
        
        
        _OnSearchSuccess(nil);
    }];
}

-(void)getSalesAppointments:(UserInfo *)userInfo :(void (^)(id))Success {
    
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSalesApptCal xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password></GetSalesApptCal></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password];

    
    NSURL *url = [NSURL URLWithString: @"http://lptest.leadperfection.com/batch/lpservice.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetSalesApptCal" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"GetSalesApptCalResponse" Request:req :^(id json) {
        NSLog(@"%@",[json description]);
        
        NSMutableArray *appointments = [[NSMutableArray alloc] init];
        
        NSArray *result = [json JSONValue];
        for (id obj in result) {
            
            Appointment *appt = [[Appointment alloc] initWithApptDate: [obj valueForKey:@"ApptDate"] NumAppts:[obj valueForKey:@"NumAppts"]];
            [appointments addObject:appt];
        }
        
        _OnSearchSuccess(appointments);
        
    } :^(NSError *error) {
        
        _OnSearchSuccess(nil);
    }];
}

-(void)getSalesAppointmentsByDate:(NSString*)dateTime withUserInfo:(UserInfo *)userInfo :(void (^)(id))Success
{
    _OnSearchSuccess = [Success copy];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"MM/dd/yyyyTHH:mm:ss"];
    
    NSDate *formatterDate = [inputFormatter dateFromString:@"06/18/2012T00:00:00"];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSalesApptDayList xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password><apptdate>%@</apptdate></GetSalesApptDayList></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password,@"2012-06-18T12:00:00"];
    
    
    NSURL *url = [NSURL URLWithString: @"http://lptest.leadperfection.com/batch/lpservice.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetSalesApptDayList" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"GetSalesApptDayListResponse" Request:req :^(id json) {
        NSLog(@"%@",[json description]);
        
//        NSMutableArray *appointments = [[NSMutableArray alloc] init];
//        
//        NSArray *result = [json JSONValue];
//        for (id obj in result) {
//            
//            Appointment *appt = [[Appointment alloc] initWithApptDate: [obj valueForKey:@"ApptDate"] NumAppts:[obj valueForKey:@"NumAppts"]];
//            [appointments addObject:appt];
//        }
        
        _OnSearchSuccess(nil);
        
    } :^(NSError *error) {
        NSLog(@"%@",[error description]);
        _OnSearchSuccess(nil);
    }];

}

@end
