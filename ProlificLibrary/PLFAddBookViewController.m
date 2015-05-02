//
//  PLFAddBookViewController.m
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/29/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import "PLFAddBookViewController.h"
@interface PLFAddBookViewController ()

@end

@implementation PLFAddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)DoneBtnToMasterViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end