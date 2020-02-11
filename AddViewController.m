//
//  AddViewController.m
//  TaDaList
//
//  Created by Satheeshkumar Thiyagarajan on 6/10/15.
//  Copyright (c) 2015 Satheeshkumar Thiyagarajan. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;


@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SaveClick:(id)sender {
    [self prepareForSegue:nil sender:sender];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender!=self.saveButton) return;
    if (self.textField.text.length>0) {
        self.item =[[TaDaItem alloc]init];
        self.item.itemName=self.textField.text;
        self.item.completed=(BOOL)NO;
        return;
    }
   // Get the new view controller using [segue destinationViewController];
    // Pass the selected object to the new view controller.
}



@end
