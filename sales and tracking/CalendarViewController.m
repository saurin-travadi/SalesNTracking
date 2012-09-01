//
//  CalendarViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 8/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalendarViewController.h"
#import "ServiceConsumer.h"
#import "Appointment.h"
#import "AppointmentsViewController.h"

@implementation CalendarViewController {
    NSMutableArray *jobs;
    KalViewController *kal;
}

@synthesize selectedDate;

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
    
    UIBarButtonItem *showAndSelectToday = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:self action:@selector(showSelectToday)];
    self.navigationItem.rightBarButtonItem = showAndSelectToday;
    
    apptQueue = dispatch_queue_create("rjr.sales-and-tracking", NULL);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setToolbarHidden:YES animated:NO];

    [self getJobs];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"appointmentsSegue"]) {
        [[segue destinationViewController] setDateTime:[sender description]];
    }
}

#pragma mark private methods

- (void)showSelectToday
{
    [kal showAndSelectDate:[NSDate date]];
}

- (void)showSelectedDate:(NSDate*)date
{
    [kal showAndSelectDate:date];
}


-(void)getJobs
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] getSalesAppointments:[super getUserInfo] :^(id json) {
        
        //Now configure calendar, if calendar is getting reloaded, load it with previous selection
        kal = [[KalViewController alloc] init];
        
        kal.delegate = self;
        kal.dataSource = self;
        
        if(selectedDate !=NULL){
            [self showSelectedDate:selectedDate];
        }
        
        [self.view addSubview:kal.view];
        
        CGRect frame=self.view.bounds;
        frame.origin.y=60;
        kal.calendarView.frame = frame;
        
        jobs = json;
        [HUD hide:YES];
    }];
}

static BOOL IsDateBetweenInclusive(NSDate *date, NSDate *begin, NSDate *end)
{
    return [date compare:begin] != NSOrderedAscending && [date compare:end] != NSOrderedDescending;
}

#pragma mark KalDataSource protocol conformance

- (void)presentingDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate delegate:(id<KalDataSourceCallbacks>)delegate
{
    dispatch_async(apptQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate loadedDataSource:self];
        });
    });
}

- (NSArray *)markedDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
    NSMutableArray *dates= [[NSMutableArray alloc] init];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];

    //filter jobs falling in current month view
    for (Job *job in jobs) {

        NSDate *date = [dateFormat dateFromString:[job.apptDate substringToIndex:10]];
        if(IsDateBetweenInclusive(date, fromDate, toDate))
            [dates addObject:date];
        
    }
   
    return dates;
}

- (void)loadItemsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    for (Job *job in jobs) {
        
        NSDate *date = [dateFormat dateFromString:[job.apptDate substringToIndex:10]];
        if([date isEqualToDate:fromDate]) {
            selectedDate = fromDate;
            [self performSegueWithIdentifier:@"appointmentsSegue" sender:[fromDate description]];
            return;
        }
    }
    [self showSelectedDate:fromDate];
}

- (void)removeAllItems
{

}

#pragma mark TableView protocol - KalCalendar needs it
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


@end
