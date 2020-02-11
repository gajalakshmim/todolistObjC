//
//  TaDaTableViewController.m
//  TaDaList
//
//  Created by Satheeshkumar Thiyagarajan on 6/10/15.
//  Copyright (c) 2015 Satheeshkumar Thiyagarajan. All rights reserved.
//
#import "TaDaTableViewController.h"
#import "AddViewController.h"
#import "TaDaItem.h"

@interface TaDaTableViewController ()

@property NSMutableArray *items;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButtonItem;

@end

@implementation TaDaTableViewController


-(IBAction)unwindToList:(UIStoryboardSegue*)segue
{
  //  NSMutableArray *dictArray =[NSMutableArray array];
    AddViewController *source=[segue sourceViewController];
    TaDaItem *newItem = [[TaDaItem alloc]initWithItem:source.item];
    if (newItem!=Nil) {
        [self.items addObject:newItem];
        [self.tableView reloadData];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:newItem.itemName,@"ItemName",[NSNumber numberWithBool:newItem.completed],@"Completion",newItem.creationDate,@"CreatedDate",nil];
        [self.dictArray addObject:dict];
        [self saveFinalData];
    }
    
}


-(void)saveFinalData{
    if ([self.dictArray count]) {
        [self.dictArray writeToFile:@"/tmp/List.plist" atomically:YES];
        }
}


-(void)loadInitialData
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/tmp/List.plist"]) {
        NSArray *loadList=[NSArray arrayWithContentsOfFile:@"/tmp/List.plist"];
        for (NSDictionary *redict in loadList) {
            [self.dictArray addObject:redict];
            TaDaItem *loadItem=[[TaDaItem alloc]init];
            loadItem.itemName =[redict objectForKey:@"ItemName"];
            // *s =[redict objectForKey:@"Completion"];
            loadItem.completed= [[redict objectForKey:@"Completion"] boolValue];
            loadItem.creationDate=[NSDate dateWithTimeInterval:0 sinceDate:[redict objectForKey:@"CreatedDate"]];
            [self.items addObject:loadItem];
        }
        
    }

}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.items=[[NSMutableArray alloc]init];
    self.dictArray=[[NSMutableArray alloc]init];
    self.navigationItem.leftBarButtonItem = [self editButtonItem];
    [self loadInitialData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototype" forIndexPath:indexPath];
    
    TaDaItem *item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.itemName;
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    cell.detailTextLabel.text=[formatter stringFromDate:(NSDate*)item.creationDate];
    if (item.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing   animated:animated];
    [self.tableView setEditing:editing animated:animated];
    if (editing) {
        self.addButtonItem.enabled = NO;
    } else {
        self.addButtonItem.enabled = YES;
    }
    //editing=!editing;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteRow:indexPath];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self setEditing:YES animated:YES];
//}
//
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self setEditing:NO animated:YES];
//}


-(void)deleteRow:(NSIndexPath*)indexPath{
    [self.items removeObjectAtIndex:indexPath.row];
    [self.dictArray removeObjectAtIndex:indexPath.row];
    [self saveFinalData];
   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSMutableArray *reorderingRows=[self.items mutableCopy];
 TaDaItem *stringToMove = [reorderingRows objectAtIndex:fromIndexPath.row];
 [reorderingRows removeObjectAtIndex:fromIndexPath.row];
 [reorderingRows insertObject:stringToMove atIndex:toIndexPath.row];
    self.items=[reorderingRows mutableCopy];
    
    NSMutableDictionary *oldDict=[self.dictArray objectAtIndex:fromIndexPath.row];
    [self.dictArray removeObjectAtIndex:fromIndexPath.row];
    [self.dictArray insertObject:oldDict atIndex:toIndexPath.row];
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    if ([self.items count]==1) {
        return NO;
    }
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TaDaItem *tappedItem = [self.items objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    
    NSMutableDictionary *oldDict=[self.dictArray objectAtIndex:indexPath.row];
    NSMutableDictionary *newDict=[[NSMutableDictionary alloc]initWithDictionary:oldDict];
    newDict =[NSMutableDictionary dictionaryWithObjectsAndKeys:tappedItem.itemName,@"ItemName",[NSNumber numberWithBool:tappedItem.completed],@"Completion",tappedItem.creationDate,@"CreatedDate",nil];

    [self.dictArray replaceObjectAtIndex:indexPath.row withObject:newDict];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self saveFinalData];
}

    @end
