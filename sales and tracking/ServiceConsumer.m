//
//  ServiceConsumer.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceConsumer.h"
#import "Utility.h"
#import "AppDelegate.h"

@implementation ServiceConsumer {
    NSString *baseURL;
}

-(id)init {
    self = [super init];
    if (self) {
        
        baseURL = [Utility retrieveFromUserDefaults:@"baseurl_preference"];
        if([baseURL isEqualToString:@""]) {
            [super missingBaseUrl];
            return nil;
        }
            
        return self;
    }
    return nil;
}

-(id)initWithoutBaseURL {
    self = [super init];
    if (self) {
        return self;
    }
    return nil;
}

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


-(void)registerUser:(NSString*)userName Password:(NSString*)pwd ClientId:(NSString*)clientId SiteURL:(NSString*)url EmailAddress:(NSString*)email :(void (^)(bool*))Success {

        
    _OnLoginSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?> <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"> <soap:Body> <ValidateLogin xmlns=\"http://webservice.leadperfection.com/\"> <clientid>%@</clientid> <username>%@</username> <password>%@</password> <email>%@</email></ValidateLogin> </soap:Body> </soap:Envelope>",clientId,userName,pwd,email];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]];
    
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

-(void)performLogin:(UserInfo *)userInfo :(void (^)(bool*))Success {
    
    _OnLoginSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?> <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"> <soap:Body> <ValidateLogin xmlns=\"http://webservice.leadperfection.com/\"> <clientid>%@</clientid> <username>%@</username> <password>%@</password> </ValidateLogin> </soap:Body> </soap:Envelope>",userInfo.clientID,userInfo.userName,userInfo.password];
    
    NSURL *url = [NSURL URLWithString: baseURL];
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
    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/SalesLoginMessage" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"SalesLoginMessageResult" Request:req :^(id json) {
        NSMutableArray *messages = [[NSMutableArray alloc] init];
      
//        AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
//        int j = app.getNext;
//        for(int x=j; x>0; x--){
//
//            NSMutableArray *data = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%d",rand()*rand()],[NSString stringWithFormat:@"%d",x*x], [[NSDate date] description] , nil];
//            [messages addObject: data ];
//        }
        
        NSArray *result = [json JSONValue];
        for (id obj in result) {
            
            NSMutableArray *data = [NSMutableArray arrayWithObjects:[obj valueForKey:@"Message"],[obj valueForKey:@"From"],[obj valueForKey:@"MessageDateDisplay"], nil];
            [messages addObject: data];
        }
        
        
        _OnSearchSuccess(messages);
        
    } :^(NSError *error) {
        
        
        _OnSearchSuccess(nil);
    }];
}

