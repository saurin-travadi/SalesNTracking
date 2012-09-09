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
#import "AppDelegate.h"

@implementation AppointmentUpdateViewController {
    UIPickerView *picker;
    
    NSMutableArray *products;
    NSMutableArray *dispositions;
    
    UITextField *textBox;
    NSTimer* showDecimalPointTimer;
    UIButton *doneButton;
}

@synthesize apptObject;

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
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [mainContainer addGestureRecognizer:singleTap];
    
    dateTimeLabel.text = apptObject.apptDate;
    nameLabel.text=apptObject.custName;
    addressLabel.text=apptObject.address;
    cityLabel.text=apptObject.cSZ;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
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

    [self performSelector:@selector(loadDefaults) withObject:nil afterDelay:1];
    [[[ServiceConsumer alloc] init] getDispositionsByUser:[super getUserInfo] :^(id json) {
        dispositions = json;
        [dispositions insertObject:[[Disposition alloc] initWithCode:@"" Description:@""] atIndex:0];
    }];

    [[[ServiceConsumer alloc] init] getProductsByUser:[super getUserInfo] :^(id json) {
        products = json;
        [products insertObject:[[Product alloc] initWithCode:@"" Description:@""] atIndex:0];
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
    
    [self setApptObject:nil];

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
        [self.btnUpdate setHighlighted:YES];
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

-(void)loadDefaults {
    if([dispositions count]<=0 || [products count]<=0){        //wait for service method to load product / disposition array
        [self performSelector:@selector(loadDefaults) withObject:nil afterDelay:1];
        return;
    }

    [HUD hide:YES];
                              
    dispositionText.text = [self getDispositionTextById:apptObject.disp];
    productText.text=[self getProductTextById: apptObject.productID1];
    productText1.text = [self getProductTextById: apptObject.productID2 ];
    productText2.text=[self getProductTextById: apptObject.productID3 ];
    productText3.text=[self getProductTextById: apptObject.productID4 ];
    productText4.text=[self getProductTextById: apptObject.productID5 ];
    
    if([apptObject.sale1 isEqualToString:@"$0"])
        saleText.text = @"";
    else
        saleText.text=[apptObject.sale1 substringFromIndex:1] ;         //remove $

    if([apptObject.sale2 isEqualToString:@"$0"])
        saleText1.text=@"";
    else
        saleText1.text=[apptObject.sale2 substringFromIndex:1] ;

    if([apptObject.sale2 isEqualToString:@"$0"])
        saleText2.text=@"";
    else
        saleText2.text=[apptObject.sale3 substringFromIndex:1] ;

    if([apptObject.sale4 isEqualToString:@"$0"])
        saleText3.text=@"";
    else
    saleText3.text=[apptObject.sale4 substringFromIndex:1] ;

    if([apptObject.sale5 isEqualToString:@"$0"])
        saleText4.text=@"";
    else
    saleText4.text=[apptObject.sale5 substringFromIndex:1] ;
    
    comments.text = apptObject.presNotes;
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

-(NSString*)getProductTextById:(NSString*)text {
    for (int i=0;i<[products count];i++) {
        if([((Product*)[products objectAtIndex:i]).code isEqualToString:text])
            return ((Product*)[products objectAtIndex:i]).descr;
    }
    return @"";
}

-(NSString*)getDispositionTextById:(NSString*)text {
    for (int i=0;i<[dispositions count];i++) {
        if([((Disposition*)[dispositions objectAtIndex:i]).code isEqualToString:text])
            return ((Disposition*)[dispositions objectAtIndex:i]).descr;
    }
    return @"";
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [doneButton removeFromSuperview];
    return  YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textBox = textField;
    
    if(textBox==dispositionText || textBox==productText || textBox==productText1 || textBox==productText2 || textBox==productText3 || textBox==productText4) {
        [self addDone2Picker];
        [textBox setInputView:nil];
    
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
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)note {
    if( textBox==saleText || textBox==saleText1 || textBox==saleText2 || textBox==saleText3 || textBox==saleText4 ){
            
        showDecimalPointTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(addDoneButton) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:showDecimalPointTimer forMode:NSDefaultRunLoopMode];
    }
}

-(void)addDoneButton {
    if( textBox==saleText || textBox==saleText1 || textBox==saleText2 || textBox==saleText3 || textBox==saleText4) {
        //Add a button to the top, above all windows
        NSArray *allWindows = [[UIApplication sharedApplication] windows];
        int topWindow = [allWindows count] - 1;
        UIWindow *keyboardWindow = [allWindows objectAtIndex:topWindow];
        
        // create custom button
        doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame = CGRectMake(0, 427, 105, 53);
        doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [doneButton setTitleColor:[UIColor colorWithRed:77.0f/255.0f green:84.0f/255.0f blue:98.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];    

        [doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [keyboardWindow addSubview:doneButton];
    }
    else if (textBox==productText || textBox==productText|| textBox==productText2 || textBox==productText3 || textBox==productText4){
        
    }
}

-(void) doneButtonPressed {

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
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    [doneButton removeFromSuperview];
}


UIActionSheet *actionSheet;
- (void)addDone2Picker {
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    CGRect ToolBarFrame= CGRectMake(0, 0, 320, 44);
    CGRect pickerFrame =  CGRectMake(0, 44, 320, 100);
    picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator=YES;
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:ToolBarFrame];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    [barItems addObject:doneBtn];
    
    [pickerToolbar setItems:barItems animated:YES];
    
    [actionSheet addSubview:pickerToolbar];
    [actionSheet addSubview:picker];
    [actionSheet showInView:mainContainer];
    [actionSheet setBounds:CGRectMake(0,0,320, 464)];
}


- (void)keyboardDidHide:(NSNotification *)note
{
    [doneButton removeFromSuperview];
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
    
    [[[ServiceConsumer alloc] init] updateAppointmentId:apptObject.id
                                           withUserInfo:[super getUserInfo]
                                            Disposition:[self getDispositionIdByDispositionText:dispositionText.text]
                                               Products:productArray
                                                  Sales:saleArray
                                               Comments:comments.text
                                                       :^(id json)  {

        [HUD hide:YES];
        [self.btnUpdate setHighlighted:NO];
                                                           
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Appointment" message:@"Appointment Updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }];
}

@end





