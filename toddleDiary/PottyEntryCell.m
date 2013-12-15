//
//  PottyEntryCell.m
//  toddleDiary
//
//  Created by Barry Skalrud on 23/11/2013.
//  Copyright (c) 2013 barica. All rights reserved.
//

#import "PottyEntryCell.h"
#import "PottyTableViewController.h"

@implementation PottyEntryCell

- (UIButton *) createButton:(NSString *)name x:(float)x y:(float)y width:(float)width height:(float)height
{
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   
    [actionBtn setTitle:name forState:UIControlStateNormal];
    
    actionBtn.frame = CGRectMake(x, y, width, height);
    actionBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0f];
    return(actionBtn);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *weeAction = [self createButton:@"Wee"
                                               x:80.0f
                                               y:20.0f
                                           width:60.0f
                                          height:30.0f];
        [weeAction addTarget:self
                      action:@selector(weeActionPressed:)
            forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:weeAction];
        
        UIButton *pooAction = [self createButton:@"Poo"
                                               x:150.0f
                                               y:20.0f
                                           width:60.0f
                                          height:30.0f];
        [pooAction addTarget:self
                      action:@selector(pooActionPressed:)
            forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:pooAction];
        
        UIButton *accidentAction = [self createButton:@"Accident"
                                                    x:80.0f
                                                    y:50.0f
                                                width:60.0f
                                               height:30.0f];
        [accidentAction addTarget:self
                      action:@selector(accidentActionPressed:)
            forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:accidentAction];
        
        UIButton *bothAction = [self createButton:@"Both"
                                                x:150.0f
                                                y:50.0f
                                            width:60.0f
                                           height:30.0f];
        [bothAction addTarget:self
                      action:@selector(bothActionPressed:)
            forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:bothAction];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 0, 30.0f)];
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0f];
        [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.nameLabel];
        
        
        self.summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 0, 30.0f)];
        self.summaryLabel.textColor = [UIColor blackColor];
        self.summaryLabel.textAlignment = NSTextAlignmentRight;
        self.summaryLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0f];
        [self.summaryLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        self.thumb = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self.thumb setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.thumb];
        
        [self.contentView addSubview:self.summaryLabel];
        UILabel *nameLabel = self.nameLabel;
        UILabel *summaryLabel = self.summaryLabel;
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(nameLabel, summaryLabel);
   
        //     NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute: NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.summaryLabel
     //                                                        attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-12.0];
       
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-[nameLabel][summaryLabel]-|" options:0 metrics:nil views:viewsDictionary];
         //                                                        attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-12.0];
        [self addConstraints:constraints];
    }
    return self;
}

- (void)weeActionPressed:(id)sender
{
    PottyTableViewController *controller = (PottyTableViewController *) self.tableViewController;
    [controller weeActionPressed:self];
}
- (void)pooActionPressed:(id)sender
{
    PottyTableViewController *controller = (PottyTableViewController *) self.tableViewController;
    [controller pooActionPressed:self];
}
- (void)accidentActionPressed:(id)sender
{
    PottyTableViewController *controller = (PottyTableViewController *) self.tableViewController;
    [controller accidentActionPressed:self];
}
- (void)bothActionPressed:(id)sender
{
    PottyTableViewController *controller = (PottyTableViewController *) self.tableViewController;
    [controller bothActionPressed:self];
}

    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
