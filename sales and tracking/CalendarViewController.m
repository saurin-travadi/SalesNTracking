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

@implementation CalendarViewController {
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
    
    [[[ServiceConsumer alloc] init] getSalesAppointments:[super getUserInfo] :^(id json) {
        
        [HUD hide:YES];
        
        appointments = json;
        [self.tableView reloadData];

    }];
}

#pragma tableview events
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appointments count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Appointment *appt = [appointments objectAtIndex:indexPath.row];
    cell.textLabel.text = appt.apptDate;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",appt.numAppts];
    
    
    return cell;
}

@end
