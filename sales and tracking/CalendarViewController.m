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
    
    UIBarButtonItem *showAndSelectToday = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:self action:@selector(showAndSelectToday)];
    self.navigationItem.rightBarButtonItem = showAndSelectToday;

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

- (void)showAndSelectToday
{
    [kal showAndSelectDate:[NSDate date]];
}

-(void)getJobs
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] getSalesAppointments:[super getUserInfo] :^(id json) {
        
        //Now configure calendar
        kal = [[KalViewController alloc] init];
        kal.delegate = self;
        kal.dataSource = self;
        
        [self.view addSubview:kal.view];
        
        CGRect frame=self.view.bounds;
        frame.origin.y=60;
        kal.calendarView.frame = frame;

        //this is for debugging purpose
//        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,20)];
//        lbl.text = [NSString stringWithFormat:@"#of jobs: %d",[json count]];
//        lbl.textAlignment=UITextAlignmentCenter;
//        [self.view addSubview:lbl];
        
        jobs = json;
        [HUD hide:YES];
    }];
}

#pragma mark KalDataSource protocol conformance

- (void)presentingDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate delegate:(id<KalDataSourceCallbacks>)delegate
{
    //get all appointments for the month here
}

- (NSArray *)markedDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
    // synchronous callback on the main thread
    return nil;//[[self eventsFrom:fromDate to:toDate] valueForKeyPath:@"startDate"];
}

- (void)loadItemsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    [self performSegueWithIdentifier:@"appointmentsSegue" sender:[fromDate description]];
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
