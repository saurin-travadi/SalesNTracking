//
//  ServiceConsumer.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceConsumer.h"


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
        NSMutableArray *jobs = [[NSMutableArray alloc] init];
        
        NSArray *result = [json JSONValue];
        for (id obj in result) {
            
            Job *job = [[Job alloc] initWithApptDate: [obj valueForKey:@"ApptDate"] NumAppts:[obj valueForKey:@"NumAppts"]];
            [jobs addObject:job];
        }
        
        _OnSearchSuccess(jobs);
        
    } :^(NSError *error) {
        
        _OnSearchSuccess(nil);
    }];
}

-(void)getSalesAppointmentsByDate:(NSString*)dateTime withUserInfo:(UserInfo *)userInfo :(void (^)(id))Success {
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSalesApptDayList xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password><apptdate>%@</apptdate></GetSalesApptDayList></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password,dateTime];
    
    
    NSURL *url = [NSURL URLWithString: @"http://lptest.leadperfection.com/batch/lpservice.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetSalesApptDayList" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"GetSalesApptDayListResponse" Request:req :^(id json) {

        NSMutableArray *appointments = [[NSMutableArray alloc] init];
        
        NSArray *result = [json JSONValue];
        for (id obj in result) {
            
            Appointment *appt = [[Appointment alloc] initWithAppointmentId:[obj valueForKey:@"ID"]
                                                              CustomerName:[obj valueForKey:@"CustName"]==[NSNull null]?@"":[obj valueForKey:@"CustName"]
                                                                   Address:[obj valueForKey:@"CSZ"]==[NSNull null]?@"":[obj valueForKey:@"CSZ"]
                                                                  ApptDate:[obj valueForKey:@"ApptDate"]];
            [appointments addObject:appt];
        }
        
        _OnSearchSuccess(appointments);
        
    } :^(NSError *error) {
        NSLog(@"%@",[error description]);
        _OnSearchSuccess(nil);
    }];

}

-(void)getSalesAppointmentDetailById:(NSString*)apptId DateTime:(NSString*)dateTime withUserInfo:(UserInfo *)userInfo :(void (^)(id))Success {
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSalesApptDetail xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password><apptdate>%@</apptdate><issuedleadid>%d</issuedleadid></GetSalesApptDetail></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password,dateTime,[apptId intValue]];

    
    NSURL *url = [NSURL URLWithString: @"http://lptest.leadperfection.com/batch/lpservice.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetSalesApptDetail" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"GetSalesApptDetailResult" Request:req :^(id json) {
        
        NSArray *result = [json JSONValue];
        AppointementDetail *appointment;
        for (id obj in result) {
             appointment = [[AppointementDetail alloc] initWithAppointmentId:[obj valueForKey:@"ID"]
                                                                     Address:[obj valueForKey:@"Address1"]==[NSNull null]?@"":[obj valueForKey:@"Address1"]
                                                                        Name:[obj valueForKey:@"CustName"]==[NSNull null]?@"":[obj valueForKey:@"CustName"]
                                                                        CSZ:[obj valueForKey:@"CSZ"]==[NSNull null]?@"":[obj valueForKey:@"CSZ"]
                                                                    ApptDate:[obj valueForKey:@"ApptDate"]==[NSNull null]?@"":[obj valueForKey:@"ApptDate"]
                                                                       Phone:[obj valueForKey:@"Phone"]==[NSNull null]?@"":[obj valueForKey:@"Phone"]
                                                                    AltPhone:[obj valueForKey:@"AltPhone1"]==[NSNull null]?@"":[obj valueForKey:@"AltPhone1"]
                                                                      Source:[obj valueForKey:@"Source"]==[NSNull null]?@"":[obj valueForKey:@"Source"]
                                                                       Notes:[obj valueForKey:@"Notes"]==[NSNull null]?@"":[obj valueForKey:@"Notes"]];
        }
        
        _OnSearchSuccess(appointment);
        
    } :^(NSError *error) {
        NSLog(@"%@",[error description]);
        _OnSearchSuccess(nil);
    }];
    
}

-(void)getSalesStatesByUser: (UserInfo *)userInfo :(void (^)(id))Success {
    
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSalesMyStat xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password></GetSalesMyStat></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password];
    
    NSURL *url = [NSURL URLWithString: @"http://lptest.leadperfection.com/batch/lpservice.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetSalesMyStat" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"GetSalesMyStatResponse" Request:req :^(id json) {
        
        NSArray *result = [json JSONValue];

        MyStat *stat = [[MyStat alloc] init];
        for (id obj in result) {
            
            stat.numIssued=[obj valueForKey:@"NumIssued"]==[NSNull null]?@"":[[obj valueForKey:@"NumIssued"] description];
            stat.numDemo=[obj valueForKey:@"NumDemo"]==[NSNull null]?@"":[[obj valueForKey:@"NumDemo"] description];
            stat.numSale=[obj valueForKey:@"NumSale"]==[NSNull null]?@"":[[obj valueForKey:@"NumSale"] description];
            stat.grossAmount=[obj valueForKey:@"GrossAmount"]==[NSNull null]?@"":[[obj valueForKey:@"GrossAmount"] description];
            stat.netAmount=[obj valueForKey:@"NetAmount"]==[NSNull null]?@"":[[obj valueForKey:@"NetAmount"] description];
            stat.demoRate=[obj valueForKey:@"DemoRate"]==[NSNull null]?@"":[[obj valueForKey:@"DemoRate"] description];
            stat.closingRate=[obj valueForKey:@"ClosingRate"]==[NSNull null]?@"":[[obj valueForKey:@"ClosingRate"] description];
            
        }
        
        _OnSearchSuccess(stat);
        
    } :^(NSError *error) {
        NSLog(@"%@",[error description]);
        _OnSearchSuccess(nil);
    }];
 
}

@end






