//
//  PLFMasterViewController.m
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/29/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import "PLFMasterViewController.h"
#import "PLFhttpClient.h"
#import "NSDictionary+PLFbooks.h"
#import "PLFtableCell.h"

@interface PLFMasterViewController ()
@property (strong, nonatomic) NSArray *booksArray;
@end

@implementation PLFMasterViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadBooks];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)addBtnToAddBookViewController:(id)sender {
    [self performSegueWithIdentifier:@"addBookSegue" sender:self];
}

#pragma mark - Public
- (void)loadBooks {

    //successBlock
    void (^submissionHandler)(NSArray *) = ^(NSArray *returnData) {
        
        self.booksArray = returnData;
        NSLog(@"%@",self.booksArray);
        [self.tableView reloadData];
    };
    
    //errorBlock
    void (^errorHandler)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error){
    
        NSLog(@"%@",error);
        return;
    };
    
    [[PLFhttpClient sharedPLFHTTPClient] getAllBooksWithSuccessHandler:submissionHandler
                                                   andWithErrorHandler:errorHandler];

}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetailSegue"]) {
        
    }
    if ([[segue identifier] isEqualToString:@"addBookSegue"]) {
        
    }
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"PLFCell";
    PLFtableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        PLFtableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(self.booksArray){
        NSDictionary *eachBook = self.booksArray[indexPath.row];
        
        if([[eachBook title] length] > 0){
            cell.title.text = [eachBook title];
            cell.author.text = [eachBook author];
        }
    }
    
    NSLog(@"%@",self.booksArray);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"showDetailSegue" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.booksArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //default height
    return 80;
}


@end
