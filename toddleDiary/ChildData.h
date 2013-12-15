//
//  ChildData.h
//  toddleDiary
//
//  Created by Barry Skalrud on 23/11/2013.
//  Copyright (c) 2013 barica. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChildData : NSObject
    @property NSNumber *child_id;
    @property NSString *fullname;
    @property NSString *nickname;
    @property UIImage *picture;
    @property BOOL is_potty_trained;
@end
