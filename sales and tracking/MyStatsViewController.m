//
//  MyStatesViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 9/1/12.
//
//

#import "MyStatsViewController.h"
#import "MyStat.h"

@implementation MyStatsViewController {
    NSMutableArray *stats;
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
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    [self getStats];
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

-(void)getStats
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] getSalesStatsForUser:[super getUserInfo] :^(id json) {
        
        stats=json;
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
    return [stats count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    CGRect frame = cell.frame;
    frame.origin.y = frame.size.height-10;
    frame.size.height = 10;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.image = [UIImage imageNamed:@"DottedLine.png"];
    [cell addSubview:imgView];
    
    MyStat* stat = [stats objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@" %@",stat.descr];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ ", stat.statValue];
    
    return cell;
}

@end
