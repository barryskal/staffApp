//
//  PottyTableViewController.m
//  toddleDiary
//
//  Created by Barry Skalrud on 23/11/2013.
//  Copyright (c) 2013 barica. All rights reserved.
//

#import "PottyTableViewController.h"
#import "ChildData.h"
#import "PottyInfoItem.h"
#import "PottyEntryCell.h"

@interface PottyTableViewController ()

@end

@implementation PottyTableViewController
{
    UITableView *tableView;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    ChildData *child1 = [ChildData new];
    child1.fullname = @"Dean William Skalrud";
    child1.nickname = @"Dean";
    child1.picture = [UIImage imageNamed:@"dean.jpg"];
    child1.child_id = @100;
    
    ChildData *child2 = [ChildData new];
    child2.fullname = @"Marc Alexander Skalrud";
    child2.nickname = @"Marc";
    child2.picture = [UIImage imageNamed:@"marc.jpg"];
    child2.child_id = @200;

    ChildData *child3 = [ChildData new];
    child3.fullname = @"Logan William Benson";
    child3.nickname = @"Logan";
    child3.picture = [UIImage imageNamed:@"logan.jpg"];
    child3.child_id = @300;

    self.children = [NSMutableArray arrayWithObjects:child1,child2,child3, nil];
    self.pottyItems = [NSMutableDictionary new];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // init table view
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.backgroundColor = [UIColor cyanColor];
    tableView.rowHeight = 90.0;
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd MMM YY"];
    self.navigationItem.title = [dateFormatter stringFromDate:currDate];
    
   // [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // add to canvas
    [self.view addSubview:tableView];
    [self.tableView registerClass:[PottyEntryCell class] forCellReuseIdentifier:@"PottyEntryCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.children count];
}

- (UITableViewCell *)tableView:(UITableView *)inTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PottyEntryCell";
    PottyEntryCell *cell = [inTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PottyEntryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    ChildData *child = [self.children objectAtIndex:indexPath.row];
    cell.nameLabel.text = child.nickname;
    
    UIImage *img = [self resize:child.picture width:60 height:60];
    img = [self makeRoundedImage:img radius:3.3f];
    cell.thumb.image = img;
    cell.child_id = child.child_id;
    cell.tableViewController = self;
    
    // Calculate summary label
    NSString *summaryLabel = [self calculateSummaryLabel:child.child_id];
    cell.summaryLabel.text = summaryLabel;
    return cell;
}

-(UIImage *)resize: (UIImage *) inImage width:(float) inWidth height:(float) inHeight
{
    CGRect rect = CGRectMake(0, 0, inWidth, inHeight);
    UIGraphicsBeginImageContext(rect.size);
    [inImage drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

-(UIImage *)makeRoundedImage:(UIImage *) inImage
                      radius: (float) inRadius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, inImage.size.width, inImage.size.height);
    imageLayer.contents = (id) inImage.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = inRadius;
    
    UIGraphicsBeginImageContext(inImage.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

- (NSString *) calculateSummaryLabel:(NSNumber *)inChildId
{
    NSMutableArray *childsPottyItems = [self.pottyItems objectForKey:inChildId];
    
    if (childsPottyItems == nil)
         return @"";

    NSInteger wee = 0;
    NSInteger poo = 0;
    NSInteger both = 0;
    NSInteger accidents = 0;
    
    for (PottyInfoItem *pottyItem in childsPottyItems)
    {
        switch (pottyItem.pottyAction)
        {
            case (WEE_NAPPY):
                wee++;
                break;
            case (POO_NAPPY):
                poo++;
                break;
            case (ACCIDENT):
                accidents++;
                break;
            default:
                both++;
        }
    }
    
    return ([NSString stringWithFormat:@"%dW, %dP, %dB, %dA", wee, poo, both, accidents]);
}

- (void)weeActionPressed:(PottyEntryCell *)cell
{
    NSIndexPath *pathToCell = [tableView indexPathForCell:cell];
    NSArray *pathToCellArray = [NSArray arrayWithObject:pathToCell];
    
    PottyEntryCell *pottyCell = (PottyEntryCell *)cell;
    
    [self addPottyItem:WEE_NAPPY childId:pottyCell.child_id];
    [self redrawCells:pathToCellArray];
}

- (void)addPottyItem:(PottyActionType)pottyAction childId:(NSNumber *)childId
{
    PottyInfoItem *newItem = [PottyInfoItem new];
    newItem.pottyAction = pottyAction;
    newItem.dateOfEvent = [NSDate new];
    
    NSMutableArray *childsPottyItems = [self.pottyItems objectForKey:childId];
    
    if (childsPottyItems == nil)
    {
        childsPottyItems = [NSMutableArray new];
        [self.pottyItems setObject:childsPottyItems forKey:childId];
    }
    
    // Redraw table cell
    [childsPottyItems addObject:newItem];
}

- (void)redrawCells:(NSArray *)pathToCellArray
{
    [tableView beginUpdates];
    [tableView reloadRowsAtIndexPaths:pathToCellArray withRowAnimation:UITableViewRowAnimationNone];
    [tableView endUpdates];
}

- (void)pooActionPressed:(PottyEntryCell *)cell
{
    NSIndexPath *pathToCell = [tableView indexPathForCell:cell];
    NSArray *pathToCellArray = [NSArray arrayWithObject:pathToCell];

    PottyEntryCell *pottyCell = (PottyEntryCell *)cell;
    
    [self addPottyItem:POO_NAPPY childId:pottyCell.child_id];
    [self redrawCells:pathToCellArray];
}

- (void)bothActionPressed:(PottyEntryCell *)cell
{
    NSIndexPath *pathToCell = [tableView indexPathForCell:cell];
    NSArray *pathToCellArray = [NSArray arrayWithObject:pathToCell];
    
    PottyEntryCell *pottyCell = (PottyEntryCell *)cell;
    
    [self addPottyItem:BOTH_NAPPY childId:pottyCell.child_id];
    [self redrawCells:pathToCellArray];
}

- (void)accidentActionPressed:(PottyEntryCell *)cell
{
    NSIndexPath *pathToCell = [tableView indexPathForCell:cell];
    NSArray *pathToCellArray = [NSArray arrayWithObject:pathToCell];
    
    PottyEntryCell *pottyCell = (PottyEntryCell *)cell;
    
    [self addPottyItem:ACCIDENT childId:pottyCell.child_id];
    [self redrawCells:pathToCellArray];
}
    
    /*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
