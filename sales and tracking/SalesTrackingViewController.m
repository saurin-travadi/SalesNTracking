//
//  SalesTrackingViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 9/2/12.
//
//

#import "SalesTrackingViewController.h"
#import "ServiceConsumer.h"



@implementation SalesTrackingViewController {
    NSMutableArray *array;
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
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:NO];

    [self getSales];
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

-(void)getSales
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] getSalesTrackingForUser:[super getUserInfo] :^(id json) {
        
        array = json;
        [self.tableView reloadData];
 
        [HUD hide:YES];
        
    }];
}

#pragma tableview events
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    MySales *sale = [array objectAtIndex:indexPath.row];
    ((UILabel *)[cell viewWithTag:100]).text = sale.custName;
    ((UILabel *)[cell viewWithTag:101]).text = sale.productID;
    ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"%@ %@",[sale.contractDate substringToIndex:10],[[sale.contractDate substringFromIndex:11] substringToIndex:5]];;
    ((UILabel *)[cell viewWithTag:103]).text = sale.grossAmount;
    ((UILabel *)[cell viewWithTag:104]).text = sale.jobStatusDescr;
    
    return cell;
}



@end




