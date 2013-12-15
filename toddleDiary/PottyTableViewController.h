//
//  PottyTableViewController.h
//  toddleDiary
//
//  Created by Barry Skalrud on 23/11/2013.
//  Copyright (c) 2013 barica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PottyEntryCell.h"

@interface PottyTableViewController : UITableViewController
    @property NSMutableArray *children;
    @property NSMutableDictionary *pottyItems;

-(void) weeActionPressed:(UITableViewCell *)cell;
-(void) pooActionPressed:(UITableViewCell *)cell;
-(void) accidentActionPressed:(UITableViewCell *)cell;
-(void) bothActionPressed:(UITableViewCell *)cell;
@end
