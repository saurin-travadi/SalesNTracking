//
//  HomeViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 8/30/12.
//
//

#import "HomeViewController.h"
#import "ServiceConsumer.h"


@implementation HomeViewController {
    NSMutableArray *messages;
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
    
    UIBarButtonItem *logout =[super setBarButton:@"Log Out"];
    logout.target=self;
    logout.action=@selector(logout:);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:NO];

    [self getMessages];
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


#pragma tableview events
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [messages count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, cell.textLabel.frame.origin.y-10, cell.frame.size.width, 30)];
    view.backgroundColor = [UIColor lightGrayColor];
    [cell.textLabel sendSubviewToBack:view];
    [cell addSubview:view];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.textLabel.frame.origin.y-17, cell.frame.size.width, 30)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor blackColor];
    lbl.font=[UIFont systemFontOfSize:17];
    lbl.text = @"From";
    lbl.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    lbl.textAlignment = UITextAlignmentLeft;
    [view addSubview:lbl];
    
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [messages objectAtIndex:indexPath.row];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [messages objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont systemFontOfSize:17];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 50;
}

-(void)getMessages
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] getLoginMessages:[super getUserInfo] :^(id json) {
        
        [HUD hide:YES];
        
        messages = json;
        [self.tableView reloadData];
    }];
}

-(IBAction)logout:(id)sender {
    [super logout];
}

@end
