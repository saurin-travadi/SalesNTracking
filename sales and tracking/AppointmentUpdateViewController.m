//
//  AppointmentUpdateViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 9/6/12.
//
//

#import "AppointmentUpdateViewController.h"
#import "NextUITextField.h"
#import "ServiceConsumer.h"
#import "Disposition.h"

@implementation AppointmentUpdateViewController {
    UIPickerView *picker;
    
    NSMutableArray *products;
    NSMutableArray *dispositions;
    
    UITextField *textBox;
}

@synthesize dateTime,name,address,city,apptId;

@synthesize mainContainer;
@synthesize dateTimeLabel, nameLabel, addressLabel, cityLabel;
@synthesize dispositionText, saleText, productText, viewContainer;
@synthesize saleText1, productText1, viewContainer1;
@synthesize saleText2, productText2, viewContainer2;
@synthesize saleText3, productText3, viewContainer3;
@synthesize saleText4, productText4, viewContainer4;
@synthesize comments;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [super makeRoundRectView:viewContainer];
    [super makeRoundRectView:viewContainer1];
    [super makeRoundRectView:viewContainer2];
    [super makeRoundRectView:viewContainer3];
    [super makeRoundRectView:viewContainer4];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 240, 320, 100)];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator=YES;

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [mainContainer addGestureRecognizer:singleTap];
    
    dateTimeLabel.text = dateTime;
    nameLabel.text=name;
    addressLabel.text=address;
    cityLabel.text=city;
}

-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    mainContainer.frame = self.view.bounds;
    mainContainer.contentSize = CGSizeMake(self.view.bounds.size.width, 885);

    comments.layer.borderWidth = 2.0f;
    comments.layer.borderColor = [[UIColor blackColor] CGColor];
    comments.layer.cornerRadius = 5;
    comments.layer.masksToBounds = YES;

    comments.text=@"";

    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;

    [[[ServiceConsumer alloc] init] getDispositionsByUser:[super getUserInfo] :^(id json) {
        dispositions = json;
        [dispositions insertObject:[[Disposition alloc] initWithCode:@"" Description:@""] atIndex:0];
    }];

    [[[ServiceConsumer alloc] init] getProductsByUser:[super getUserInfo] :^(id json) {
        products = json;
        [products insertObject:[[Product alloc] initWithCode:@"" Description:@""] atIndex:0];
        
        [HUD hide:YES];
    }];
}