-(void)getSalesAppointments:(UserInfo *)userInfo :(void (^)(id))Success {
    
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSalesApptCal xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password></GetSalesApptCal></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password];

    
    NSURL *url = [NSURL URLWithString: baseURL];
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
    
    
    NSURL *url = [NSURL URLWithString: baseURL];
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
                                                                  ApptDate:[obj valueForKey:@"ApptDate"]
                                                                 DisplayDate:[obj valueForKey:@"ApptDateDisplay"]];
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

    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetSalesApptDetail" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"GetSalesApptDetailResult" Request:req :^(id json) {
        
        NSLog(@"%@",[json description]);

        NSArray *result = [json JSONValue];
        AppointementDetail *appointment;
        for (id obj in result) {
            
            appointment = [[AppointementDetail alloc] initWithAppointmentId:[obj valueForKey:@"ID"]
                                                                    Address:[obj valueForKey:@"Address1"]
                                                                       Name:[obj valueForKey:@"CustName"]
                                                                        CSZ:[obj valueForKey:@"CSZ"]
                                                                   ApptDate:[obj valueForKey:@"ApptDate"]
                                                                    ApptDisplayDate:[obj valueForKey:@"ApptDateDisplay"]
                                                                      Phone:[obj valueForKey:@"Phone"]
                                                                   AltPhone:[obj valueForKey:@"AltPhone1"]
                                                                     Source:[obj valueForKey:@"Source"]
                                                                      Notes:[obj valueForKey:@"Notes"]
                                                                  ProductId:[obj valueForKey:@"ProductID"]
                                                                 ProductId1:[obj valueForKey:@"ProductID1"]
                                                                 ProductId2:[obj valueForKey:@"ProductID2"]
                                                                 ProductId3:[obj valueForKey:@"ProductID3"]
                                                                 ProductId4:[obj valueForKey:@"ProductID4"]
                                                                 ProductId5:[obj valueForKey:@"ProductID5"]
                                                                      Sale1:[obj valueForKey:@"GSA1"]
                                                                      Sale2:[obj valueForKey:@"GSA2"]
                                                                      Sale3:[obj valueForKey:@"GSA3"]
                                                                      Sale4:[obj valueForKey:@"GSA4"]
                                                                      Sale5:[obj valueForKey:@"GSA5"]
                                                               AltPhoneType:[obj valueForKey:@"AltPhone1Type"]
                                                                  CanUpdate:[obj valueForKey:@"CanUpdateIndicator"]
                                                                 ApptStatus:[obj valueForKey:@"ApptStatusCode"]
                                                                   Disp:[obj valueForKey:@"Disposition"]
                                                                Disposition:[obj valueForKey:@"DispositionComments"]
                                                            PresNotes:[obj valueForKey:@"PresNotes"]];

            
            //check previous value of hash to determine refreshing cached version of data
            NSString * strHash = [[[Utility alloc] init] retrieveFromUserSavedData:@"HshDisposition"];
            if(![strHash isEqualToString:[obj valueForKey:@"HshDisposition"]] ){
                [[Utility alloc] saveToUserSavedDataWithKey:@"Dispositions" Data:@""];
            }
            
            strHash = [[[Utility alloc] init] retrieveFromUserSavedData:@"HshProduct"];
            if(![strHash isEqualToString:[obj valueForKey:@"HshProduct"]] ){
                [[Utility alloc] saveToUserSavedDataWithKey:@"Products" Data:@""];
            }
            
            //now store hash for disposition and products to be compared in future for refreshing cached version of data
            [[[Utility alloc] init] saveToUserSavedDataWithKey:@"HshDisposition" Data:[obj valueForKey:@"HshDisposition"]];
            [[[Utility alloc] init] saveToUserSavedDataWithKey:@"HshProduct" Data:[obj valueForKey:@"HshProduct"]];
        }
        
        _OnSearchSuccess(appointment);
        
    } :^(NSError *error) {
        NSLog(@"%@",[error description]);
        _OnSearchSuccess(nil);
    }];
    
}

-(void)getSalesStatsByUser: (UserInfo *)userInfo :(void (^)(id))Success {
    
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSalesMyStat xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password></GetSalesMyStat></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password];
    
    NSURL *url = [NSURL URLWithString: baseURL];
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

-(void)getSalesStatsForUser: (UserInfo *)userInfo :(void (^)(id))Success {
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSalesStats xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password></GetSalesStats></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password];
    

    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetSalesStats" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"GetSalesStatsResponse" Request:req :^(id json) {

        NSMutableArray *stats = [[NSMutableArray alloc] init];
        
        NSArray *result = [json JSONValue];
        for (id obj in result) {
            
            MyStat *stat = [[MyStat alloc] initWithDesc:[obj valueForKey:@"Descr"] StatValue:[obj valueForKey:@"StatValue"]];
            [stats addObject:stat];
        }

        _OnSearchSuccess(stats);
        
    } :^(NSError *error) {
        NSLog(@"%@",[error description]);
        _OnSearchSuccess(nil);
    }];

}

-(void)acknowledgeAppointmentId:(NSString *)apptId withUserInfo:(UserInfo *)userInfo :(void (^)(id))Success {
    
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UpdateSalesAck xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password><issuedleadid>%d</issuedleadid></UpdateSalesAck></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password,[apptId intValue]];
    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/UpdateSalesAck" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"UpdateSalesAckResponse" Request:req :^(id json) {

        _OnSearchSuccess([json description]);
        
    } :^(NSError *error) {
        NSLog(@"%@",[error description]);
        _OnSearchSuccess(nil);
    }];

}

