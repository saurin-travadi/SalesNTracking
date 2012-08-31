//
//  AppointmentsViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 8/29/12.
//
//

#import "AppointmentsViewController.h"
#import "ServiceConsumer.h"
#import "Appointment.h"

@implementation AppointmentsViewController {
    NSMutableArray *appointments;
}

@synthesize tableView;

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
    
    [self getAppointments];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)getAppointments
{
    
    [[[ServiceConsumer alloc] init] getSalesAppointmentsByDate: @"06/18/2012" withUserInfo:[super getUserInfo] :^(id json) {
        
        [HUD hide:YES];
        
        appointments = json;
        [self.tableView reloadData];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"customerCell";
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Appointment *appt = [appointments objectAtIndex:indexPath.row];
    ((UILabel*)[cell viewWithTag:0]).text = appt.apptDate;
    ((UILabel*)[cell viewWithTag:1]).text = appt.numAppts;
    
    return cell;
}



@end
