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
#import "AppointementDetail.h"

@implementation AppointmentsViewController {
    NSMutableArray *appointments;
}


@synthesize tableView, dateTime;

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
    
    [self getAppointmentByDateTime]; //get appointments for selected date and reload table
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


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"appointmentDetailSegue"]) {
        //[[segue destinationViewController] setApptDateTime:@"":[sender description]];
    }
}

-(void)getAppointmentByDateTime
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] getSalesAppointmentsByDate:[dateTime substringToIndex:10] withUserInfo:[super getUserInfo] :^(id json) {
        
        appointments = json;
        [self.tableView reloadData];
        
        [HUD hide:YES];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appointments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Appointment *appt = [appointments objectAtIndex:indexPath.row];

    ((UILabel *)[cell viewWithTag:101]).text = [NSString stringWithFormat:@"%@ %@",[appt.apptDate substringToIndex:10],[[appt.apptDate substringFromIndex:11] substringToIndex:5]];
    ((UILabel *)[cell viewWithTag:102]).text = [appt custName];
    ((UILabel *)[cell viewWithTag:103]).text = [appt cSZ];
        
    return cell;
}



@end
