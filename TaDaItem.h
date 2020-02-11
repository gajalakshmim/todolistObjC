//
//  TaDaItem.h
//  TaDaList
//
//  Created by Satheeshkumar Thiyagarajan on 6/10/15.
//  Copyright (c) 2015 Satheeshkumar Thiyagarajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaDaItem : NSObject

@property NSString* itemName;
@property BOOL completed;
@property NSDate* creationDate;

-(instancetype)init;
-(instancetype)initWithItem:(TaDaItem*)newItem;
@end