-(void)getSalesTrackingForUser: (UserInfo *)userInfo :(void (^)(id))Success {
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSalesOpen xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password></GetSalesOpen></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password];
    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetSalesOpen" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"GetSalesOpenResponse" Request:req :^(id json) {

        NSMutableArray *sales = [[NSMutableArray alloc] init];
        
        NSArray *result = [json JSONValue];
        for (id obj in result) {
            
            MySales *sale = [[MySales alloc] initWithJobId:[obj valueForKey:@"JobID"] CustomerName:[obj valueForKey:@"CustName"] ProductId:[obj valueForKey:@"ProductID"] SaleDate:[obj valueForKey:@"ContractDate"] SaleDisplayDate:[obj valueForKey:@"ContractDateDisplay"] SaleAmt:[obj valueForKey:@"GrossAmount"] JobStatus:[obj valueForKey:@"JobStatusDescr"]];
            
            [sales addObject:sale];
        }
        
        _OnSearchSuccess(sales);
        
    } :^(NSError *error) {
        NSLog(@"%@",[error description]);
        _OnSearchSuccess(nil);
    }];

}

-(void)getJobDetailsById: (NSString*)jobId withUserInof:(UserInfo *)userInfo :(void (^)(id))Success {
    
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSalesJobDetail xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password><jobid>%d</jobid></GetSalesJobDetail></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password, [jobId intValue]];
    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetSalesJobDetail" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"GetSalesJobDetailResponse" Request:req :^(id json) {
        
        MySales *sale;
        NSArray *result = [json JSONValue];
        for (id obj in result) {
            
            sale = [[MySales alloc] initDetailWithJobId:[obj valueForKey:@"JobID"] CustomerName:[obj valueForKey:@"CustName"] ProductId:[obj valueForKey:@"ProductID"] SaleDate:[obj valueForKey:@"ContractDate"] SaleDisplayDate:[obj valueForKey:@"ContractDateDisplay"] SaleAmt:[obj valueForKey:@"GrossAmount"] JobStatus:[obj valueForKey:@"JobStatusDescr"] Address:[obj valueForKey:@"Address1"] CSZ:[obj valueForKey:@"CSZ"] Phone:[obj valueForKey:@"Phone"] AltPhone:[obj valueForKey:@"AltPhone1"] AltPhoneType:[obj valueForKey:@"AltPhone1Type"]];
            
        }
        
        _OnSearchSuccess(sale);
        
    } :^(NSError *error) {
        NSLog(@"%@",[error description]);
        _OnSearchSuccess(nil);
    }];

}

