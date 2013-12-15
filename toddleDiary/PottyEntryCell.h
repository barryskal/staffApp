//
//  PottyEntryCell.h
//  toddleDiary
//
//  Created by Barry Skalrud on 23/11/2013.
//  Copyright (c) 2013 barica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PottyEntryCell : UITableViewCell
    @property (nonatomic) IBOutlet UILabel *nameLabel;
    @property (nonatomic) IBOutlet UILabel *summaryLabel;
    
    @property (nonatomic) IBOutlet UIImageView *thumb;
    @property (weak) NSNumber *child_id;
    @property (weak, nonatomic) UITableViewController *tableViewController;
@end
