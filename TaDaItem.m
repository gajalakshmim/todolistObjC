//
//  TaDaItem.m
//  TaDaList
//
//  Created by Satheeshkumar Thiyagarajan on 6/10/15.
//  Copyright (c) 2015 Satheeshkumar Thiyagarajan. All rights reserved.
//

#import "TaDaItem.h"

@implementation TaDaItem

-(instancetype)init{
    self=[super init];
    if (self) {
        _creationDate=[NSDate date];
        _completed = (BOOL) NO;
    }
    return self;
}
-(instancetype)initWithItem:(TaDaItem*)newItem{
        if(newItem){
            _itemName = [newItem.itemName copy];
            _completed =newItem.completed;
            _creationDate=newItem.creationDate;
        }
    return self;
}

//-(NSString*)description{
//    return[NSString stringWithFormat:@"%@,%d,%@", self.itemName,self.completed?1:0,self.creationDate];
//    
//}
@end