-(void)getDispositionsByUser :(UserInfo*)userInfo :(void (^)(id))success {
    _OnSearchSuccess = [success copy];
    
    NSString *jsonString = [[Utility alloc] retrieveFromUserSavedData:@"Dispositions"];
    
    if(jsonString==NULL || [jsonString isEqualToString:@""])
    {           //get from DB and store in cache
        NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSalesApptDispProd xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password><type>%@</type></GetSalesApptDispProd></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password, @"d"];
        
        NSURL *url = [NSURL URLWithString: baseURL];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
        [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [req addValue:@"http://webservice.leadperfection.com/GetSalesApptDispProd" forHTTPHeaderField:@"SOAPAction"];
        [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
        
        [self getDataForElement:@"GetSalesApptDispProdResponse" Request:req :^(id json) {
                
            NSLog(@"%@",[json description]);
            
            [[Utility alloc] saveToUserSavedDataWithKey:@"Dispositions" Data:[json description]];

            NSMutableArray *disps = [[NSMutableArray alloc] init];
            NSArray *result = [json JSONValue];
            for (id obj in result) {
                
                Disposition *disp = [[Disposition alloc] initWithCode:[obj valueForKey:@"key"] Description: [obj valueForKey:@"value"]];
                [disps addObject:disp];
            }
            
            _OnSearchSuccess(disps);
            
        } :^(NSError *error) {
            
            NSLog(@"%@",[error description]);
            _OnSearchSuccess(nil);
        }];
    }
    else{       //returned from cached copy
        NSMutableArray *disps = [[NSMutableArray alloc] init];
        NSArray *result = [jsonString JSONValue];
        for (id obj in result) {
            
            Disposition *disp = [[Disposition alloc] initWithCode:[obj valueForKey:@"key"] Description: [obj valueForKey:@"value"]];
            [disps addObject:disp];
        }
        
        _OnSearchSuccess(disps);

    }
}

-(void)getProductsByUser :(UserInfo*)userInfo :(void (^)(id))success {
    _OnSearchSuccess = [success copy];
    
    NSString *jsonString = [[Utility alloc] retrieveFromUserSavedData:@"Products"];
    
    if(jsonString==NULL || [jsonString isEqualToString:@""])
    {           //get from DB and store in cache
        NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSalesApptDispProd xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password><type>%@</type></GetSalesApptDispProd></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password, @"p"];
        
        NSURL *url = [NSURL URLWithString: baseURL];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
        [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [req addValue:@"http://webservice.leadperfection.com/GetSalesApptDispProd" forHTTPHeaderField:@"SOAPAction"];
        [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
        
        [self getDataForElement:@"GetSalesApptDispProdResponse" Request:req :^(id json) {
            
            [[Utility alloc] saveToUserSavedDataWithKey:@"Products" Data:[json description]];
            
            NSMutableArray *prods = [[NSMutableArray alloc] init];
            NSArray *result = [json JSONValue];
            for (id obj in result) {
                
                Product *prd = [[Product alloc] initWithCode:[obj valueForKey:@"key"] Description: [obj valueForKey:@"value"]];
                [prods addObject:prd];
            }
            
            _OnSearchSuccess(prods);
            
        } :^(NSError *error) {
            NSLog(@"%@",[error description]);
            _OnSearchSuccess(nil);
        }];
    }
    else{       //returned from cached copy
        NSMutableArray *prods = [[NSMutableArray alloc] init];
        NSArray *result = [jsonString JSONValue];
        for (id obj in result) {
            
            Product *prd = [[Product alloc] initWithCode:[obj valueForKey:@"key"] Description: [obj valueForKey:@"value"]];
            [prods addObject:prd];
        }
        
        _OnSearchSuccess(prods);
    }
}

-(void)updateAppointmentId:(NSString*)apptId withUserInfo:(UserInfo *)userInfo Disposition:(NSString*)dispositionText Products:(id)products Sales:(id)sales Comments:(NSString*)comments :(void (^)(id))Success {
    
    _OnSearchSuccess = [Success copy];

    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UpdateSalesApptDetail xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password><issuedleadid>%d</issuedleadid><disposition>%@</disposition><productid1>%@</productid1><gsa1>%f</gsa1><productid2>%@</productid2><gsa2>%f</gsa2><productid3>%@</productid3><gsa3>%f</gsa3><productid4>%@</productid4><gsa4>%f</gsa4><productid5>%@</productid5><gsa5>%f</gsa5><presnotes>%@</presnotes></UpdateSalesApptDetail></soap:Body></soap:Envelope>", userInfo.clientID,userInfo.userName,userInfo.password,[apptId intValue],dispositionText,[products objectAtIndex:0],[[sales objectAtIndex:0] doubleValue],[products objectAtIndex:1],[[sales objectAtIndex:1] doubleValue],[products objectAtIndex:2],[[sales objectAtIndex:2] doubleValue],[products objectAtIndex:3],[[sales objectAtIndex:3] doubleValue],[products objectAtIndex:4],[[sales objectAtIndex:4] doubleValue],comments];
    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/UpdateSalesApptDetail" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"UpdateSalesApptDetailResult" Request:req :^(id json) {
    
        _OnSearchSuccess([json description]);
        
    } :^(NSError *error) {
        NSLog(@"%@",[error description]);
        _OnSearchSuccess(nil);
    }];

}



@end






