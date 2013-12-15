//
//  PottyInfoItem.h
//  toddleDiary
//
//  Created by Barry Skalrud on 23/11/2013.
//  Copyright (c) 2013 barica. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PottyInfoItem : NSObject
    
    typedef enum PottyActionType : NSUInteger {
        WEE_POTTY,
        WEE_NAPPY,
        POO_POTTY,
        POO_NAPPY,
        BOTH_POTTY,
        BOTH_NAPPY,
        ACCIDENT
    } PottyActionType;
    
    @property NSDate *dateOfEvent;
    @property PottyActionType pottyAction;
    @property NSString *notes;
@end