- (void)viewDidUnload
{
    [self setDispositionText:nil];
    [self setProductText:nil];
    [self setSaleText:nil];
    [self setProductText1:nil];
    [self setSaleText1:nil];
    [self setProductText2:nil];
    [self setSaleText2:nil];
    [self setProductText3:nil];
    [self setSaleText3:nil];
    [self setProductText4:nil];
    [self setSaleText4:nil];
    [self setMainContainer:nil];
    [self setViewContainer1:nil];
    [self setViewContainer2:nil];
    [self setViewContainer3:nil];
    [self setViewContainer4:nil];
    [self setComments:nil];
    [self setBtnUpdate:nil];
    
    [self setDateTimeLabel:nil];
    [self setNameLabel:nil];
    [self setAddressLabel:nil];
    [self setCityLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    //determine if single tab has occured in response to button touch
    CGPoint touchPoint=[gesture locationInView:mainContainer];
    CGRect frame = self.btnUpdate.frame;
    if(touchPoint.x>=frame.origin.x && touchPoint.x<=frame.origin.x+frame.size.width
       && touchPoint.y>=frame.origin.y && touchPoint.y<=frame.origin.y+frame.size.height)
    {
        [self update:nil];
    }
    else{
        
        [dispositionText resignFirstResponder];
        [productText resignFirstResponder];
        [saleText resignFirstResponder];
        [productText1 resignFirstResponder];
        [saleText1 resignFirstResponder];
        [productText2 resignFirstResponder];
        [saleText2 resignFirstResponder];
        [productText3 resignFirstResponder];
        [saleText3 resignFirstResponder];
        [productText4 resignFirstResponder];
        [saleText4 resignFirstResponder];
        [comments resignFirstResponder];
    }
}
-(NSString*)getProductIdByProductText:(NSString*)text {
    for (int i=0;i<[products count];i++) {
        if([((Product*)[products objectAtIndex:i]).descr isEqualToString:text])
            return ((Product*)[products objectAtIndex:i]).code;
    }
    return @"";
}

-(NSString*)getDispositionIdByDispositionText:(NSString*)text {
    for (int i=0;i<[dispositions count];i++) {
        if([((Disposition*)[dispositions objectAtIndex:i]).descr isEqualToString:text])
            return ((Disposition*)[dispositions objectAtIndex:i]).code;
    }
    return @"";
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textBox = textField;
    
    if(textBox==dispositionText || textBox==productText || textBox==productText1 || textBox==productText2 || textBox==productText3 || textBox==productText4) {
        [textBox setInputView:picker];
    
        [picker reloadAllComponents];
        if(textBox==productText || textBox==productText1 || textBox==productText2 || textBox==productText3 || textBox==productText4){
            for (int i=0;i<[products count];i++) {
                if([((Product*)[products objectAtIndex:i]).descr isEqualToString:textField.text])
                    [picker selectRow:i inComponent:0 animated:YES];
            }
        }
        else{
            for (int i=0;i<[dispositions count];i++) {
                if([((Disposition*)[dispositions objectAtIndex:i]).descr isEqualToString:textField.text])
                    [picker selectRow:i inComponent:0 animated:YES];
            }
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL didResign = [textField resignFirstResponder];
    if (!didResign) return NO;
    
    if ([textField isKindOfClass:[NextUITextField class]]) {
        if (((NextUITextField *) textField).nextField != nil)
            [((NextUITextField *) textField).nextField becomeFirstResponder];
    }
    
    return YES;
}


#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(textBox==dispositionText){
        return [dispositions count];
    }
    else if(textBox==productText || textBox==productText1 || textBox==productText2 || textBox==productText3 || textBox==productText4){
        return [products count];
    }
    else
        return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(textBox==dispositionText){
        return ((Disposition *)[dispositions objectAtIndex:row]).descr;
    }
    else if (textBox==productText || textBox==productText1 || textBox==productText2 || textBox==productText3 || textBox==productText4) {
        return ((Product *)[products objectAtIndex:row]).descr;
    }
    else
        return @"";
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(textBox==dispositionText){
        textBox.text = ((Disposition *)[dispositions objectAtIndex:row]).descr;
    }
    else if( textBox==productText || textBox==productText1 || textBox==productText2 || textBox==productText3 || textBox==productText4){
        textBox.text = ((Product *)[products objectAtIndex:row]).descr;
    }
    else
        textBox.text = @"";
}



-(IBAction)update:(id)sender {
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;

    
    NSMutableArray *productArray = [NSMutableArray arrayWithObjects:[self getProductIdByProductText:productText.text],
                                    [self getProductIdByProductText:productText1.text],
                                    [self getProductIdByProductText:productText2.text],
                                    [self getProductIdByProductText:productText3.text],
                                    [self getProductIdByProductText:productText4.text],
                                    nil];
    NSMutableArray *saleArray = [NSMutableArray arrayWithObjects:saleText.text,
                                 saleText1.text,
                                 saleText2.text,
                                 saleText3.text,
                                 saleText4.text,
                                 nil];
    
    [[[ServiceConsumer alloc] init] updateAppointmentId:[self apptId]
                                           withUserInfo:[super getUserInfo]
                                            Disposition:[self getDispositionIdByDispositionText:dispositionText.text]
                                               Products:productArray
                                                  Sales:saleArray
                                               Comments:comments.text
                                                       :^(id json)  {

        [HUD hide:YES];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Appointment" message:@"Appointment Updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }];
}

@end





