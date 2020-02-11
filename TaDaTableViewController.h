//
//  TaDaTableViewController.h
//  TaDaList
//
//  Created by Satheeshkumar Thiyagarajan on 6/10/15.
//  Copyright (c) 2015 Satheeshkumar Thiyagarajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaDaTableViewController : UITableViewController
@property NSMutableArray* dictArray;


-(IBAction)unwindToList:(UIStoryboardSegue*)segue;

-(void)saveFinalData;

@end
