//
//  AppointmentUpdateViewController.h
//  sales and tracking
//
//  Created by Sejal Pandya on 9/6/12.
//
//

#import "BaseUIViewController.h"

@interface AppointmentUpdateViewController : BaseUIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) NSString* dateTime;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* address;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) NSString* apptId;

@property (strong, nonatomic) IBOutlet UIScrollView *mainContainer;
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;


@property (strong, nonatomic) IBOutlet UITextField *dispositionText;

@property (strong, nonatomic) IBOutlet UITextField *saleText;
@property (strong, nonatomic) IBOutlet UITextField *productText;
@property (strong, nonatomic) IBOutlet UIView *viewContainer;

@property (strong, nonatomic) IBOutlet UITextField *saleText1;
@property (strong, nonatomic) IBOutlet UITextField *productText1;
@property (strong, nonatomic) IBOutlet UIView *viewContainer1;

@property (strong, nonatomic) IBOutlet UITextField *saleText2;
@property (strong, nonatomic) IBOutlet UITextField *productText2;
@property (strong, nonatomic) IBOutlet UIView *viewContainer2;

@property (strong, nonatomic) IBOutlet UITextField *saleText3;
@property (strong, nonatomic) IBOutlet UITextField *productText3;
@property (strong, nonatomic) IBOutlet UIView *viewContainer3;

@property (strong, nonatomic) IBOutlet UITextField *saleText4;
@property (strong, nonatomic) IBOutlet UITextField *productText4;
@property (strong, nonatomic) IBOutlet UIView *viewContainer4;

@property (strong, nonatomic) IBOutlet UITextView *comments;
@property (strong,nonatomic) IBOutlet UIButton *btnUpdate;

-(IBAction)update:(id)sender;


@end
